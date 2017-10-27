//
//  User.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Realm/Realm.h>

@class PaymentInstrument;
@class Transaction;
RLM_ARRAY_TYPE(Transaction)
RLM_ARRAY_TYPE(PaymentInstrument)
@interface User : RLMObject
@property long id;
@property NSString* firstName;
@property NSString* lastName;
@property RLMArray<PaymentInstrument*><PaymentInstrument> *paymentInstruments;
@property RLMArray<Transaction*><Transaction> *transactions;

@end
