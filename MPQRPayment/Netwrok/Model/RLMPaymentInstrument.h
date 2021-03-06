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
 This class is used in server only as it is reading from database
 */
@interface RLMPaymentInstrument : RLMObject

///Payment instrument identifier
@property long id;
///Payment instrument acquierer name
@property NSString* acquirerName;
///Payment instrument issuer name
@property NSString* issuerName;
///Payment istrument user name
@property NSString* name;
///Payment instrument method type
@property NSString* methodType;
///Payment instrument balance
@property double balance;
///Payment instrument maskedIdentifier
@property NSString* maskedIdentifier;
///Payment instrument currency numeric code
@property NSString* currencyNumericCode;
///Indicate if this payment instrument is default for the particular user
@property BOOL isDefault;

@end
