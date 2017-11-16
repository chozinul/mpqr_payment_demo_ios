//
//  MPQRService.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Realm;

@class LoginResponse;
@class User;
@class Transaction;

/**
 Responsible for communication app with mock server
 - In real app, responsible for parsing response from server to object
 - In real app, responsible for change request object to parameters
 - Responsible to call server API
 */
@interface MPQRService : NSObject

+ (instancetype _Nonnull )sharedInstance;

- (void) loginWithParameters:(nullable id)parameters
                     success:(nullable void (^)(LoginResponse* _Nullable responseObject))success
                     failure:(nullable void (^)(NSError * _Nullable error))failure;


- (void) logoutWithParameters:(nullable id)parameters
                     success:(nullable void (^)(id _Nullable responseObject))success
                     failure:(nullable void (^)(NSError * _Nullable error))failure;

- (void) getUserWithParameters:(nullable id)parameters
                     success:(nullable void (^)(User* _Nullable responseObject))success
                     failure:(nullable void (^)(NSError * _Nullable error))failure;


- (void) changeDefaultCardWithParameters:(nullable id)parameters
                       success:(nullable void (^)(User* _Nullable responseObject))success
                       failure:(nullable void (^)(NSError * _Nullable error))failure;

- (void) makePaymentWithParameters:(nullable id)parameters
                                 success:(nullable void (^)(id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSError * _Nullable error))failure;

- (void) getTransactionsParameters:(nullable id)parameters
                           success:(nullable void (^)(NSArray<Transaction*> * _Nullable responseObject))success
                           failure:(nullable void (^)(NSError * _Nullable error))failure;

@end
