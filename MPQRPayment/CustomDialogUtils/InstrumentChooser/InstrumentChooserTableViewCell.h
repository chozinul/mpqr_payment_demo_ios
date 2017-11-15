//
//  InstrumentChooserTableViewCell.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>

@import DLRadioButton;

@interface InstrumentChooserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblMaskedIndentifier;
@property (weak, nonatomic) IBOutlet UILabel *lblBalance;
@property (weak, nonatomic) IBOutlet DLRadioButton *radioDefault;

@end
