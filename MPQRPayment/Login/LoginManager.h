//
//  LoginManager.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginResponse.h"

@interface LoginManager : NSObject

+ (instancetype _Nonnull )sharedInstance;

@property  LoginResponse* _Nullable loginInfo;

@end
