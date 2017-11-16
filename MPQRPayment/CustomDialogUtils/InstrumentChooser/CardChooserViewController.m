//
//  CardChooserViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "CardChooserViewController.h"
#import "InstrumentChooserTableViewCell.h"
#import "ColorManager.h"
#import "UserManager.h"
#import "User.h"
#import "PaymentInstrument.h"
#import "CurrencyFormatter.h"
@import MasterpassQRCoreSDK;

@interface CardChooserViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView* tableView;
    NSMutableArray* arrayData;
}
@end

/**
 This class is subclass of DialogViewController
 It ask user to choose the credit card using radio button
 */
@implementation CardChooserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayData = [NSMutableArray array];
    for (int i = 0; i < [UserManager sharedInstance].currentUser.paymentInstruments.count; i++) {
        PaymentInstrument* instrument = [[UserManager sharedInstance].currentUser.paymentInstruments objectAtIndex:i];
        [arrayData addObject:instrument];
        if (instrument.isDefault) {
            _selectedIndex = i;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 Override the body setup by putting table view that contain radio button cell
 */
- (void) setupBody:(UIView*) bodyView
{
    bodyView.backgroundColor = [UIColor whiteColor];
    //add Title
    tableView = [UITableView new];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    [bodyView addSubview:tableView];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[tableView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[tableView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [UserManager sharedInstance].currentUser.paymentInstruments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InstrumentChooserTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"InstrumentChooserTableViewCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"InstrumentChooserTableViewCell" bundle:nil] forCellReuseIdentifier:@"InstrumentChooserTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"InstrumentChooserTableViewCell"];
    }

    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath
{
    return 90;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectedIndex = indexPath.row;
    [tableView reloadData];
}

#pragma mark - Configure Cell
- (void) configureCell:(InstrumentChooserTableViewCell*) cell forIndexPath:(NSIndexPath*) indexPath
{
    PaymentInstrument* instrument = [arrayData objectAtIndex:indexPath.row];
    
    //configure radio button
    cell.radioDefault.userInteractionEnabled = false;
    cell.radioDefault.iconSize = 25;
    cell.radioDefault.iconStrokeWidth = 3;
    cell.radioDefault.indicatorSize = 10;
    
    if (_selectedIndex == indexPath.row) {
        cell.radioDefault.iconColor = [ColorManager sharedInstance].radioButtonSelectedColor;
        cell.radioDefault.indicatorColor = [ColorManager sharedInstance].radioButtonSelectedColor;
        cell.radioDefault.selected = TRUE;
    }else{
        cell.radioDefault.iconColor = [ColorManager sharedInstance].radioButtonUnselectedColor;
        cell.radioDefault.indicatorColor = [ColorManager sharedInstance].radioButtonUnselectedColor;
        cell.radioDefault.selected = FALSE;
    }
    
    //balance
    NSString* alphaCode = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:instrument.currencyNumericCode]];
    int decimalPoint = [CurrencyEnumLookup getDecimalPointOfAlphaCode:alphaCode];
    cell.lblBalance.text = [CurrencyFormatter getFormattedAmountWithValue:instrument.balance decimalPoint:decimalPoint];
    
    //masked identifier
    cell.lblMaskedIndentifier.text = instrument.maskedIdentifier;
}
@end
