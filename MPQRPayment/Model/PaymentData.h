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

@property  long userId;
@property  long cardId;
@property  BOOL isDynamic;
@property  double transactionAmount;
@property  TipConvenienceIndicator tipType;
@property  double tip;
@property  NSString* currencyNumericCode;
@property  NSString* mobile;
@property  Merchant* merchant;

- (double) getTipAmount;

@end
