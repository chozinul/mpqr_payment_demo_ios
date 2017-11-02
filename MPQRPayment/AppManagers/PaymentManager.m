//
//  PaymentManager.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "PaymentManager.h"
#import "PaymentData.h"
#import "UserManager.h"
#import "PaymentInstrument.h"
#import "Merchant.h"

@import MasterpassQRCoreSDK;

@implementation PaymentManager

+ (instancetype _Nonnull)sharedInstance
{
    static PaymentManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PaymentManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void) parseScannedCode:(NSString*_Nullable) code withCompletionBlock:(nullable void (^)(PaymentData* _Nullable paymentData, NSError* _Nullable error)) completionBlock;
{
    PushPaymentData *pushPaymentData;
    MPQRError *error;
    pushPaymentData = [MPQRParser parse:code error:&error];
    
    if (error) {
        completionBlock(nil, error);
    }else
    {
        NSLog([pushPaymentData dumpData],nil);
        PaymentData* paymentData = [self paymentDataWithPPD:pushPaymentData];
        completionBlock(paymentData, nil);
    }
}

- (PaymentData*) paymentDataWithPPD:(PushPaymentData*) pushPD
{
    TipConvenienceIndicator tipInfo = unknownTipConvenienceIndicator;
    double tip = 0;
    PaymentData* paymentData = [PaymentData new];
    if (pushPD.tipOrConvenienceIndicator.length > 0) {
        TipConvenienceIndicator ppdTipInfo = [ClassTipConvenienceIndicator enumFor:pushPD.tipOrConvenienceIndicator];
        switch (ppdTipInfo) {
            case flatConvenienceFee:
                tipInfo = flatConvenienceFee;
                tip = [pushPD.valueOfConvenienceFeeFixed doubleValue];
                break;
            
            case percentageConvenienceFee:
                tipInfo = percentageConvenienceFee;
                tip = [pushPD.valueOfConvenienceFeePercentage doubleValue];
                break;
                
            case promptedToEnterTip:
                tipInfo = promptedToEnterTip;
                tip = 0;
                break;
                
            default:
                break;
        }
    }
    NSInteger userID = [UserManager sharedInstance].currentUser.id;
    PaymentInstrument* instrument = [[UserManager sharedInstance] getDefaultCard];
    paymentData.userId = userID;
    paymentData.cardId = instrument.id;
    paymentData.isDynamic = pushPD.isDynamic;
    paymentData.transactionAmount = pushPD.transactionAmount.doubleValue;
    paymentData.tipType = tipInfo;
    paymentData.tip = tip;
    paymentData.currencyNumericCode = pushPD.transactionCurrencyCode;
    paymentData.mobile = pushPD.additionalData.mobileNumber;
    paymentData.merchant = [self merchantDataWithPPD:pushPD];
    return paymentData;
}

- (Merchant*) merchantDataWithPPD:(PushPaymentData*) pushPD
{
    Merchant* mer = [Merchant new];
    mer.name = pushPD.merchantName;
    mer.city = pushPD.merchantCity;
    mer.categoryCode = pushPD.merchantCategoryCode;
    mer.identifierVisa02 = pushPD.merchantIdentifierVisa02;
    mer.identifierVisa03 = pushPD.merchantIdentifierVisa03;
    mer.identifierMastercard04 = pushPD.merchantIdentifierMastercard04;
    mer.identifierMastercard05 = pushPD.merchantIdentifierMastercard05;
    mer.identifierNPCI06 = pushPD.merchantIdentifierNPCI06;
    mer.identifierNPCI07 = pushPD.merchantIdentifierNPCI07;
    mer.terminalNumber = pushPD.additionalData.terminalId;
    mer.storeId = pushPD.additionalData.storeId;
    return mer;
}

@end
