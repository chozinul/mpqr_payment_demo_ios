//
//  TransactionDetailViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 27/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "TransactionDetailViewController.h"
#import "Transaction.h"
#import "CurrencyFormatter.h"

@import MasterpassQRCoreSDK;
/**
 Cell to display detailed transaction items
 */
@interface TransactionDetailViewCell ()

///Item title/description
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

///Item value
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@implementation TransactionDetailViewCell

@end

@interface TransactionDetailViewController ()
{
    ///Data source of tableView that consist of item description in the transaction
    NSArray* data;
}
///Header: total amount of the transaction including tips
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
///Header: tips amount
@property (weak, nonatomic) IBOutlet UILabel *lblTip;
///Header: transaction date
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end

@implementation TransactionDetailViewController

/**
 Setup header and data source based on transaction
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* alphaCode = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_transaction.currencyNumericCode]];
    int decimalPoint = [CurrencyEnumLookup getDecimalPointOfAlphaCode:alphaCode];
    _lblTotal.text = [NSString stringWithFormat:@"%@ %@", [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:self.transaction.currencyNumericCode]],[CurrencyFormatter getFormattedAmountWithValue:_transaction.transactionAmount + _transaction.tipAmount decimalPoint:decimalPoint]];
    _lblTip.text = [NSString stringWithFormat:@"%@ %@", [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:self.transaction.currencyNumericCode]],[CurrencyFormatter getFormattedAmountWithValue:self.transaction.tipAmount decimalPoint:decimalPoint]];
    _lblDate.text = [self.transaction getFormattedTransactionDate];
    
    data = @[@{@"title":@"MERCHANT NAME",
               @"content":self.transaction.merchantName},
             @{@"title":@"INVOICE NUMBER",
               @"content":self.transaction.invoiceNumber},
             @{@"title":@"REFERENCE ID",
               @"content":self.transaction.referenceId}
             ];
}

#pragma mark - Table view data source
///Number of section = 1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

///Number of item based on `data` source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

///Get cell and setup based on `data` source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionDetailViewCell" forIndexPath:indexPath];
    NSDictionary* dict = [data objectAtIndex:indexPath.row];
    cell.lblTitle.text = [dict objectForKey:@"title"];
    cell.lblContent.text = [dict objectForKey:@"content"];
    return cell;
}

///Default height of the item/cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath
{
    return 70;
}

@end
