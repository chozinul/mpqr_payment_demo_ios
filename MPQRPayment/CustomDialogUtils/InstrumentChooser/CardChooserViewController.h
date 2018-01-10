//
//  CardChooserViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "DialogViewController.h"

/**
 * User can select the preferred card/payment instrument from this UI class.
 * This class is subclass of DialogViewController
 * It ask user to choose the credit card using radio button
 */
@interface CardChooserViewController : DialogViewController

///Selected card index, the correspoding card list can be obtain from `[UserManager sharedInstance].currentUser.paymentInstruments`
@property NSInteger selectedIndex;

@end
