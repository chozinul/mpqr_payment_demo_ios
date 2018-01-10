//
//  BaseRequest.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The base request class for all request
 */
@interface BaseRequest : NSObject

///All request should contain access code
@property NSString* _Nullable accessCode;

///Initializer of the request with acceess code
- (id _Nonnull) initWithAccessCode:(NSString* _Nonnull) accessCode;

@end
