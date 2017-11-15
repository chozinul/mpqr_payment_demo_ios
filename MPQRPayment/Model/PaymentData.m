//
//  PaymentData.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "PaymentData.h"

@implementation PaymentData

- (double) getTipAmount
{
    if (_tipType == percentageConvenienceFee) {
        return _transactionAmount*_tip/100;
    }else
    {
        return _tip;
    }
}

- (double) getTotal
{
    return _transactionAmount + [self getTipAmount];
}

@end
