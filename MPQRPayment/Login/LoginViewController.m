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

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accessCode;
@property (weak, nonatomic) IBOutlet UITextField *pin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Invalid Inputs" message:@"Please enter an access code and 6 digit pin." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    [[MPQRService sharedInstance] loginWithParameters:@{@"user_name":strUserName, @"password":strPin}
                                              success:^(LoginResponse* lResponse){
                                                  [LoginManager sharedInstance].loginInfo = lResponse;
                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                              } failure:^(NSError* error){
                                                  UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please enter valid access code and 6 digit pin." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                  [alert show];
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
@end
