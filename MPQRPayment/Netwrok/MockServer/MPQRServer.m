//
//  MPQRServer.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "MPQRServer.h"
#include <stdlib.h>
#import "LoginResponse.h"
#import "PaymentInstrument.h"
#import "LoginRequest.h"
#import "GetUserInfoRequest.h"
#import "ChangeDefaultCardRequest.h"
#import "TransactionsRequest.h"
#import "MakePaymentRequest.h"


#import "PaymentInstrument.h"
#import "Transaction.h"
#import "User.h"


#import "RLMPaymentInstrument.h"
#import "RLMTransaction.h"
#import "RLMUser.h"

/**
 This class behaves as mock server for the mobile payment demo
 This class is responsible for managing user, payment, transaction data
 The data is stored in Realm database
 Modification and Creation of the data are done here
 */
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

#pragma mark - REST API
- (nullable NSURLSessionDataTask *)GET:(nullable NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    /**
     Return user information that has been created when user login
     */
    if ([URLString isEqualToString:@"/getuserinfo"]) {
        [self handleGetUserInfoWithParameters:parameters success:success failure:failure];
    }
    
    /**
     Given card identifier, It will retrive corresponding transactions
     It will return list of transaction as response
     */
    if ([URLString isEqualToString:@"/transactions"]) {
        [self handleTransactionWithParameters:parameters success:success failure:failure];
    }
    
    return nil;
}


- (nullable NSURLSessionDataTask *)POST:(nullable NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    /**
     Validate the login, i.e. password must be 123456
     Create new user, new user ID is based on access code
     Return login respond
     */
    if ([URLString isEqualToString:@"/login"]) {
        [self handleLoginParameters:parameters success:success failure:failure];
    }
    
    /**
     User default card change
     The default card is the card that being used for next transaction
     It will return the user object as response
     */
    if ([URLString isEqualToString:@"/changedefaultcard"]) {
        [self handleChangeDefaultCardWithParameters:parameters success:success failure:failure];
    }
    
    /**
     Make payment
     It will check if the balance of default card is enough
     It will deduct the amount of the default card
     It will create new transaction
     It will assign the transaction to the user
     It will return transaction as response
     */
    if ([URLString isEqualToString:@"/makepayment"]) {
        [self handleMakePaymentWithParameters:parameters success:success failure:failure];
    }
    
    /**
     Suppose to do necessary thing for logout in real server environment
     */
    if ([URLString isEqualToString:@"/logout"]) {
        [self handleLogoutParameters:parameters success:success failure:failure];
    }
    return nil;
}

#pragma mark - Request handler
/**
 Given card identifier, It will retrive corresponding transactions
 It will return list of transaction as response
 */
- (void) handleTransactionWithParameters:(nullable id)parameters
            success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    TransactionsRequest* request = (TransactionsRequest*) parameters;
    
    long cardId = request.senderCardIdentifier;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<RLMTransaction*> *listTemp = [RLMTransaction objectsInRealm:realm where:[NSString stringWithFormat:@"instrumentIdentifier = %ld", cardId]];
    
    NSMutableArray* list = [NSMutableArray array];
    for (int i = 0; i < listTemp.count; i++) {
        RLMTransaction* rlmTrans = [listTemp objectAtIndex:i];
        Transaction* trans = [Transaction TransactionFromRLMTransaction:rlmTrans];
        [list addObject:trans];
    }
    
    if (list.count>0) {
        success(nil, list);
    }else
    {
        NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Transaction is not found"}];
        failure(nil, error);
    }
}

/**
 Make payment
 It will check if the balance of default card is enough
 It will deduct the amount of the default card
 It will create new transaction
 It will assign the transaction to the user
 It will return transaction as response
 */
- (void) handleMakePaymentWithParameters:(nullable id)parameters
                                 success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    MakePaymentRequest* request = (MakePaymentRequest*) parameters;
    
    long senderCardID = request.senderCardID;
    long senderID = request.senderID;
    double transactionAmountTotal = request.transactionAmountTotal;
    double tipAmount = request.tipAmount;
    double total = transactionAmountTotal;
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<RLMPaymentInstrument*> *instruments = [RLMPaymentInstrument objectsInRealm:realm where:[NSString stringWithFormat:@"id = %ld", senderCardID]];
    
    RLMResults<RLMUser*> *users = [RLMUser objectsInRealm:realm where:[NSString stringWithFormat:@"id = %ld", senderID]];
    
    if (instruments.count>0 && users.count > 0) {
        RLMPaymentInstrument* instrument = [instruments objectAtIndex:0];
        RLMUser* user = [users objectAtIndex:0];
        if (instrument.balance < total) {
            NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Insuficient amount"}];
            failure(nil, error);
            return;
        }
        
        RLMTransaction* trans = [RLMTransaction new];
        trans.referenceId = [NSString stringWithFormat:@"%u",arc4random_uniform(INT_MAX)];
        trans.invoiceNumber = [NSString stringWithFormat:@"%u",arc4random_uniform(INT_MAX)];
        trans.maskedIdentifier = instrument.maskedIdentifier;
        trans.transactionAmount = transactionAmountTotal - tipAmount;
        trans.tipAmount = tipAmount;
        trans.currencyNumericCode = request.currency;
        trans.transactionDate = [NSDate new];
        trans.merchantName = request.receiverName;
        trans.instrumentIdentifier = instrument.id;
        [realm beginWriteTransaction];
        [user.transactions addObject:trans];
        instrument.balance -= total;
        [realm commitWriteTransaction];

        Transaction* transResult = [Transaction TransactionFromRLMTransaction:trans];
        success(nil, transResult);
    }else
    {
        NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Username is not found"}];
        failure(nil, error);
        return;
    }
}

