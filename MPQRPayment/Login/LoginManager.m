//
//  LoginManager.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager

+ (instancetype _Nonnull)sharedInstance
{
    static LoginManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LoginManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

@end
