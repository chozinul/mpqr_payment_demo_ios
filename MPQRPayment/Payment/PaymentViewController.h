//
//  PaymentViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class PaymentData;
/**
 This class is responsible for:
    - Displaying transaction value
    - Calling other class to modify transaction value
    - Calling other class to do transaction
    - Calling receipt upon successful transaction
 */
@interface PaymentViewController : BaseViewController

///Payment data to be used to do transaction
@property PaymentData* paymentData;

@end
