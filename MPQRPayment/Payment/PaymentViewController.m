//
//  PaymentViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentData.h"
#import "Merchant.h"
#import "MPQRService.h"
#import "Transaction.h"
#import "DialogViewController.h"
#import "PinDialogViewController.h"
#import "LoginManager.h"
#import "ReceiptViewController.h"
#import "CardChooserViewController.h"
#import "UserManager.h"
#import "PaymentInstrument.h"
#import "Receipt.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "ChangeDefaultCardRequest.h"
#import "MakePaymentRequest.h"
#import "MoneyInput.h"
#import "CurrencyFormatter.h"

@import MasterpassQRCoreSDK;

@interface PaymentViewController ()<UITextFieldDelegate, MoneyInputDelegate>
@property (weak, nonatomic) IBOutlet UILabel *merchantName;
@property (weak, nonatomic) IBOutlet UILabel *merchantCity;
@property (weak, nonatomic) IBOutlet UILabel *currency;
@property (weak, nonatomic) IBOutlet UILabel *currencySecond;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *maskedIdentifier;
@property (weak, nonatomic) IBOutlet UIView *section4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfSecondSection;
@property (weak, nonatomic) IBOutlet MoneyInput *miTransactionAmount;
@property (weak, nonatomic) IBOutlet MoneyInput *miTipAmount;

@end

/**
 This class is responsible for payment to be done
 Change default card feature is also available
 */
@implementation PaymentViewController


#pragma mark - Lifecycle
/**
 setup UI based on payment data and user data
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _merchantName.text = _paymentData.merchant.name;
    _merchantCity.text = _paymentData.merchant.city;
    _currency.text = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_paymentData.currencyNumericCode]];
    _currencySecond.text = _currency.text;
    PaymentInstrument* instrument = [[UserManager sharedInstance] getuserCardWithID:_paymentData.cardId];
    _maskedIdentifier.text = instrument.maskedIdentifier;
    
    //amount of money
    [self setInitialAmount];
    _miTransactionAmount.delegate = self;
    _miTipAmount.delegate = self;

    //back button
    self.navigationItem.hidesBackButton = TRUE;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back"]  ;
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn setTitle:@" Back" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(showCancelDialog) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 54, 20);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //keyboard behaviour to control the payment button
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //set the position of the payment button
    CGRect f = self.section4.frame;
    f.origin.y = self.view.bounds.size.height - f.size.height;
    f.origin.x = 0;
    f.size.width = self.view.bounds.size.width;
    self.section4.frame = f;
    
    [self updateUITotalAmount];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //remove observer if the page is about to disappear
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Actions
/**
 Change default card by calling the server
 Returning response is user object with change in default card
 Update UI once the default card is successful
 */
- (IBAction)changeCard:(id)sender {
    CardChooserViewController* dvg = [CardChooserViewController new];
    dvg.dialogHeight = 400;
    dvg.positiveResponse = @"Select";
    dvg.negativeResponse = @"Cancel";
    [dvg showDialogWithContex:self.navigationController
                 withYesBlock:^(DialogViewController* dialog){
                     CardChooserViewController* cardChooser = (CardChooserViewController*) dialog;
                     int index = (int)cardChooser.selectedIndex;
                     NSString* accessCode = [LoginManager sharedInstance].loginInfo.accessCode;
                     ChangeDefaultCardRequest* request = [[ChangeDefaultCardRequest alloc] initWithAccessCode:accessCode index:index];
                     [[MPQRService sharedInstance] changeDefaultCardWithParameters:request
                                                                           success:^(User* user){
                                                                               [UserManager sharedInstance].currentUser = user;
                                                                               PaymentInstrument* instrument = [[UserManager sharedInstance] getDefaultCard];
                                                                               _paymentData.cardId = instrument.id;
                                                                               _maskedIdentifier.text = instrument.maskedIdentifier;
                                                                           } failure:^(NSError* error){
                                                                               [self showAlertWithTitle:@"Error" message:@"Cannot change default card at this moment. Please try again."];
                                                                           }];
                 } withNoBlock:^(DialogViewController* dialog){
                     
                 }];
    
}

/**
 Payment with reconfirm pin and use payment data
 Login to server again to reconfirm pin
 Make payment with payment data
 Show receipt once the payment is done
 */
