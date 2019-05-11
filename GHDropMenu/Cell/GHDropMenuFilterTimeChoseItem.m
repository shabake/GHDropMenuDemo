//
//  GHDropMenuFilterTimeChoseItem.m
//  GHDropMenuDemo
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHDropMenuFilterTimeChoseItem.h"
#import "GHDropMenuModel.h"

@interface GHDropMenuFilterTimeChoseItem()<UITextFieldDelegate>
@property (nonatomic , strong)UITextField *leftTextField;
@property (nonatomic , strong)UITextField *rightTextField;
@property (nonatomic , strong)UIView *line;

@end
@implementation GHDropMenuFilterTimeChoseItem

- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.leftTextField.text = dropMenuModel.beginTime;
    self.rightTextField.text = dropMenuModel.endTime;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuFilterTimeChoseItem:type:dropMenuModel:)]) {
        [self.delegate dropMenuFilterTimeChoseItem:self type:textField.tag dropMenuModel:self.dropMenuModel];
    }
    return NO;
}

- (void)setupUI {
    [self addSubview:self.leftTextField];
    [self addSubview:self.line];
    [self addSubview:self.rightTextField];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = (self.frame.size.width - 2 * 10 - 10) / 2;
    self.leftTextField.frame = CGRectMake(0, 0, width, self.frame.size.height);
    self.line.frame = CGRectMake(width + 10, (self.frame.size.height - 1) * 0.5, 10, 1);
    self.rightTextField.frame = CGRectMake(self.line.frame.origin.x+ self.line.frame.size.width + 10, 0, width, self.frame.size.height);
}
- (UITextField *)rightTextField {
    if (_rightTextField == nil) {
        _rightTextField = [[UITextField alloc]init];
        _rightTextField.layer.cornerRadius = 10;
        _rightTextField.layer.masksToBounds = YES;
        _rightTextField.layer.borderWidth = 0.5;
        _rightTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _rightTextField.textAlignment = NSTextAlignmentCenter;
        _rightTextField.font = [UIFont systemFontOfSize:13];
        _rightTextField.textColor = [UIColor darkGrayColor];
        _rightTextField.placeholder = @"请输入结束日期";
        _rightTextField.keyboardType = UIKeyboardTypeNumberPad;
        _rightTextField.tintColor = [UIColor orangeColor];
        _rightTextField.delegate = self;
        _rightTextField.tag = GHDropMenuFilterTimeChoseItemTypeEndTime;
    }
    return _rightTextField;
}

- (UITextField *)leftTextField {
    if (_leftTextField == nil) {
        _leftTextField = [[UITextField alloc]init];
        _leftTextField.layer.cornerRadius = 10;
        _leftTextField.tag = GHDropMenuFilterTimeChoseItemTypeBeginTime;
        _leftTextField.layer.masksToBounds = YES;
        _leftTextField.layer.borderWidth = 0.5;
        _leftTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _leftTextField.textAlignment = NSTextAlignmentCenter;
        _leftTextField.font = [UIFont systemFontOfSize:13];
        _leftTextField.textColor = [UIColor darkGrayColor];
        _leftTextField.placeholder = @"请输入开始日期";
        _leftTextField.keyboardType = UIKeyboardTypeNumberPad;
        _leftTextField.tintColor = [UIColor orangeColor];
        _leftTextField.delegate = self;
    }
    return _leftTextField;
}
- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor darkGrayColor];
        _line.alpha = 0.5;
    }
    return _line;
}
@end
