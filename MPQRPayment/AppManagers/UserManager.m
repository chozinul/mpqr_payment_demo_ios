//
//  UserManager.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "UserManager.h"
#import "PaymentInstrument.h"

@implementation UserManager

+ (instancetype _Nonnull)sharedInstance
{
    static UserManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UserManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (int) getDefaultCardIndex
{
    RLMArray<PaymentInstrument*><PaymentInstrument> *instruments = [UserManager sharedInstance].currentUser.paymentInstruments;
    for (int i = 0; i < instruments.count; i++) {
        PaymentInstrument* instr = [instruments objectAtIndex:i];
        if (instr.isDefault) {
            return i;
        }
    }
    return -1;
}

- (PaymentInstrument*) getDefaultCard
{
    RLMArray<PaymentInstrument*><PaymentInstrument> *instruments = [UserManager sharedInstance].currentUser.paymentInstruments;
    for (int i = 0; i < instruments.count; i++) {
        PaymentInstrument* instr = [instruments objectAtIndex:i];
        if (instr.isDefault) {
            return instr;
        }
    }
    return nil;
}
@end
