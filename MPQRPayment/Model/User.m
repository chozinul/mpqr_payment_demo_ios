//
//  User.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "User.h"
#import "RLMUser.h"

@implementation User

///Initialize user object from Server Class RLMUser
+ (instancetype) UserFromRLMUser:(RLMUser*) rlmUser
{
    User* user = [User new];
    user.id = rlmUser.id;
    user.firstName = rlmUser.firstName;
    user.lastName = rlmUser.lastName;
    NSMutableArray* instrumentArray = [NSMutableArray array];
    for(int i = 0; i < rlmUser.paymentInstruments.count; i++)
    {
        PaymentInstrument* instrument = (PaymentInstrument*)[rlmUser.paymentInstruments objectAtIndex:i];
        [instrumentArray addObject:instrument];
    }
    user.paymentInstruments = instrumentArray;
    
    NSMutableArray* transactionArray = [NSMutableArray array];
    for(int i = 0; i < rlmUser.transactions.count; i++)
    {
        Transaction* trans = (Transaction*)[rlmUser.transactions objectAtIndex:i];
        [transactionArray addObject:trans];
    }
    user.transactions = transactionArray;
    return user;
}

///Method is needed if we want to make this object a key at a dictionary. Currently it is not being used
- (BOOL) isEqual:(id _Nullable)object
{
    if (![object isKindOfClass:[User class]]) {
        return false;
    }
    if (self == object) {
        return true;
    }
    User* other = (User*) object;
    BOOL idEqual = self.id == other.id;
    BOOL firstNameEqual = (!self.firstName && !other.firstName) ||[self.firstName isEqualToString:other.firstName];
    BOOL lastNameEqual = (!self.lastName && !other.lastName) ||[self.lastName isEqualToString:other.lastName];
    BOOL paymentInstrumentsEqual = (!self.paymentInstruments && !other.paymentInstruments) || [self.paymentInstruments isEqual:other.paymentInstruments];
    BOOL transactionsEqual = (!self.transactions && !other.transactions) || [self.transactions isEqual:other.transactions];
    
    return idEqual
    && firstNameEqual
    && lastNameEqual
    && paymentInstrumentsEqual
    && transactionsEqual;
}

///Method is needed if we want to make this object a key at a dictionary. Currently it is not being used.
- (NSUInteger)hash
{
    NSUInteger totalInt=0;
    totalInt += _id;
    totalInt += [_firstName hash];
    totalInt += [_lastName hash];
    totalInt += [_paymentInstruments hash];
    totalInt += [_transactions hash];
    return totalInt;
}

@end
