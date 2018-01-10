//
//  PaymentData.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "PaymentData.h"

@implementation PaymentData

///Convenient accessor to get tip amount in currency
- (double) getTipAmount
{
    if (_tipType == percentageConvenienceFee) {
        return _transactionAmount*_tip/100;
    }else
    {
        return _tip;
    }
}

///Get total transaction amount including the tips
- (double) getTotal
{
    return _transactionAmount + [self getTipAmount];
}

@end
