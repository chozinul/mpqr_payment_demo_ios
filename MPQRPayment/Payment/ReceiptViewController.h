//
//  ReceiptViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 30/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Transaction;
@class PaymentData;
@interface ReceiptViewController : UIViewController

@property Transaction* transaction;
@property PaymentData* paymentData;
@end