/**
 User default card change
 The default card is the card that being used for next transaction
 It will return the user object as response
 */
- (void) handleChangeDefaultCardWithParameters:(nullable id)parameters
                                 success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    ChangeDefaultCardRequest* params = (ChangeDefaultCardRequest*) parameters;
    NSString* strAccessCode = params.accessCode;
    int index = params.index;
    if(!strAccessCode)
    {
        NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Access code is null"}];
        failure(nil, error);
        return;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<RLMUser*> *users = [RLMUser objectsInRealm:realm where:[NSString stringWithFormat:@"firstName = '%@'", strAccessCode]];
    if (users.count>0) {
        RLMUser* user = [users objectAtIndex:0];
        if (index < user.paymentInstruments.count) {
            [realm beginWriteTransaction];
            for (int i = 0; i < user.paymentInstruments.count; i++) {
                RLMPaymentInstrument* instrument = [user.paymentInstruments objectAtIndex:i];
                if (i == index) {
                    instrument.isDefault = true;
                }else
                {
                    instrument.isDefault = false;
                }
            }
            [realm commitWriteTransaction];
        }
        
        User* userResult = [User UserFromRLMUser:user];
        success(nil, userResult);
    }else
    {
        NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Access code is not found"}];
        failure(nil, error);
        return;
    }
}

/**
 Return user information that has been created when user login
 */
- (void) handleGetUserInfoWithParameters:(nullable id)parameters
                                       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    
    GetUserInfoRequest* params = (GetUserInfoRequest*) parameters;
    NSString* strAccessCode = params.accessCode;
    if(!strAccessCode)
    {
        NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Access code is null"}];
        failure(nil, error);
        return;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<RLMUser*> *users = [RLMUser objectsInRealm:realm where:[NSString stringWithFormat:@"firstName = '%@'", strAccessCode]];
    
    
    if (users.count>0) {
        RLMUser* user = [users objectAtIndex:0];
        User* userResult = [User UserFromRLMUser:user];
        success(nil, userResult);
    }else
    {
        NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Access code is not found"}];
        failure(nil, error);
        return;
    }
}
/**
 Validate the login, i.e. password must be 123456
 Create new user, new user ID is based on access code
 Return login respond
 */
- (void) handleLoginParameters:(nullable id)parameters
                                 success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    LoginRequest* loginRequest = (LoginRequest*) parameters;
    //isvalidcredential
    NSString* strAccesCode = loginRequest.accessCode;
    NSString* strPin = loginRequest.pin;
    if(![self isValidCredential:strAccesCode pin:strPin])
    {
        NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Invalid credential"}];
        failure(nil, error);
        return;
    }
    
    LoginResponse* loginResponse = [LoginResponse new];
    loginResponse.accessCode = strAccesCode;
    loginResponse.token = @"asdlfj09u09uewjffij";
    success(nil, loginResponse);
    
    //create user
    [self createNewUserWithUserName:strAccesCode];
}

/**
 Suppose to do necessary thing for logout in real server environment
 */
- (void) handleLogoutParameters:(nullable id)parameters
                       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    success(nil, nil);
}

#pragma mark - Helper
/**
 Print database for debug purpose
 */
- (void) printUsers
{
    RLMResults<RLMUser *> *users = [RLMUser allObjects];
    for (int i = 0; i < users.count; i++) {
        RLMUser* people = [users objectAtIndex:i];
        NSLog(people.lastName,nil);
        RLMArray<RLMTransaction *><RLMTransaction> *list = people.transactions;
        for (int i = 0; i < list.count; i++) {
            RLMTransaction* obj = [list objectAtIndex:i];
            NSLog(@"ref id = %@, invoice = %@", obj.referenceId, obj.invoiceNumber);
        }
    }
}

/**
 Check if it is valid credential
 i.e. access code has value, pin is equal to 123456
 */
- (BOOL) isValidCredential:(NSString*) accessCode pin:(NSString*) pin
{
    
    if (![pin isEqualToString:@"123456"]) {
        return false;
    }
    
    if (!accessCode) {
        return false;
    }
    return true;
}

/**
 Create new user and create new cards for the user
 */
- (void) createNewUserWithUserName:(NSString*) userName
{
    // Get the default Realm
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<RLMUser*> *users = [RLMUser objectsInRealm:realm where:[NSString stringWithFormat:@"firstName = '%@'",userName]];
    
    if (users.count > 0) {
        return;
    }
    
    RLMUser* user = [RLMUser new];
    user.id = arc4random_uniform(INT_MAX);
    user.firstName = userName;
    user.lastName = userName;
    
    RLMPaymentInstrument* instrument = [RLMPaymentInstrument new];
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
    
    instrument = [RLMPaymentInstrument new];
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
    
    instrument = [RLMPaymentInstrument new];
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
