//
//  PaymentData.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Used to store data for payment
 Derived from push payment data from MPQR core SDK
 */
@import MasterpassQRCoreSDK;

@class Merchant;
@interface PaymentData : NSObject

///User identifier
@property  long userId;
///Card/Payment Instrument identifier
@property  long cardId;
///Indicate if the payment method is dynamic
@property  BOOL isDynamic;
///Transaction amount
@property  double transactionAmount;
///Tip type
@property  TipConvenienceIndicator tipType;
///Tip value
@property  double tip;
///Currency numeric code
@property  NSString* currencyNumericCode;
///Mobile number
@property  NSString* mobile;
///Merchant information
@property  Merchant* merchant;

///Convenient accessor to get tip amount in currency
- (double) getTipAmount;

@end
