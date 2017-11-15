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

@property UITextField* txtValue;
@property UILabel* lblTitle;
@property UIView* viewLine;

@end

@implementation MoneyInput

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubviews];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self configureSubViews];
}

- (void) prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self configureSubViews];
}

#pragma mark - Helper
- (void) addSubviews
{
    _txtValue = [UITextField new];
    _lblTitle = [UILabel new];
    _viewLine = [UIView new];
    [self addSubview:_viewLine];
    [self addSubview:_txtValue];
    [self addSubview:_lblTitle];

}
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_lblTitle][_txtValue(50)][_viewLine(2)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblTitle,_txtValue,_viewLine)]];
}

#pragma mark - Properties
- (void) setStrTitle:(NSString *)strTitle
{
    _lblTitle.text = strTitle;
}

- (NSString*) strTitle
{
    return _lblTitle.text;
}

- (void) setStrValue:(NSString *)strValue
{
    [self updateField:_txtValue withText:strValue];
}

- (NSString*) strValue
{
    NSString* text = _txtValue.text;
    text = [text stringByReplacingOccurrencesOfString:@"%" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return text;
}

- (void) setDecimalDigit:(int)decimalDigit
{
    _decimalDigit = decimalDigit;
    self.strValue = _txtValue.text;
}

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

- (void) setPercentaged:(BOOL)percentaged
{
    _percentaged = percentaged;
    if (_percentaged) {
        self.decimalDigit = 2;
    }
    self.strValue = _txtValue.text;
}

#pragma mark - textfield formating
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self updateField:textField withText:text];
    return NO;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(textFieldDidChange:)])
    {
        [_delegate textFieldDidChange:textField];
    }
}

- (void) updateField:(UITextField*) textField withText:(NSString*) text
{
    text = [text stringByReplacingOccurrencesOfString:@"." withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"%" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    double number = [text intValue] * (1.0/pow(10,_decimalDigit));
    NSString* strFormat = [NSString stringWithFormat:@"%%.%df", _decimalDigit];
    if (_percentaged) {
        strFormat = [NSString stringWithFormat:@"%%.%df %%%%", _decimalDigit];
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
