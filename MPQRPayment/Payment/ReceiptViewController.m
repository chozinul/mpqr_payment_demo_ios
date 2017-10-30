//
//  ReceiptViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 30/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "ReceiptViewController.h"
#import "Transaction.h"
#import "PaymentData.h"
#import "Merchant.h"
#import "CurrencyEnum.h"

@interface ReceiptViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchant;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblTips;
@property (weak, nonatomic) IBOutlet UILabel *lblMaskedIdentifier;

- (IBAction)btnReturnPressed:(id)sender;

@end

@implementation ReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lblTotal.text = [NSString stringWithFormat:@"%@ %@"
                      ,[CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_transaction.currencyNumericCode]]
                      ,[_transaction getFormattedAmount]];
    _lblMerchant.text = _transaction.merchantName;
    _lblCity.text = _paymentData.merchant.city;
    _lblAmount.text = [_transaction getFormattedAmountWithValue:_transaction.transactionAmount];
    _lblTips.text = [_transaction getFormattedAmountWithValue:_transaction.tipAmount];
    _lblMaskedIdentifier.text = _transaction.maskedIdentifier;
    
    
    self.navigationItem.hidesBackButton = TRUE;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back"]  ;
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn setTitle:@" Back" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(btnReturnPressed:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 54, 20);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnReturnPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
