//
//  LoginViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "LoginViewController.h"
#import "MPQRService.h"
#import "LoginManager.h"
#import "User.h"
#import "PaymentInstrument.h"
#import "DialogViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accessCode;
@property (weak, nonatomic) IBOutlet UITextField *pin;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)signIn:(id)sender {
    NSString* strUserName = _accessCode.text;
    NSString* strPin = _pin.text;
    
    if (![self isValidUsername:strUserName password:strPin]) {
        DialogViewController* dialogVC = [DialogViewController new];
        dialogVC.dialogMessage = @"Invalid access code or pin, please enter a valid access code and 6 digit pin.";
        dialogVC.positiveResponse = @"OK";
        [dialogVC showDialogWithContex:self
                     withYesBlock:^(DialogViewController* dialog){
                     } withNoBlock:^(DialogViewController* dialog){
                     }];
        return;
    }
    
    [[MPQRService sharedInstance] loginWithParameters:@{@"user_name":strUserName, @"password":strPin}
                                              success:^(LoginResponse* lResponse){
                                                  [LoginManager sharedInstance].loginInfo = lResponse;
                                                  [self dismissViewControllerAnimated:YES completion:nil];
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

- (BOOL) isValidUsername:(NSString*) username password:(NSString*) password
{
    if (!username) {
        return false;
    }
    if (!password) {
        return false;
    }
    if (password.length != 6) {
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
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.section4.frame;
        f.origin.y = self.view.bounds.size.height - f.size.height;
        self.section4.frame = f;
    }];
}

@end
