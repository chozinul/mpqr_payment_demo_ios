//
//  TransactionListViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 27/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "TransactionListViewController.h"
#import "MPQRService.h"
#import "Transaction.h"
#import "UserManager.h"
#import "PaymentInstrument.h"
#import "TransactionDetailViewController.h"
#import "CurrencyFormatter.h"
#import "TransactionsRequest.h"
#import "LoginManager.h"
#import "LoginResponse.h"

@import Realm;

@interface TransactionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgviewStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchant;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end

@implementation TransactionViewCell


@end

/**
 This class is to display all the transaction that has been done by particulat payment instrument (card)
 It will retrieve the transaction data from the MPQR server and display it
 
 */
@interface TransactionListViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblAcquirer;
@property (weak, nonatomic) IBOutlet UILabel *lblMaskedIdentifier;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray<Transaction*> * transactionList;
@end

@implementation TransactionListViewController

/**
setup necessary user interface
get the data from the MPQR server
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* senderMaskIdentified = [[UserManager sharedInstance] getDefaultCard].maskedIdentifier;
    NSString* senderAcquiredName = [[UserManager sharedInstance] getDefaultCard].acquirerName;
    long cardID = [[UserManager sharedInstance] getDefaultCard].id;
    
    self.lblAcquirer.text = senderAcquiredName;
    self.lblMaskedIdentifier.text = senderMaskIdentified;
    
    //retirve the data from MPQR server
    NSString* accessCode = [LoginManager sharedInstance].loginInfo.accessCode;
    TransactionsRequest* request = [[TransactionsRequest alloc] initWithAccessCode:accessCode senderCardIdentifier:cardID];
    [[MPQRService sharedInstance] getTransactionsParameters:request
                                                    success:^(RLMResults<Transaction*> *list){
                                                        
                                                        NSMutableArray* array = [NSMutableArray array];
                                                        for(int i = 0; i < list.count; i++)
                                                        {
                                                            Transaction* transaction = [list objectAtIndex: list.count - i - 1];
                                                            [array addObject:transaction];
                                                        }
                                                        self.transactionList = array;
                                                        [_tableView reloadData];
                                                        
                                                    } failure:^(NSError* error){
                                                        
                                                    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
///number of section of the table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

///number of data should be displayed in table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transactionList.count;
}

///configure table view cell based on each transaction
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionViewCell" forIndexPath:indexPath];
    Transaction* trans = [_transactionList objectAtIndex:indexPath.row];
    cell.lblMerchant.text = trans.merchantName;
    cell.lblMoney.text = [NSString stringWithFormat:@"%@", [CurrencyFormatter getFormattedAmountWithValue:trans.transactionAmount + trans.tipAmount]];
    cell.lblDate.text = [trans getFormattedTransactionDate];
    return cell;
}

///height of the table view
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath
{
    return 90;
}

#pragma mark - Table view delegate
/**
 Select particular transaction data from the list of transactions
 Open detailed transaction page
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Transaction* trans = [_transactionList objectAtIndex:indexPath.row];
    
    TransactionDetailViewController* tDetailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionDetailViewController"];
    tDetailVC.transaction = trans;
    [self.navigationController pushViewController:tDetailVC animated:YES];
}

@end
