//
//  User.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Realm/Realm.h>

@class RLMPaymentInstrument;
@class RLMTransaction;
RLM_ARRAY_TYPE(RLMTransaction)
RLM_ARRAY_TYPE(RLMPaymentInstrument)

/**
 Used to store user data including cards and transactions
 The class is used both in server and app
 This class is used in server only as it is reading from database
 */
@interface RLMUser : RLMObject
@property long id;
@property NSString* firstName;
@property NSString* lastName;
@property RLMArray<RLMPaymentInstrument*><RLMPaymentInstrument> *paymentInstruments;
@property RLMArray<RLMTransaction*><RLMTransaction> *transactions;

@end
