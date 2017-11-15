//
//  User.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Realm/Realm.h>

@class PaymentInstrument;
@class Transaction;
RLM_ARRAY_TYPE(Transaction)
RLM_ARRAY_TYPE(PaymentInstrument)

/**
 Used to store user data including cards and transactions
 The class is used both in server and app
 (can be improved: this class is used in server only as it is reading from database, create similar class of subclass nsobject that store data in memeory)
 */
@interface User : RLMObject
@property long id;
@property NSString* firstName;
@property NSString* lastName;
@property RLMArray<PaymentInstrument*><PaymentInstrument> *paymentInstruments;
@property RLMArray<Transaction*><Transaction> *transactions;

@end
