//
//  InstrumentChooserTableViewCell.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>

@import DLRadioButton;

/**
 This class is the tableViewCell to display payment instrument information, it contains radio button display. The radio button is to distinguish the selected card
 */
@interface InstrumentChooserTableViewCell : UITableViewCell

///Display the masked ID of the payment instrument
@property (weak, nonatomic) IBOutlet UILabel *lblMaskedIndentifier;

///Display the balance of the payment instrument
@property (weak, nonatomic) IBOutlet UILabel *lblBalance;

///On if it is seleceted card, off otherwise
@property (weak, nonatomic) IBOutlet DLRadioButton *radioDefault;

@end
