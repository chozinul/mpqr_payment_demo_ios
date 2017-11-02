//
//  TransactionListViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 27/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
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

@interface TransactionListViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblAcquirer;
@property (weak, nonatomic) IBOutlet UILabel *lblMaskedIdentifier;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray<Transaction*> * transactionList;
@end

@implementation TransactionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* senderMaskIdentified = [[UserManager sharedInstance] getDefaultCard].maskedIdentifier;
    NSString* senderAcquiredName = [[UserManager sharedInstance] getDefaultCard].acquirerName;
    long cardID = [[UserManager sharedInstance] getDefaultCard].id;
    
    self.lblAcquirer.text = senderAcquiredName;
    self.lblMaskedIdentifier.text = senderMaskIdentified;
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
    // Do any additional setup after loading the view.
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transactionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionViewCell" forIndexPath:indexPath];
    Transaction* trans = [_transactionList objectAtIndex:indexPath.row];
    cell.lblMerchant.text = trans.merchantName;
    cell.lblMoney.text = [NSString stringWithFormat:@"%@", [CurrencyFormatter getFormattedAmountWithValue:trans.transactionAmount + trans.tipAmount]];
    
    cell.lblDate.text = [trans getFormattedTransactionDate];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath
{
    return 90;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Transaction* trans = [_transactionList objectAtIndex:indexPath.row];
    
    TransactionDetailViewController* tDetailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionDetailViewController"];
    tDetailVC.transaction = trans;
    [self.navigationController pushViewController:tDetailVC animated:YES];
}

@end
