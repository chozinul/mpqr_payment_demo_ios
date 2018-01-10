//
//  CurrencyFormatter.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "CurrencyFormatter.h"

@implementation CurrencyFormatter

/**
 Format the currency based in the number of decimal value given
 */
+ (NSString*) getFormattedAmountWithValue:(double) value decimalPoint:(int) decimalPoint{
    NSString* formatString = [NSString stringWithFormat:@"%%.%dlf",decimalPoint];
    NSString* newString = [NSString stringWithFormat:formatString, value];
    return newString;
}


@end
