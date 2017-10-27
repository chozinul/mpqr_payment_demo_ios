//
//  MPQRServer.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "MPQRServer.h"
#import "PaymentInstrument.h"
#import "Transaction.h"
#import "User.h"
#include <stdlib.h>
#import "LoginResponse.h"
#import "PaymentInstrument.h"

@implementation MPQRServer

+ (instancetype _Nonnull)sharedInstance
{
    static MPQRServer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MPQRServer alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (nullable NSURLSessionDataTask *)GET:(nullable NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    if ([URLString isEqualToString:@"/login"]) {
        
        //isvalidcredential
        NSString* strUserName = [parameters objectForKey:@"user_name"];
        NSString* strPassword = [parameters objectForKey:@"password"];
        if(![self isValidCredential:strUserName password:strPassword])
        {
            NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Invalid credential"}];
            failure(nil, error);
            return nil;
        }
        
        LoginResponse* loginResponse = [LoginResponse new];
        loginResponse.user = strUserName;
        loginResponse.token = @"asdlfj09u09uewjffij";
        success(nil, loginResponse);
        
        //create user
        [self createNewUserWithUserName:strUserName];
    }
    
    if ([URLString isEqualToString:@"/getuserinfo"]) {
        
        //isvalidcredential
        NSString* strUserName = [parameters objectForKey:@"user_name"];
        if(!strUserName)
        {
            NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Username is null"}];
            failure(nil, error);
            return nil;
        }
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        RLMResults<User*> *users = [User objectsInRealm:realm where:[NSString stringWithFormat:@"firstName = '%@'", strUserName]];
        if (users.count>0) {
            success(nil, [users objectAtIndex:0]);
        }else
        {
            NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Username is not found"}];
            failure(nil, error);
            return nil;
        }

    }
    
    
    if ([URLString isEqualToString:@"/changedefaultcard"]) {
        
        //isvalidcredential
        NSString* strUserName = [parameters objectForKey:@"user_name"];
        int index = [[parameters objectForKey:@"index"] intValue];
        if(!strUserName)
        {
            NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Username is null"}];
            failure(nil, error);
            return nil;
        }
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        RLMResults<User*> *users = [User objectsInRealm:realm where:[NSString stringWithFormat:@"firstName = '%@'", strUserName]];
        if (users.count>0) {
            User* user = [users objectAtIndex:0];
            if (index < user.paymentInstruments.count) {
                [realm beginWriteTransaction];
                for (int i = 0; i < user.paymentInstruments.count; i++) {
                    PaymentInstrument* instrument = [user.paymentInstruments objectAtIndex:i];
                    if (i == index) {
                        instrument.isDefault = true;
                    }else
                    {
                        instrument.isDefault = false;
                    }
                }
                [realm commitWriteTransaction];
            }
            success(nil, user);
        }else
        {
            NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Username is not found"}];
            failure(nil, error);
            return nil;
        }
    }
    
    if ([URLString isEqualToString:@"/makepayment"]) {
        long senderCardID = [[parameters objectForKey:@"sender_card_id"] integerValue];
        long senderID = [[parameters objectForKey:@"sender_id"] integerValue];
        double transactionAmount = [[parameters objectForKey:@"transaction_amount"] doubleValue];
        double tip = [[parameters objectForKey:@"tip"] doubleValue];
        double total = transactionAmount + tip;
        RLMRealm *realm = [RLMRealm defaultRealm];
        RLMResults<PaymentInstrument*> *instruments = [PaymentInstrument objectsInRealm:realm where:[NSString stringWithFormat:@"id = %ld", senderCardID]];
        
        RLMResults<User*> *users = [User objectsInRealm:realm where:[NSString stringWithFormat:@"id = %ld", senderID]];
        
        if (instruments.count>0 && users.count > 0) {
            PaymentInstrument* instrument = [instruments objectAtIndex:0];
            User* user = [users objectAtIndex:0];
            if (instrument.balance < total) {
                NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Insuficient amount"}];
                failure(nil, error);
                return nil;
            }
            
            Transaction* trans = [Transaction new];
            trans.referenceId = [NSString stringWithFormat:@"%u",arc4random_uniform(INT_MAX)];
            trans.invoiceNumber = [NSString stringWithFormat:@"%u",arc4random_uniform(INT_MAX)];
            trans.maskedIdentifier = instrument.maskedIdentifier;
            trans.transactionAmount = transactionAmount;
            trans.tipAmount = tip;
            trans.currencyNumericCode = [parameters objectForKey:@"currency"];
            trans.transactionDate = [NSDate new];
            trans.merchantName = [parameters objectForKey:@"receiver_name"];
            trans.instrumentIdentifier = instrument.id;
            [realm beginWriteTransaction];
            [user.transactions addObject:trans];
            instrument.balance -= total;
            [realm commitWriteTransaction];
            [self printUsers];
            success(nil, trans);
        }else
        {
            NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Username is not found"}];
            failure(nil, error);
            return nil;
        }
    }
    
    if ([URLString isEqualToString:@"/transactions"]) {
        long cardId = [[parameters objectForKey:@"sender_card_identifier"] integerValue];
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        RLMResults<Transaction*> *list = [Transaction objectsInRealm:realm where:[NSString stringWithFormat:@"instrumentIdentifier = %ld", cardId]];
        
        if (list.count>0) {
            success(nil, list);
        }else
        {
            NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Transaction is not found"}];
            failure(nil, error);
            return nil;
        }
    }
    
    return nil;
}

#pragma mark - Helper
- (void) printUsers
{
    RLMResults<User *> *users = [User allObjects];
//    RLMResults<PaymentInstrument *> *instruments = [PaymentInstrument allObjects];
    for (int i = 0; i < users.count; i++) {
        User* people = [users objectAtIndex:i];
        NSLog(people.lastName,nil);
        RLMArray<Transaction *><Transaction> *list = people.transactions;
        for (int i = 0; i < list.count; i++) {
            Transaction* obj = [list objectAtIndex:i];
            NSLog(@"ref id = %@, invoice = %@", obj.referenceId, obj.invoiceNumber);
        }
    }
}
#pragma mark - Login
- (BOOL) isValidCredential:(NSString*) strUserName password:(NSString*) strPassword
{
    
    if (![strPassword isEqualToString:@"123456"]) {
        return false;
    }
    
    if (!strUserName) {
        return false;
    }
    return true;
}

- (void) createNewUserWithUserName:(NSString*) userName
{
    // Get the default Realm
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<User*> *users = [User objectsInRealm:realm where:[NSString stringWithFormat:@"firstName = '%@'",userName]];
    
    if (users.count > 0) {
        return;
    }
    
    User* user = [User new];
    user.id = arc4random_uniform(INT_MAX);
    user.firstName = userName;
    user.lastName = userName;
    
    PaymentInstrument* instrument = [PaymentInstrument new];
    instrument.id = arc4random_uniform(INT_MAX);
    instrument.acquirerName = @"Mastercard";
    instrument.issuerName = @"Ecobank";
    instrument.name = @"MastercardGold";
    instrument.methodType = @"DebitCard";
    instrument.balance = 5100.2;
    instrument.maskedIdentifier = @"**** 0006";
    instrument.currencyNumericCode = @"356";
    instrument.isDefault = TRUE;
    [user.paymentInstruments addObject:instrument];
    
    instrument = [PaymentInstrument new];
    instrument.id = arc4random_uniform(INT_MAX);
    instrument.acquirerName = @"Mastercard";
    instrument.issuerName = @"Ecobank";
    instrument.name = @"MastercardBlack";
    instrument.methodType = @"CreditCard";
    instrument.balance = 2500.90;
    instrument.maskedIdentifier = @"**** 5101";
    instrument.currencyNumericCode = @"356";
    instrument.isDefault = false;
    [user.paymentInstruments addObject:instrument];
    
    instrument = [PaymentInstrument new];
    instrument.id = arc4random_uniform(INT_MAX);
    instrument.acquirerName = @"Mastercard";
    instrument.issuerName = @"Ecobank";
    instrument.name = @"MastercardBlack";
    instrument.methodType = @"SavingsAccount";
    instrument.balance = 2800.00;
    instrument.maskedIdentifier = @"**** 5102";
    instrument.currencyNumericCode = @"356";
    instrument.isDefault = false;
    [user.paymentInstruments addObject:instrument];
    
    // Add to Realm with transaction
    [realm beginWriteTransaction];
    [realm addObject:user];
    [realm commitWriteTransaction];
}

@end
