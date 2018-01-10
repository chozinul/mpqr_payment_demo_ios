//
//  InstrumentChooserTableViewCell.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "InstrumentChooserTableViewCell.h"

/**
 This class is the tableViewCell to display payment instrument information, it contains radio button display. The radio button is to distinguish the selected card
 */
@implementation InstrumentChooserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
