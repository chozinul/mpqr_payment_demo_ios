//
//  DialogViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 29/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class DialogViewController;
typedef void (^DialogViewControllerCompletionBlock)(DialogViewController* _Nonnull dialogVC);

@interface DialogViewController : BaseViewController

///Dialog message to be displayed
@property  NSString* _Nullable  dialogMessage;

///Positive response, i.e. a user agree. If this value is not set the button is not shown
@property  NSString* _Nullable  positiveResponse;

///Negative response, i.e. a user disagree. If this value is not set the button is not shown
@property  NSString* _Nullable  negativeResponse;

///Dialog height for different kind of content
@property  int dialogHeight;

/**
 This is how we call the dialog by passing caller view controller
 The positive and negative response block is called after the dialog disappear
 */
- (void) showDialogWithContex:(UIViewController* _Nonnull) vc withYesBlock:(nullable void (^)(DialogViewController* _Nonnull dialogVC)) success withNoBlock:(nullable void (^)(DialogViewController* _Nonnull dialogVC)) failure;

@end
