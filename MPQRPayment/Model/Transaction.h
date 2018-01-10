//
//  Transaction.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RLMTransaction;
/**
 Used to store cards transaction that has been done by the user
 The class is used in app
 */
@interface Transaction : NSObject

///Reference Identifier of the transaction
@property NSString* referenceId;
///Invoice number of the transaction
@property NSString* invoiceNumber;
///Identifier of the intrument used for the transaction
@property long instrumentIdentifier;
///Masked identifier of the payment instrument identifier
@property NSString* maskedIdentifier;
///Transaction amount in currency
@property double transactionAmount;
///Tip amount in currency
@property double tipAmount;
///Currency numeric code
@property NSString* currencyNumericCode;
///Transaction date
@property NSDate* transactionDate;
///Merchant name
@property NSString* merchantName;

///Covenient accessor to get a formatted date
- (NSString*) getFormattedTransactionDate;

///Initialize user object from Server Class RLMUser
+ (instancetype) TransactionFromRLMTransaction:(RLMTransaction*) rlmTransaction;

@end
