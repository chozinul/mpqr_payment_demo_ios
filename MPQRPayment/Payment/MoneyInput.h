//
//  MoneyInput.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 15/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoneyInputDelegate<NSObject>

@optional
- (void)textFieldDidChange:(UITextField *)textField;


@end

IB_DESIGNABLE
@interface MoneyInput : UIView

@property (nonatomic) IBInspectable NSString* strTitle;
@property (nonatomic) IBInspectable  NSString* strValue;
@property  (nonatomic) IBInspectable int decimalDigit;

@property (nonatomic) IBInspectable BOOL enabled;
@property (nonatomic) IBInspectable BOOL percentaged;

@property id<MoneyInputDelegate> delegate;

@end
