//
//  Transaction.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Receipt : NSObject

@property NSString* merchantName;
@property NSString* merchantCity;
@property double transactionAmount;
@property double tipAmount;
@property double totalAmount;
@property NSString* currencyCode;
@property NSString* maskedPan;
@property NSString* methodType;

@end
