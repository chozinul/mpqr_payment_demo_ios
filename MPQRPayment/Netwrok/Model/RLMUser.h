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
 This class is used in server only as it is reading from database
 */
@interface RLMUser : RLMObject
///User ID
@property long id;
///User first name
@property NSString* firstName;
///User last name
@property NSString* lastName;
///Payment Instrument/ Cards that belongs to the user
@property RLMArray<RLMPaymentInstrument*><RLMPaymentInstrument> *paymentInstruments;
///Transactions that belongs to the user
@property RLMArray<RLMTransaction*><RLMTransaction> *transactions;

@end
