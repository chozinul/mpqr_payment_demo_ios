//
//  MPQRServer.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Realm/Realm.h>

/**
 Mock server that responsible for managing all the user, transaction, and payment data
 (can be improved: use get or post as well)
 */
@interface MPQRServer : RLMObject

+ (instancetype _Nonnull )sharedInstance;

- (nullable NSURLSessionDataTask *)GET:(nullable NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;


@end
