//
//  LoginResponse.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Realm/Realm.h>

/**
 Response for the login call
 Stored in Login manager for reference if want to call server API
 */
@interface LoginResponse : RLMObject

@property NSString* accessCode;
@property NSString* token;

@end
