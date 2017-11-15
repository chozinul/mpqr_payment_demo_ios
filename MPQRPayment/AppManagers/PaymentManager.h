//
//  PaymentManager.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PaymentData;
@interface PaymentManager : NSObject

+ (instancetype _Nonnull )sharedInstance;

- (void) parseScannedCode:(NSString*_Nullable) code withCompletionBlock:(nullable void (^)(PaymentData* _Nullable paymentData, NSError* _Nullable error)) completionBlock;

@end
