//
//  PaymentManager.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PaymentData;
/**
 Responsible for parsing QRCode to Payment data
 */
@interface PaymentManager : NSObject

///Singleton object
+ (instancetype _Nonnull )sharedInstance;

///Parse QRCode to PaymentData
- (void) parseScannedCode:(NSString*_Nullable) code withCompletionBlock:(nullable void (^)(PaymentData* _Nullable paymentData, NSError* _Nullable error)) completionBlock;

@end
