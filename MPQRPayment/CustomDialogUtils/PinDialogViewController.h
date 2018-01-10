//
//  PinDialogViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 30/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "DialogViewController.h"

/**
 This class is to input pin when transaction is about to happen
 This class is subclass of the DialogViewController
 The way you call this class is the same at calling DialogViewController
 Additional property pin can be access after finish calling this class
 */
@interface PinDialogViewController : DialogViewController

///Title to be displayed in the body
@property NSString* dialogTitle;

///Description to be displayed in the body
@property NSString* dialogDescription;

///Pin to be displayed in the body
@property (readonly) NSString* pin;

@end
