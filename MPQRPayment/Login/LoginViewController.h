//
//  LoginViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class LoginViewController;

///Block to handle login result, successful or fail
typedef void (^LoginViewControllerCompletionBlock)(LoginViewController* _Nonnull loginVC);

/**
 UIViewController class as user interface for login.
 It handle the login flow and return to calling function with block once the login is success or fail.
 */
@interface LoginViewController : BaseViewController

/**
 This is how we call the dialog by passing caller view controller.
 The positive and negative response block is called after the dialog disappear.
 */
- (void) showDialogWithContex:(UIViewController* _Nonnull) vc withYesBlock:(nullable void (^)(LoginViewController* _Nonnull loginVC)) success withNoBlock:(nullable void (^)(LoginViewController* _Nonnull loginVC)) failure;


@end
