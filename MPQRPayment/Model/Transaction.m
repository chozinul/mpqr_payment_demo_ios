//
//  Transaction.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "Transaction.h"
#import "RLMTransaction.h"

@implementation Transaction

///Initialize user object from Server Class RLMUser
+ (instancetype) TransactionFromRLMTransaction:(RLMTransaction*) rlmTransaction
{
    Transaction* transaction = [Transaction new];
    
    transaction.referenceId = rlmTransaction.referenceId;
    transaction.invoiceNumber = rlmTransaction.invoiceNumber;
    transaction.instrumentIdentifier = rlmTransaction.instrumentIdentifier;
    transaction.maskedIdentifier = rlmTransaction.maskedIdentifier;
    transaction.transactionAmount = rlmTransaction.transactionAmount;
    transaction.tipAmount = rlmTransaction.tipAmount;
    transaction.currencyNumericCode = rlmTransaction.currencyNumericCode;
    transaction.transactionDate = rlmTransaction.transactionDate;
    transaction.merchantName = rlmTransaction.merchantName;
    
    return transaction;
}


///Covenient accessor to get a formatted date
- (NSString*) getFormattedTransactionDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/M/dd hh:mm"];
    NSDate* date = self.transactionDate;
    return [dateFormatter stringFromDate:date];
}

///Method is needed if we want to make this object a key at a dictionary. Currently it is not being used
- (BOOL) isEqual:(id _Nullable)object
{
    if (![object isKindOfClass:[Transaction class]]) {
        return false;
    }
    if (self == object) {
        return true;
    }
    Transaction* other = (Transaction*) object;
    BOOL referenceIdEqual = (!self.referenceId && !other.referenceId) ||[self.referenceId isEqualToString:other.referenceId];
    BOOL invoiceNumberEqual = (!self.invoiceNumber && !other.invoiceNumber) ||[self.invoiceNumber isEqualToString:other.invoiceNumber];
    BOOL maskedIdentifierEqual = (!self.maskedIdentifier && !other.maskedIdentifier) ||[self.maskedIdentifier isEqualToString:other.maskedIdentifier];
    BOOL transactionAmountEqual = self.transactionAmount == other.transactionAmount;
    BOOL tipAmountEqual = self.tipAmount == other.tipAmount;
    BOOL currencyNumericCodeEqual = (!self.currencyNumericCode && !other.currencyNumericCode) ||[self.currencyNumericCode isEqualToString:other.currencyNumericCode];
    BOOL transactionDateEqual = (!self.transactionDate && !other.transactionDate) || [self.transactionDate isEqual:other.transactionDate];
    BOOL merchantNameEqual = (!self.merchantName && !other.merchantName) ||[self.merchantName isEqualToString:other.merchantName];
    return referenceIdEqual
    && invoiceNumberEqual
    && maskedIdentifierEqual
    && transactionAmountEqual
    && tipAmountEqual
    && currencyNumericCodeEqual
    && transactionDateEqual
    && merchantNameEqual;
}

///Method is needed if we want to make this object a key at a dictionary. Currently it is not being used
- (NSUInteger)hash
{
    NSUInteger totalInt=0;
    totalInt += [_referenceId hash];
    totalInt += [_invoiceNumber hash];
    totalInt += [_maskedIdentifier hash];
    totalInt += [_currencyNumericCode hash];
    totalInt += [_transactionDate hash];
    totalInt += [_merchantName hash];
    totalInt += [_transactionDate hash];
    totalInt += (NSInteger)_transactionAmount;
    totalInt += (NSInteger)_tipAmount;
    return totalInt;
}

@end
