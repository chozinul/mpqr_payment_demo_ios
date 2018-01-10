//
//  MoneyInput.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 15/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "MoneyInput.h"
#import "ColorManager.h"

@interface MoneyInput()<UITextFieldDelegate>

///TextField to input value
@property UITextField* txtValue;
///Title of the value
@property UILabel* lblTitle;
///New line under value text field, so that it looks like material design
@property UIView* viewLine;

@end

@implementation MoneyInput

///Initializer
- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

///Initializer from serializable bject
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubviews];
    }
    return self;
}

///Configure subview in this layoutsubview
- (void) layoutSubviews
{
    [super layoutSubviews];
    [self configureSubViews];
}

///Prepare for interface builder regarding IBDesignable
- (void) prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self configureSubViews];
}

#pragma mark - Helper
///Added sub-view to the controller
- (void) addSubviews
{
    _txtValue = [UITextField new];
    _lblTitle = [UILabel new];
    _viewLine = [UIView new];
    [self addSubview:_viewLine];
    [self addSubview:_txtValue];
    [self addSubview:_lblTitle];

}

///Configure subviews
- (void) configureSubViews
{
    _lblTitle.translatesAutoresizingMaskIntoConstraints = false;
    _txtValue.translatesAutoresizingMaskIntoConstraints = false;
    _viewLine.translatesAutoresizingMaskIntoConstraints = false;
    
    _lblTitle.font = [UIFont systemFontOfSize:12];
    
    _txtValue.font = [UIFont systemFontOfSize:20.0];
    _txtValue.borderStyle = UITextBorderStyleNone;
    _txtValue.keyboardType = UIKeyboardTypeNumberPad;
    _txtValue.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _txtValue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _txtValue.delegate = self;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_lblTitle]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblTitle)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_txtValue]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_txtValue)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_viewLine]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_viewLine)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_lblTitle][_txtValue(30)][_viewLine(2)]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblTitle,_txtValue,_viewLine)]];
}

#pragma mark - Properties
///Setter
- (void) setStrTitle:(NSString *)strTitle
{
    _lblTitle.text = strTitle;
}

///Getter
- (NSString*) strTitle
{
    return _lblTitle.text;
}

///Setter: set to the field
- (void) setStrValue:(NSString *)strValue
{
    [self updateField:_txtValue withText:strValue];
}

///Getter: Get value in digit only, if there is % remove it
- (NSString*) strValue
{
    NSString* text = _txtValue.text;
    text = [text stringByReplacingOccurrencesOfString:@"%" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return text;
}

///Setter: set decimal digit and update the value display
- (void) setDecimalDigit:(int)decimalDigit
{
    _decimalDigit = decimalDigit;
    self.strValue = _txtValue.text;
}

///Getter: Set enable and configure display accordingly
- (void) setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    _txtValue.enabled = enabled;
    if (enabled) {
        _lblTitle.textColor = [ColorManager sharedInstance].textFieldEnabledTitleColor;
        _viewLine.backgroundColor = [ColorManager sharedInstance].textFieldEnabledLineColor;
        _txtValue.tintColor = [ColorManager sharedInstance].textFieldEnabledLineColor;
        self.backgroundColor = [ColorManager sharedInstance].textFieldEnabledBackgroundColor;
    }else
    {
        _lblTitle.textColor = [ColorManager sharedInstance].textFieldDisabledTitleColor;
        _viewLine.backgroundColor = [ColorManager sharedInstance].textFieldDisabledLineColor;
        _txtValue.tintColor = [ColorManager sharedInstance].textFieldDisabledLineColor;
        self.backgroundColor = [ColorManager sharedInstance].textFieldDisabledBackgroundColor;
    }
}

///Set percentage and configure display accordingly
- (void) setPercentaged:(BOOL)percentaged
{
    _percentaged = percentaged;
    if (_percentaged) {
        self.decimalDigit = 2;
    }
    self.strValue = _txtValue.text;
}

#pragma mark - textfield formating
///TextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

///TextField delegate: configure text field using defined behaviour instead of normal behaviour
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self updateField:textField withText:text];
    return NO;
}

///TextField delegate
- (void)textFieldDidChange:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(textFieldDidChange:)])
    {
        [_delegate textFieldDidChange:textField];
    }
}

///Configure TextField based on the defined behaviour instead of normal behaviour
- (void) updateField:(UITextField*) textField withText:(NSString*) text
{
    text = [text stringByReplacingOccurrencesOfString:@"." withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"%" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    double number = [text intValue] * (1.0/pow(10,_decimalDigit));
    NSString* strFormat;
    if (_percentaged) {
        strFormat = [NSString stringWithFormat:@"%%.%dlf %%%%", _decimalDigit];
    }else{
        strFormat = [NSString stringWithFormat:@"%%.%dlf", _decimalDigit];
    }
    NSString* finalText = [NSString stringWithFormat:strFormat, number];
    textField.text = finalText;
    if (number < 0.0000001) {
        textField.textColor = [ColorManager sharedInstance].textFieldZeroValueColor;
    }else
    {
        textField.textColor = [ColorManager sharedInstance].textFieldNonZeroValueColor;
    }
    if (_percentaged) {
        UITextPosition* pos = textField.endOfDocument;
        pos = [textField positionFromPosition:pos offset:-2];
        textField.selectedTextRange = [textField textRangeFromPosition:pos toPosition:pos];
    }
    [self textFieldDidChange:textField];
}

@end
