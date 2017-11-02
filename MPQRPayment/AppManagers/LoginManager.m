//
//  LoginManager.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "LoginManager.h"
#import "LoginResponse.h"

@interface LoginManager()

@end

@implementation LoginManager

static NSString* _lastUser;

+ (instancetype _Nonnull)sharedInstance
{
    static LoginManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LoginManager alloc] init];
        if (!_lastUser) {
            _lastUser = @"jerry";
        }
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void) setLoginInfo:(LoginResponse *)loginInfo
{
    _lastUser = loginInfo.accessCode;
    _loginInfo = loginInfo;
}

- (NSString*) lastUser
{
    return _lastUser;
}



@end