- (IBAction)pay:(id)sender {
    PinDialogViewController* dvg = [PinDialogViewController new];
    dvg.dialogTitle = @"Enter PIN";
    dvg.dialogDescription = @"Please enter your 6-digit PIN";
    dvg.positiveResponse = @"OK";
    dvg.negativeResponse = @"Cancel";
    [dvg showDialogWithContex:self.navigationController
                 withYesBlock:^(DialogViewController* dialog){
                     
                     PinDialogViewController* pinDialog = (PinDialogViewController*) dialog;
                     NSString* strAccessCode = [LoginManager sharedInstance].loginInfo.accessCode;
                     NSString* strPin = pinDialog.pin;
                     
                     LoginRequest* lRequest = [[LoginRequest alloc] initWithAccessCode:strAccessCode pin:strPin];
                     
                     [[MPQRService sharedInstance] loginWithParameters:lRequest
                                                               success:^(LoginResponse* lResponse){
                                                                   [LoginManager sharedInstance].loginInfo = lResponse;
                                                                   NSNumber* senderId = [NSNumber numberWithInteger:_paymentData.userId];
                                                                   NSNumber* cardID = [NSNumber numberWithInteger:_paymentData.cardId];
                                                                   NSString* mastercardID = _paymentData.merchant.identifierMastercard04;
                                                                   NSString* merchantName = _paymentData.merchant.name;
                                                                   NSString* currency = _paymentData.currencyNumericCode;
                                                                   NSNumber* transactionAmountTotal = [NSNumber numberWithDouble:[self calculateTotalAmount]];
                                                                   NSNumber* tip = [NSNumber numberWithDouble:[self calculateTipAmount]];
                                                                   NSString* terminalNumber = _paymentData.merchant.terminalNumber;
                                                                   MakePaymentRequest* request = [[MakePaymentRequest alloc]
                                                                                                  initWithAccesCode:strAccessCode
                                                                                                  senderID:senderId.integerValue
                                                                                                  senderCardID:cardID.integerValue
                                                                                                  receiverCardNumber:mastercardID?mastercardID:@""
                                                                                                  receiverName:merchantName?merchantName:@""
                                                                                                  currency:currency?currency:@""
                                                                                                  transactionAmountTotal:transactionAmountTotal.doubleValue
                                                                                                  tipAmount:tip.doubleValue
                                                                                                  terminalNumber:terminalNumber?terminalNumber:@""];
                                                                   [[MPQRService sharedInstance] makePaymentWithParameters:request
                                                                                                                   success:^(Transaction* transaction){
                                                                                                                           ReceiptViewController* receiptVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                                                                                                                                               instantiateViewControllerWithIdentifier:@"ReceiptViewController"];
                                                                                                                           receiptVC.receipt = [[Receipt alloc] initWithTransaction:transaction paymentData:_paymentData];
                                                                                                                           [self.navigationController pushViewController:receiptVC animated:YES];
                                                                                                                   } failure:^(NSError* error){
                                                                                                                       
                                                                                                                   }];
                                                               } failure:^(NSError* error){
                                                                   [self showAlertWithTitle:@"Verifiecation failed" message:@"Please enter valid 6 digit pin."];
                                                               }];
                 } withNoBlock:^(DialogViewController* dialog){
                     
                 }];
}

/**
 Helper to show message or error
 */
- (void) showCancelDialog{
    DialogViewController* dvg = [DialogViewController new];
    dvg.dialogMessage = @"Do you want to cancel?";
    dvg.positiveResponse = @"YES";
    dvg.negativeResponse = @"NO";
    [dvg showDialogWithContex:self.navigationController
                 withYesBlock:^(DialogViewController* dialog){
                     [self.navigationController popViewControllerAnimated:YES];
                 } withNoBlock:^(DialogViewController* dialog){
                 }];
}

/**
 Format the text 
 */
#pragma mark - Money Input Delegate
- (void)textFieldDidChange:(UITextField *)textField
{
    [self updateUITotalAmount];
}

#pragma mark - Tips and Amount Calculation
- (void) setInitialAmount
{
    NSString* alphaCode = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_paymentData.currencyNumericCode]];
    int decimalPoint = [CurrencyEnumLookup getDecimalPointOfAlphaCode:alphaCode];
    _miTransactionAmount.decimalDigit = decimalPoint;
    _miTipAmount.decimalDigit = decimalPoint;
    
