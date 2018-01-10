//
//  LoginViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "LoginViewController.h"
#import "MPQRService.h"
#import "LoginManager.h"
#import "User.h"
#import "PaymentInstrument.h"
#import "DialogViewController.h"
#import "LoginRequest.h"

@interface LoginViewController ()

///Block to handle login success
@property LoginViewControllerCompletionBlock _Nullable completionBlockSuccess;
///Block to handle login fail
@property LoginViewControllerCompletionBlock _Nullable completionBlockFail;

///UI to enter the accesscode/username
@property (weak, nonatomic) IBOutlet UITextField *accessCode;
///UI to enter pin/password
@property (weak, nonatomic) IBOutlet UITextField *pin;
///Sign-in button container, necessary as the behaviour is custom
@property (weak, nonatomic) IBOutlet UIView *section4;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ///Registering listener for keyboard UI changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    ///Set initial position of section 4
    CGRect f = self.section4.frame;
    f.origin.y = self.view.bounds.size.height - f.size.height;
    f.origin.x = 0;
    f.size.width = self.view.bounds.size.width;
    self.section4.frame = f;
    
    ///Set default value for accesscode
    [self setInitialAccesscode];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    ///Remove observer for keyboard
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
    - Check the format of accesscode and pin
    - Call the service/server API to login and determine if the access is valid
    - Call block for the result of the login
 */
- (IBAction)signIn:(id)sender {
    NSString* strAccessCode = _accessCode.text;
    NSString* strPin = _pin.text;
    
    if (![self isValidAccessCode:strAccessCode pin:strPin]) {
        DialogViewController* dialogVC = [DialogViewController new];
        dialogVC.dialogMessage = @"Invalid access code or pin, please enter a valid access code and 6 digit pin.";
        dialogVC.positiveResponse = @"OK";
        [dialogVC showDialogWithContex:self
                     withYesBlock:^(DialogViewController* dialog){
                     } withNoBlock:^(DialogViewController* dialog){
                     }];
        return;
    }
    
    
    LoginRequest* lRequest = [[LoginRequest alloc] initWithAccessCode:strAccessCode pin:strPin];
    [[MPQRService sharedInstance] loginWithParameters:lRequest
                                              success:^(LoginResponse* lResponse){
                                                  [LoginManager sharedInstance].loginInfo = lResponse;
                                                  [self dismissViewControllerAnimated:YES completion:^(){
                                                      _completionBlockSuccess(self);
                                                  }];
                                              } failure:^(NSError* error){
                                                  DialogViewController* dialogVC = [DialogViewController new];
                                                  dialogVC.dialogMessage = @"Login failed, please enter a valid access code and 6 digit pin.";
                                                  dialogVC.positiveResponse = @"OK";
                                                  [dialogVC showDialogWithContex:self
                                                                    withYesBlock:^(DialogViewController* dialog){
                                                                    } withNoBlock:^(DialogViewController* dialog){
                                                                    }];
                                              }];
    
}

- (BOOL) isValidAccessCode:(NSString*) accessCode pin:(NSString*) pin
{
    if (accessCode.length == 0) {
        return false;
    }
    if (pin.length != 6) {
        return false;
    }
    return true;
}


#pragma mark - textfield movement
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) setInitialAccesscode
{
    if (_accessCode.text.length == 0) {
        _accessCode.text = [LoginManager sharedInstance].lastUser;
    }
}


#pragma mark - keyboard movements
///Keyboard behaviour for controlling the sign-in button
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.section4.frame;
        f.origin.y = self.view.bounds.size.height - f.size.height - keyboardSize.height;
        self.section4.frame = f;
    }];
}

///Keyboard behaviour for controlling the sign-in button
-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.section4.frame;
        f.origin.y = self.view.bounds.size.height - f.size.height;
        self.section4.frame = f;
    }];
}

#pragma mark - Present Self
///Method to call a loginviewcontroller class by passing current UIViewController
- (void) showDialogWithContex:(UIViewController* _Nonnull) vc withYesBlock:(nullable void (^)(LoginViewController* _Nonnull loginVC)) success withNoBlock:(nullable void (^)(LoginViewController* _Nonnull loginVC)) failure
{
    _completionBlockFail = failure;
    _completionBlockSuccess = success;
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext | UIModalPresentationFullScreen;
    [vc presentViewController:self animated:NO completion:nil];
}
@end
