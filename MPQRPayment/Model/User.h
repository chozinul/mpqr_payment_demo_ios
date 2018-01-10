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
 Used to store user data including cards and transactions.
 The class is used both in app.
 */
@interface User : NSObject

///User ID
@property long id;
///User first name
@property NSString* firstName;
///User last name
@property NSString* lastName;
///Payment Instrument/ Cards that belongs to the user
@property NSArray<PaymentInstrument*> *paymentInstruments;
///Transactions that belongs to the user
@property NSArray<Transaction*> *transactions;

///Initialize user object from Server Class RLMUser
+ (instancetype) UserFromRLMUser:(RLMUser*) rlmUser;

@end
