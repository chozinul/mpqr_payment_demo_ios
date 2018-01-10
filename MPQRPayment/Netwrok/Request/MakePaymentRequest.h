//
//  MakePaymentRequest.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 1/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "BaseRequest.h"

///Request for make payment
@interface MakePaymentRequest : BaseRequest

///Consumer card / payment instrument ID
@property long senderCardID;
///Consumer identifier
@property long senderID;
///Merchant/receiver card number
@property NSString* _Nullable receiverCardNumber;
///Merchant/receiver name
@property NSString* _Nullable receiverName;
///Currency code
@property NSString* _Nullable currency;
///Transaction amount total includes the tip
@property double transactionAmountTotal;
///Tip amount in currency
@property double tipAmount;
///Merchant terminal number
@property NSString* _Nullable terminalNumber;

///Initializer of the request with acceess code and all parameter required
- (id _Nonnull) initWithAccesCode:(NSString*_Nullable) accessCode senderID:(long) senderID senderCardID:(long) senderCardID receiverCardNumber:(NSString* _Nullable) receiverCardNumber receiverName:(NSString* _Nullable) receiverName currency:(NSString* _Nullable) currency transactionAmountTotal:(double) transactionAmountTotal tipAmount:(double) tipAmount terminalNumber:(NSString* _Nullable) terminalNumber;

@end
