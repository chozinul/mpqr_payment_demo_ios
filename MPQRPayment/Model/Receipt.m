//
//  Transaction.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "Receipt.h"
#import "Transaction.h"
#import "PaymentData.h"
#import "Merchant.h"

@implementation Receipt

- (id _Nonnull) initWithTransaction:(Transaction* _Nonnull) transaction paymentData:(PaymentData* _Nonnull) paymentData
{
    /*
    _lblTotal.text = [NSString stringWithFormat:@"%@ %@"
                      ,[CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_transaction.currencyNumericCode]]
                      ,[CurrencyFormatter getFormattedAmountWithValue:_transaction.transactionAmount + _transaction.tipAmount]];
    
    _lblMerchant.text = _transaction.merchantName;
    _lblCity.text = _paymentData.merchant.city;
    _lblAmount.text = [CurrencyFormatter getFormattedAmountWithValue:_transaction.transactionAmount];
    _lblTips.text = [CurrencyFormatter getFormattedAmountWithValue:_transaction.tipAmount];
    _lblMaskedIdentifier.text = _transaction.maskedIdentifier;
    */
    if (self = [super init]) {
        _merchantName = transaction.merchantName;
        _merchantCity = paymentData.merchant.city;
        _transactionAmount = transaction.transactionAmount;
        _tipAmount = transaction.tipAmount;
        _totalAmount = transaction.tipAmount + transaction.transactionAmount;
        _currencyCode = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:transaction.currencyNumericCode]];
        _maskedPan = transaction.maskedIdentifier;
        _methodType = @"";
    }
    return self;
}

@end
