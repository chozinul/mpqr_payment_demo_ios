//
//  ReceiptViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 30/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "ReceiptViewController.h"
#import "Merchant.h"
#import "CurrencyFormatter.h"
#import "Receipt.h"

@interface ReceiptViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchant;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblTips;
@property (weak, nonatomic) IBOutlet UILabel *lblMaskedIdentifier;

- (IBAction)btnReturnPressed:(id)sender;

@end

/**
 This class is to display the receipt of the transaction
 */
@implementation ReceiptViewController

/**
 Set all the property of the receipt
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    _lblTotal.text = [NSString stringWithFormat:@"%@ %@"
                      ,_receipt.currencyCode
                      ,[CurrencyFormatter getFormattedAmountWithValue:_receipt.totalAmount]];

    _lblMerchant.text = _receipt.merchantName;
    _lblCity.text = _receipt.merchantCity;
    _lblAmount.text = [CurrencyFormatter getFormattedAmountWithValue:_receipt.transactionAmount];
    _lblTips.text = [CurrencyFormatter getFormattedAmountWithValue:_receipt.tipAmount];
    _lblMaskedIdentifier.text = _receipt.maskedPan;
    
    
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

- (IBAction)btnReturnPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
