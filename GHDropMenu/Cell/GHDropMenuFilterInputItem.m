//
//  GHDropMenuFilterInputItem.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHDropMenuFilterInputItem.h"
#import "GHDropMenuModel.h"

@interface GHDropMenuFilterInputItem()<UITextFieldDelegate>
@property (nonatomic , strong)UITextField *leftTextField;
@property (nonatomic , strong)UITextField *rightTextField;
@property (nonatomic , strong)UIView *line;
/** 是否存在小数点 */
@property (nonatomic , assign) BOOL isHavePoint;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        self.isHavePoint = NO;
    }
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            //首字母不能为0和小数点
            if([textField.text length] == 0){
                if(single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                
            }

            //输入的字符是否是小数点
            if (single == '.') {
                if(!self.isHavePoint)//text中还没有小数点
                {
                    self.isHavePoint = YES;
                    return YES;
                }else{
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (self.isHavePoint) {//存在小数点
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    } else{
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        } else { //输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    } else {
        return YES;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length >= 2) {
        NSString *first = [textField.text substringToIndex:1];
        /** 第一位用户输入 0 但不包含小数点 用户输入完成后讲0截取掉 */
        if ([first isEqualToString:@"0"] && ![textField.text containsString:@"."]) {
            textField.text = [textField.text substringFromIndex:1];//
        }
        /** 第一位用户输入 0 也输入了小数点 */
        if ([first isEqualToString:@"0"] && [textField.text containsString:@"."]) {
            if([textField.text rangeOfString:@"."].location != NSNotFound) {
                NSRange range;
                range = [textField.text rangeOfString:@"."];
                /** 小数点在0的后面 */
                if (range.location == 1) {
                    
                    /** 小数点不在0的后面 */
                } else if (range.location != 1) {
                    textField.text = nil;
                }
            } else {
            }
        }
    }
    if (self.leftTextField.text.length) {
        self.dropMenuModel.minPrice = self.leftTextField.text;
    }
    if (self.rightTextField.text.length) {
        self.dropMenuModel.maxPrice = self.rightTextField.text;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuFilterEndInputItem:dropMenuModel:)]) {
        [self.delegate dropMenuFilterEndInputItem:self dropMenuModel:self.dropMenuModel];
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
        _rightTextField.delegate = self;
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
