//
//  PaymentViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentData.h"
#import "Merchant.h"
#import "MPQRService.h"
#import "Transaction.h"

/*
 @property  long userId;
 @property  long cardId;
 @property  BOOL isDynamic;
 @property  double transactionAmount;
 @property  TipConvenienceIndicator tipType;
 @property  double tip;
 @property  NSString* currencyNumericCode;
 @property  NSString* mobile;
 @property  Merchant* merchant;
 */
@interface PaymentViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *merchantName;
@property (weak, nonatomic) IBOutlet UILabel *merchantCity;
@property (weak, nonatomic) IBOutlet UILabel *currency;
@property (weak, nonatomic) IBOutlet UITextField *amount;
@property (weak, nonatomic) IBOutlet UITextField *flatTip;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *maskedIdentifier;
@property (weak, nonatomic) IBOutlet UIView *section4;

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _merchantName.text = _paymentData.merchant.name;
    _merchantCity.text = _paymentData.merchant.city;
    _currency.text = _paymentData.currencyNumericCode;
    _amount.text = [NSString stringWithFormat:@"%f", _paymentData.transactionAmount];
    switch (_paymentData.tipType) {
        case percentageConvenienceFee:
            _flatTip.text = [NSString stringWithFormat:@"%f %%", _paymentData.tip];
            break;
        case flatConvenienceFee:
            _flatTip.text = [NSString stringWithFormat:@"%f", _paymentData.tip];
            break;
        case promptedToEnterTip:
            _flatTip.text = [NSString stringWithFormat:@"%f", _paymentData.tip];
            _totalAmount.text = [NSString stringWithFormat:@"%f", _paymentData.transactionAmount + _paymentData.tip];
            break;
        default:
            break;
    }
    _amount.delegate = self;
    _flatTip.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeCard:(id)sender {
    
}
- (IBAction)pay:(id)sender {
    NSString* strAmount = _amount.text;
    double amount = [strAmount doubleValue];
    NSDictionary* parameter = @{@"sender_id":[NSNumber numberWithInteger:_paymentData.userId],
                                @"sender_card_id":[NSNumber numberWithInteger:_paymentData.cardId],
                                @"receiver_card_number":_paymentData.merchant.identifierMastercard04,
                                @"receiver_name":_paymentData.merchant.name,
                                @"currency":_paymentData.currencyNumericCode,
                                @"transaction_amount":[NSNumber numberWithDouble:amount],
                                @"tip":[NSNumber numberWithDouble:_flatTip.text.doubleValue],
                                @"terminal_number":_paymentData.merchant.terminalNumber
                                };
    
    [[MPQRService sharedInstance] makePaymentWithParameters:parameter
                                                    success:^(Transaction* transaction){
                                                        [self.navigationController popViewControllerAnimated:YES];
                                                    } failure:^(NSError* error){
                                                        
                                                    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    CGRect f = self.section4.frame;
    f.origin.y = self.view.bounds.size.height - f.size.height;
    f.origin.x = 0;
    f.size.width = self.view.bounds.size.width;
    self.section4.frame = f;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - textfield movement
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.section4.frame;
        f.origin.y = self.view.bounds.size.height - f.size.height - keyboardSize.height;
        self.section4.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.section4.frame;
        f.origin.y = self.view.bounds.size.height - f.size.height;
        self.section4.frame = f;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
