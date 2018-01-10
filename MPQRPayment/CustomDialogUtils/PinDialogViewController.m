//
//  PinDialogViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 30/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "PinDialogViewController.h"
#import "ColorManager.h"


@interface PinDialogViewController ()
{
    NSString* _pin;
}
@end

/**
 This class is to input pin when transaction is about to happen
 This class is subclass of the DialogViewController
 The way you call this class is the same at calling DialogViewController
 Additional property pin can be access after finish calling this class
 */

@implementation PinDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pin = @"";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 Make the header transparent instead of having mastercard logo
 */
- (void) setupHeader:(UIView*) headerView
{
    headerView.backgroundColor = [UIColor clearColor];
}

/**
 Set the body of with the pin input and some lable
 */
- (void) setupBody:(UIView*) bodyView
{
    bodyView.backgroundColor = [UIColor whiteColor];
    
    //add Title
    UILabel* lblTitle = [UILabel new];
    lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    lblTitle.text = self.dialogTitle;
    lblTitle.numberOfLines = 0;
    lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
    lblTitle.textAlignment = NSTextAlignmentLeft;
    lblTitle.font = [UIFont boldSystemFontOfSize:18];
    [bodyView addSubview:lblTitle];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[lblTitle]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblTitle)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lblTitle(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblTitle)]];
    
    
    //add Description
    UILabel* lblBody = [UILabel new];
    lblBody.translatesAutoresizingMaskIntoConstraints = NO;
    lblBody.text = self.dialogDescription;
    lblBody.numberOfLines = 0;
    lblBody.lineBreakMode = NSLineBreakByWordWrapping;
    lblBody.textAlignment = NSTextAlignmentLeft;
    lblBody.font = [UIFont systemFontOfSize:14];
    [bodyView addSubview:lblBody];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[lblBody]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblBody)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lblTitle][lblBody(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblBody, lblTitle)]];
    
    //add pin txtfield
    UITextField* pinTextField = [UITextField new];
    pinTextField.translatesAutoresizingMaskIntoConstraints = NO;
    pinTextField.keyboardType = UIKeyboardTypeNumberPad;
    pinTextField.secureTextEntry = YES;
    [pinTextField addTarget:self
                action:@selector(textFieldDidChange:)
      forControlEvents:UIControlEventEditingChanged];
    [bodyView addSubview:pinTextField];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[pinTextField]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pinTextField)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lblBody]-10-[pinTextField(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblBody, pinTextField)]];
    
    //add line below input
    UIView* line = [UIView new];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [bodyView addSubview:line];
    line.backgroundColor = [ColorManager sharedInstance].lineDevider;
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[line]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pinTextField][line(1)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line, pinTextField)]];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    _pin = textField.text;
}

/**
 Accessing pin property
 */
- (NSString*) pin
{
    return _pin;
}
@end
