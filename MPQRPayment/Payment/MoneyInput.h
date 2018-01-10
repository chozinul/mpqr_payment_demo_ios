//
//  MoneyInput.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 15/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Protocol to be implemented in the class that implement MoneyInput
 */
@protocol MoneyInputDelegate<NSObject>

/**
 This method is called when the money input value is changed
 */
@optional
- (void)textFieldDidChange:(UITextField *)textField;

@end

/**
 Custom input for input/display the money/tips
    - It consist customizable decimal digit
    - It consist percentage function. i.e. the display will be in percentage if `percentaged` is true
 */
IB_DESIGNABLE
@interface MoneyInput : UIView

///Title of the custom input. i.e. Amounr
@property (nonatomic) IBInspectable NSString* strTitle;

///Value of the custom input. it will be digit number.
@property (nonatomic) IBInspectable  NSString* strValue;

///It will determine how many decimal digit (digit behind '.')
@property  (nonatomic) IBInspectable int decimalDigit;

///It will determice user can input some number or not
@property (nonatomic) IBInspectable BOOL enabled;

///It will set if the sign and behaviour is percentage instead of money
@property (nonatomic) IBInspectable BOOL percentaged;

///Delegate that is called when the value of the input is changed
@property id<MoneyInputDelegate> delegate;

@end
