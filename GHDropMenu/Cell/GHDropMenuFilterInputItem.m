//
//  GHDropMenuFilterInputItem.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHDropMenuFilterInputItem.h"
#import "GHDropMenuModel.h"

@interface GHDropMenuFilterInputItem()
@property (nonatomic , strong)UITextField *leftTextField;
@property (nonatomic , strong)UITextField *rightTextField;
@property (nonatomic , strong)UIView *line;
@end
@implementation GHDropMenuFilterInputItem

- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.leftTextField.text = dropMenuModel.minPrice;
    self.rightTextField.text = dropMenuModel.maxPrice;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}
- (void)configuration {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.leftTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.rightTextField];
}

- (void)textChange: (NSNotification *)noti {
    
    if (self.leftTextField.text.length) {
        self.dropMenuModel.minPrice = self.leftTextField.text;
    }
    if (self.rightTextField.text.length) {
        self.dropMenuModel.maxPrice = self.rightTextField.text;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuFilterInputItem:dropMenuModel:)]) {
        [self.delegate dropMenuFilterInputItem:self dropMenuModel:self.dropMenuModel];
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        _rightTextField.placeholder = @"请输入最高价";
        _rightTextField.keyboardType = UIKeyboardTypeNumberPad;
        _rightTextField.tintColor = [UIColor orangeColor];
    }
    return _rightTextField;
}
- (UITextField *)leftTextField {
    if (_leftTextField == nil) {
        _leftTextField = [[UITextField alloc]init];
        _leftTextField.layer.cornerRadius = 10;
        _leftTextField.layer.masksToBounds = YES;
        _leftTextField.layer.borderWidth = 0.5;
        _leftTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _leftTextField.textAlignment = NSTextAlignmentCenter;
        _leftTextField.font = [UIFont systemFontOfSize:13];
        _leftTextField.textColor = [UIColor darkGrayColor];
        _leftTextField.placeholder = @"请输入最低价";
        _leftTextField.keyboardType = UIKeyboardTypeNumberPad;
        _leftTextField.tintColor = [UIColor orangeColor];
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
