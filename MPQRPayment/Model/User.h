//
//  User.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RLMUser;
@class PaymentInstrument;
@class Transaction;

/**
 Used to store user data including cards and transactions
 The class is used both in server and app
 */

@interface User : NSObject
@property long id;
@property NSString* firstName;
@property NSString* lastName;
@property NSArray<PaymentInstrument*> *paymentInstruments;
@property NSArray<Transaction*> *transactions;

+ (instancetype) UserFromRLMUser:(RLMUser*) rlmUser;

@end
