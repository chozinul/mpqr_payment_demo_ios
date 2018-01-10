//
//  UserManager.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

/**
 It store user information
 It provide convenient access to user attributes, such as default card
 */
@interface UserManager : NSObject

///Singleton object
+ (instancetype _Nonnull )sharedInstance;

///user information
@property  User* _Nullable currentUser;

///Conveninet access to default card index, corresponding to `[UserManager sharedInstance].currentUser.paymentInstruments`
- (int) getDefaultCardIndex;

///Conveninet access to default card
- (PaymentInstrument* _Nullable) getDefaultCard;

///COnveninet access to get card given card ID
- (PaymentInstrument* _Nullable) getuserCardWithID:(NSInteger) ID;

@end
