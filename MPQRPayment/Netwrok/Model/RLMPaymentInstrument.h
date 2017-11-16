//
//  PaymentInstrument.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Realm/Realm.h>

/**
 Used to store cards information of the user
 The class is used both in server and app
 This class is used in server only as it is reading from database
 */
@interface RLMPaymentInstrument : RLMObject

@property long id;
@property NSString* acquirerName;
@property NSString* issuerName;
@property NSString* name;
@property NSString* methodType;
@property double balance;
@property NSString* maskedIdentifier;
@property NSString* currencyNumericCode;
@property BOOL isDefault;

@end
