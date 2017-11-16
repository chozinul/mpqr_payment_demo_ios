//
//  Transaction.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Realm/Realm.h>

/**
 Used to store cards transaction that has been done by the user
 The class is used both in server and app
 This class is used in server only as it is reading from database
 */
@interface RLMTransaction : RLMObject

@property NSString* referenceId;
@property NSString* invoiceNumber;
@property long instrumentIdentifier;
@property NSString* maskedIdentifier;
@property double transactionAmount;
@property double tipAmount;
@property NSString* currencyNumericCode;
@property NSDate* transactionDate;
@property NSString* merchantName;

- (NSString*) getFormattedTransactionDate;
@end