//    _miTransactionAmount.strValue = [NSString stringWithFormat:@"%.2lf", _paymentData.transactionAmount];
    _miTransactionAmount.strValue = [CurrencyFormatter getFormattedAmountWithValue:_paymentData.transactionAmount decimalPoint:decimalPoint];
    if((int)_paymentData.transactionAmount)
    {
        _miTransactionAmount.enabled = false;
    }else
    {
        _miTransactionAmount.enabled = true;
    }
    
    switch (_paymentData.tipType) {
        case percentageConvenienceFee:
            _miTipAmount.strTitle = @"Percentage Tip";
            _miTipAmount.percentaged = true;
            _miTipAmount.strValue = [NSString stringWithFormat:@"%.2lf", _paymentData.tip];
            _miTipAmount.enabled = false;
            _miTipAmount.decimalDigit = 2;
            break;
        case flatConvenienceFee:
            _miTipAmount.percentaged = false;
//            _miTipAmount.strValue = [NSString stringWithFormat:@"%.2lf", _paymentData.tip];
            _miTipAmount.strValue = [CurrencyFormatter getFormattedAmountWithValue:_paymentData.tip decimalPoint:decimalPoint];
            _miTipAmount.enabled = false;
            break;
        case promptedToEnterTip:
            _miTipAmount.percentaged = false;
//            _miTipAmount.strValue = [NSString stringWithFormat:@"%.2lf", _paymentData.tip];
            _miTipAmount.strValue = [CurrencyFormatter getFormattedAmountWithValue:_paymentData.tip decimalPoint:decimalPoint];
            _miTipAmount.enabled = true;
            break;
        default:
            _miTipAmount.hidden = TRUE;
            _heightOfSecondSection.constant = 98;
            break;
    }
}

- (void) updateUITotalAmount
{
    NSString* alphaCode = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_paymentData.currencyNumericCode]];
    int decimalPoint = [CurrencyEnumLookup getDecimalPointOfAlphaCode:alphaCode];
//    _totalAmount.text = [NSString stringWithFormat:@"%.2lf", [self calculateTotalAmount]];
    NSString* str = [CurrencyFormatter getFormattedAmountWithValue:[self calculateTotalAmount] decimalPoint:decimalPoint];
    _totalAmount.text = str;
    switch (_paymentData.tipType) {
        case percentageConvenienceFee:
        case flatConvenienceFee:
        case promptedToEnterTip:
            break;
        default:
            _miTipAmount.hidden = TRUE;
            _heightOfSecondSection.constant = 98;
            break;
    }
}


- (double) calculateTotalAmount
{
    double totalAmount = 0;
    switch (_paymentData.tipType) {
        case percentageConvenienceFee:
        case flatConvenienceFee:
            totalAmount = _miTransactionAmount.strValue.doubleValue + [_paymentData getTipAmount];
            break;
        case promptedToEnterTip:
            totalAmount = _miTransactionAmount.strValue.doubleValue + _miTipAmount.strValue.doubleValue;
            break;
        default:
            totalAmount = _miTransactionAmount.strValue.doubleValue;
            break;
    }
    return totalAmount;
}


- (double) calculateTipAmount
{
    double tipAmount = 0;
    switch (_paymentData.tipType) {
        case percentageConvenienceFee:
        case flatConvenienceFee:
            tipAmount = [_paymentData getTipAmount];
            break;
        case promptedToEnterTip:
            tipAmount = _miTipAmount.strValue.doubleValue;
            break;
        default:
            break;
    }
    return tipAmount;
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.section4.frame;
        f.origin.y = self.view.bounds.size.height - f.size.height - keyboardSize.height;
        self.section4.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.section4.frame;
        f.origin.y = self.view.bounds.size.height - f.size.height;
        self.section4.frame = f;
    }];
}

#pragma mark - Helper

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    DialogViewController* dialogVC = [DialogViewController new];
    dialogVC.dialogMessage = message;
    dialogVC.positiveResponse = @"OK";
    [dialogVC showDialogWithContex:self
                      withYesBlock:^(DialogViewController* dialog){
                      } withNoBlock:^(DialogViewController* dialog){
                      }];
}


@end
