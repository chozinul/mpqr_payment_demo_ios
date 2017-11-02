//
//  PinDialogViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 30/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "DialogViewController.h"

@interface PinDialogViewController : DialogViewController

@property NSString* dialogTitle;
@property NSString* dialogDescription;

@property (readonly) NSString* pin;

@end
