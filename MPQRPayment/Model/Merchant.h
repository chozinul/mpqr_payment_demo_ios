//
//  Merchant.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Part of payment data
 Used to store data for payment
 */
@interface Merchant : NSObject

///Merchant name
@property NSString* name;
///Merchant city
@property NSString* city;
//Merchant category code
@property NSString* categoryCode;
///Merchant VISA
@property NSString* identifierVisa02;
///Merchant VISA
@property NSString* identifierVisa03;
///Merchant Mastercard
@property NSString* identifierMastercard04;
///Merchant Mastercard
@property NSString* identifierMastercard05;
///Merchant NPCI
@property NSString* identifierNPCI06;
///Merchant NPCI
@property NSString* identifierNPCI07;
///Merchant terminal number
@property NSString* terminalNumber;
///Merchant store identifier
@property NSString* storeId;

@end
