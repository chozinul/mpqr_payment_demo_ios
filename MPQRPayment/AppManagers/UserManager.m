//
//  UserManager.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "UserManager.h"
#import "PaymentInstrument.h"

/**
 It store user information
 It provide convenient access to user attributes, such as default card
 */
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

- (PaymentInstrument* _Nullable) getDefaultCard
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

- (PaymentInstrument* _Nullable) getuserCardWithID:(NSInteger) ID
{
    RLMArray<PaymentInstrument*><PaymentInstrument> *instruments = [UserManager sharedInstance].currentUser.paymentInstruments;
    for (int i = 0; i < instruments.count; i++) {
        PaymentInstrument* instr = [instruments objectAtIndex:i];
        if (instr.id == ID) {
            return instr;
        }
    }
    return nil;
}

@end
