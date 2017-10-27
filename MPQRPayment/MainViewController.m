//
//  ViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "MainViewController.h"
#import "MPQRService.h"
#import "LoginResponse.h"
#import "Transaction.h"
#import "PaymentInstrument.h"
#import "User.h"
#import "LoginViewController.h"
#import "LoginManager.h"
#import "UserManager.h"
#import "PaymentManager.h"
#import "PaymentViewController.h"
#import "TransactionListViewController.h"

@import FSPagerView;
@import MasterpassQRScanSDK;
@import AVFoundation;

@interface MainViewController ()<FSPagerViewDataSource, FSPagerViewDelegate>
{
    LoginViewController* loginVC;
}
@property (weak, nonatomic) IBOutlet UIView *sectionOne;
@property (weak, nonatomic) IBOutlet FSPagerView *pagerView;
@property (weak, nonatomic) IBOutlet UILabel *balanceDisplay;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    
    
    _pagerView.dataSource = self;
    _pagerView.delegate = self;
    _pagerView.itemSize = CGSizeMake(180*294/187, 180);
    _pagerView.transformer = [[FSPagerViewTransformer alloc] initWithType:FSPagerViewTransformerTypeOverlap];
    [_pagerView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString* strUsername = [LoginManager sharedInstance].loginInfo.user;
    if (strUsername) {
        [[MPQRService sharedInstance] getUserWithParameters:@{@"user_name":strUsername}
                                                    success:^(User* user){
                                                        [UserManager sharedInstance].currentUser = user;
                                                        [self reloadUserInterface];
                                                    } failure:^(NSError* error){
                                                        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"User Not Found" message:@"Related user with this account is not found. Please try again later or contact our administrator." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                        [alert show];
                                                    }];
        
    }
    [self reloadUserInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)openTransactionHistory:(id)sender {
    
    TransactionListViewController* transactionVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionListViewController"];
    [self.navigationController pushViewController:transactionVC animated:YES];
}

- (IBAction)startScan:(id)sender {
    if (![QRCodeReader isAvailable] || ![QRCodeReader supportsQRCode]) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self checkCameraPermission: ^{
        
        __block __weak QRCodeReader* reader;
        QRCodeReaderViewController* qrVC = [QRCodeReaderViewController readerWithBuilderBlock:^(QRCodeReaderViewControllerBuilder *builder){
            reader = builder.reader;
        }];
        
        //block to read the result
        [reader setCompletionWithBlock:^(NSString *result) {
            [reader stopScanning];
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [[PaymentManager sharedInstance] parseScannedCode:result withCompletionBlock:^(PaymentData* pdata, NSError* error){
                    if (pdata) {
                        PaymentViewController* pVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PaymentViewController"];
                        pVC.paymentData = pdata;
                        [self.navigationController pushViewController:pVC animated:YES];
                    }
                }];
            }];
        }];
        
        //block when cancel is pressed
        [qrVC setCompletionWithBlock:^(NSString *result) {
            [reader stopScanning];
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        
        [weakSelf.navigationController presentViewController:qrVC animated:true completion:nil];
    }];
}

# pragma mark - QRCodeReaderViewController
// Check camera permissions
- (void)checkCameraPermission:(void (^)(void))completion {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied) {
        [self showAlertWithTitle:@"Error" message: @"Camera permissions are required for scanning QR. Please turn on Settings -> MasterpassQR Demo -> Camera"];
        return;
    } else if (status == AVAuthorizationStatusRestricted) {
        [self showAlertWithTitle:@"Error" message: @"Camera permissions are restricted for scanning QR"];
        return;
    } else if (status == AVAuthorizationStatusAuthorized) {
        completion();
    } else if (status == AVAuthorizationStatusNotDetermined) {
        __weak __typeof(self) weakSelf = self;
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    completion();
                } else {
                    [weakSelf showAlertWithTitle:@"Error" message: @"Camera permissions are required for scanning QR. Please turn on Settings -> MasterpassQR Demo -> Camera"];
                }
            });
        }];
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:controller animated:true completion:nil];
}

#pragma mark - Update UI
- (void) reloadUserInterface
{
    [_pagerView reloadData];
    [self reloadCarfInfo];
}

- (void) reloadCarfInfo
{
    int index = [[UserManager sharedInstance] getDefaultCardIndex];
    if (index != -1) {
        // Delay 2 seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_pagerView scrollToItemAtIndex:index animated:NO];
            RLMArray<PaymentInstrument*><PaymentInstrument> *instruments = [UserManager sharedInstance].currentUser.paymentInstruments;
            PaymentInstrument* instr = [instruments objectAtIndex:index];
            _balanceDisplay.text = [instr getFormattedAmount];
        });
    }
}

#pragma mark - FSPagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(FSPagerView * _Nonnull)pagerView {
    return [UserManager sharedInstance].currentUser.paymentInstruments.count;
}

- (FSPagerViewCell * _Nonnull)pagerView:(FSPagerView * _Nonnull)pagerView cellForItemAtIndex:(NSInteger)index {
    FSPagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cell" atIndex:index];
    
    RLMArray<PaymentInstrument*><PaymentInstrument> *instruments = [UserManager sharedInstance].currentUser.paymentInstruments;
    PaymentInstrument* instr = [instruments objectAtIndex:index];
    
    NSString* strImageName = @"mastercard_black";
    if ([instr.methodType isEqualToString:@"DebitCard"]) {
        strImageName = @"mastercard_gold";
    }else
    if ([instr.methodType isEqualToString:@"CreditCard"]) {
        strImageName = @"mastercard_black";
    }else
    if ([instr.methodType isEqualToString:@"SavingsAccount"]) {
        strImageName = @"saving_account";
    }
    
    UIImage* image = [UIImage imageNamed:strImageName];
    cell.imageView.image = image;
    return cell;
}


#pragma mark - FSPagerViewDelegate
- (void)pagerView:(FSPagerView *)pagerView didSelectItemAtIndex:(NSInteger)index
{
}

- (void)pagerView:(FSPagerView *)pagerView didHighlightItemAtIndex:(NSInteger)index
{
}

- (void) pagerViewDidScroll:(FSPagerView *)pagerView
{
    static NSInteger index;
    if (index != pagerView.currentIndex) {
        index = pagerView.currentIndex;
        NSLog(@"selected index = %ld", index);
        NSString* strUsername = [LoginManager sharedInstance].loginInfo.user;
        [[MPQRService sharedInstance] changeDefaultCardWithParameters:@{@"user_name":strUsername,
                                                                        @"index":[NSNumber numberWithInteger:index]}
                                                              success:^(User* user){
                                                                  [UserManager sharedInstance].currentUser = user;
                                                                  [self reloadCarfInfo];
                                                              } failure:^(NSError* error){
                                                                  UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"User Not Found" message:@"Related user with this account is not found. Please try again later or contact our administrator." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                                  [alert show];
                                                              }];
    }
}

@end
