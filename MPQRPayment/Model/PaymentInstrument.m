//
//  PaymentInstrument.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "PaymentInstrument.h"
#import "RLMPaymentInstrument.h"

@implementation PaymentInstrument

///Initialize user object from Server Class RLMUser
+ (instancetype) PaymentInstrumentFromRLMPaymentInstrument:(RLMPaymentInstrument*) rlmPaymentInstrument
{
    PaymentInstrument* paymentInstrument = [PaymentInstrument new];
    
    paymentInstrument.id = rlmPaymentInstrument.id;
    paymentInstrument.acquirerName = rlmPaymentInstrument.acquirerName;
    paymentInstrument.issuerName = rlmPaymentInstrument.issuerName;
    paymentInstrument.name = rlmPaymentInstrument.name;
    paymentInstrument.methodType = rlmPaymentInstrument.methodType;
    paymentInstrument.balance = rlmPaymentInstrument.balance;
    paymentInstrument.maskedIdentifier = rlmPaymentInstrument.maskedIdentifier;
    paymentInstrument.currencyNumericCode = rlmPaymentInstrument.currencyNumericCode;
    paymentInstrument.isDefault = rlmPaymentInstrument.isDefault;
    
    return paymentInstrument;
}
///Method is needed if we want to make this object a key at a dictionary. Currently it is not being used
- (BOOL) isEqual:(id _Nullable)object
{
    if (![object isKindOfClass:[PaymentInstrument class]]) {
        return false;
    }
    if (self == object) {
        return true;
    }
    PaymentInstrument* other = (PaymentInstrument*) object;
    BOOL idEqual = self.id == other.id;
    BOOL acquirerNameEqual = (!self.acquirerName && !other.acquirerName) ||[self.acquirerName isEqualToString:other.acquirerName];
    BOOL issuerNameEqual = (!self.issuerName && !other.issuerName) ||[self.issuerName isEqualToString:other.issuerName];
    BOOL nameEqual = (!self.name && !other.name) ||[self.name isEqualToString:other.name];
    BOOL methodTypeEqual = (!self.methodType && !other.methodType) ||[self.methodType isEqualToString:other.methodType];
    BOOL balanceEqual = self.balance == other.balance;
    BOOL maskedIdentifierEqual = (!self.maskedIdentifier && !other.maskedIdentifier) ||[self.maskedIdentifier isEqualToString:other.maskedIdentifier];
    BOOL currencyNumericCodeEqual = (!self.currencyNumericCode && !other.currencyNumericCode) ||[self.currencyNumericCode isEqualToString:other.currencyNumericCode];
    BOOL isDefault = self.isDefault == other.isDefault;
    return idEqual
    && acquirerNameEqual
    && issuerNameEqual
    && nameEqual
    && methodTypeEqual
    && balanceEqual
    && maskedIdentifierEqual
    && currencyNumericCodeEqual
    && isDefault;
}
///Method is needed if we want to make this object a key at a dictionary. Currently it is not being used
- (NSUInteger)hash
{
    NSUInteger totalInt=0;
    totalInt += self.id;
    totalInt += [self.acquirerName hash];
    totalInt += [self.issuerName hash];
    totalInt += [self.name hash];
    totalInt += [self.methodType hash];
    totalInt += (NSInteger)self.balance;
    totalInt += [self.maskedIdentifier hash];
    totalInt += [self.currencyNumericCode hash];
    totalInt += (NSInteger)self.isDefault;
    return totalInt;
}

@end
