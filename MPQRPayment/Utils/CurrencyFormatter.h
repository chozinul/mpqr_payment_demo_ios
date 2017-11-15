//
//  CurrencyFormatter.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Format the currency from local setting of the phone
 (can be improved: based on the currency of current selected card)
 */
@interface CurrencyFormatter : NSObject


+ (NSString*) getFormattedAmountWithValue:(double) value;

@end
