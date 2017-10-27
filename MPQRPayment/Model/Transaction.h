//
//  Transaction.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Realm/Realm.h>
#import "CurrencyEnum.h"

@interface Transaction : RLMObject

@property NSString* referenceId;
@property NSString* invoiceNumber;
@property long instrumentIdentifier;
@property NSString* maskedIdentifier;
@property double transactionAmount;
@property double tipAmount;
@property NSString* currencyNumericCode;
@property NSDate* transactionDate;
@property NSString* merchantName;

- (double) getTotal;
- (CurrencyEnum) getCurrencyCode;
- (NSString*) getFormattedAmount;
- (NSString*) getFormattedAmountWithValue:(double) value;
- (NSString*) getFormattedTransactionDate;
@end
