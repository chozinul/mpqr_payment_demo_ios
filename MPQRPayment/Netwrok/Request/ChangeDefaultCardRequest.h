//
//  ChangeDefaultCardRequest.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 1/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "BaseRequest.h"

///Change default card request
@interface ChangeDefaultCardRequest : BaseRequest

///Index of the card to be change to default
@property int index;


///Initializer of the request with acceess code and the card index
- (id _Nonnull) initWithAccessCode:(NSString* _Nonnull) accessCode index:(int) index;

@end
