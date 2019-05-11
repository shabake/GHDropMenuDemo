//
//  GHCustomAlertView.m
//  GHStudy
//
//  Created by 赵治玮 on 2017/11/12.
//  Copyright © 2017年 赵治玮. All rights reserved.
//

#import "GHCustomAlertView.h"
#import "UIView+Extension.h"
#import "GHDropMenuHeader.h"

#define kKeyWindow [UIApplication sharedApplication].keyWindow

@interface GHCustomAlertView()
@property (nonatomic , strong) UIDatePicker *picker;
@property (nonatomic , copy) NSString *time;

@end
@implementation GHCustomAlertView
#pragma mark - set
- (void)setAlertTitle:(NSString *)alertTitle {
    _alertTitle = alertTitle;
    self.title.text = alertTitle;
    self.title.width = [self sizeWithText:alertTitle font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(MAXFLOAT, 36)].width;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupDefault];
    }
    return self;
}

- (instancetype)init {
    if (self == [super init]) {
        [self setupDefault];
    }
    return self;

}
- (void)respondToTapGesture:(UITapGestureRecognizer *)ges {
    [self dismiss];
}

- (void)setupDefault {
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
    self.layer.opacity = 0.0;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.cancel];
    [self.contentView addSubview:self.sure];
    [self.contentView addSubview:self.picker];
}

- (void)show {
    [kKeyWindow addSubview:self];
    [self setCenter:kKeyWindow.center];
    [kKeyWindow bringSubviewToFront:self];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:1.0];

        if (self.positionType == GHCustomAlertViewPositionType_bottom) {
            self.contentView.frame = CGRectMake(0, kGHScreenHeight - self.alertHeight, kGHScreenWidth, self.alertHeight);
        } else if (self.positionType == GHCustomAlertViewPositionType_center) {
            self.contentView.frame = CGRectMake(0, (kGHScreenHeight - self.alertHeight)*0.5, kGHScreenWidth, self.alertHeight);
        } else if (self.positionType == GHCustomAlertViewPositionType_top) {
            self.contentView.frame = CGRectMake(0, 0, kGHScreenWidth, self.alertHeight);
        }
 
    } completion:^(BOOL finished) {
        if (self.showFinish) {
            self.showFinish();
        }
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        if (self.positionType == GHCustomAlertViewPositionType_bottom) {
            self.contentView.frame = CGRectMake(0, kGHScreenHeight, kGHScreenWidth, self.alertHeight);
        } else if (self.positionType == GHCustomAlertViewPositionType_center) {
            self.contentView.frame = CGRectMake(0, kGHScreenHeight, kGHScreenWidth, self.alertHeight);
        } else if (self.positionType == GHCustomAlertViewPositionType_top) {
            self.contentView.frame = CGRectMake(0, -self.alertHeight, kGHScreenWidth, self.alertHeight);
        }
    } completion:^(BOOL finished) {
        [self.layer setOpacity:0.0];

        [self removeFromSuperview];
        if (self.dimissFinish) {
            self.dimissFinish();
        }
    }];
}

- (void)clickButton: (UIButton *)button {
    [self dismiss];
    if (self.time.length == 0) {
        self.time = [self timeDateToString:self.picker.date];
    }
    if (self.timeBlock) {
        self.timeBlock(self.time);
    }
}

- (NSString *)timeDateToString:(NSDate *)date{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *string = [dateFormat stringFromDate:date];
    
    return string;
}

- (void)dateChange:(UIDatePicker *)date{
    self.time = [self timeDateToString:date.date];
}

#pragma mark - 返回文字的size
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark - 懒加载
- (UIButton *)sure {
    if (_sure == nil) {
        _sure = [[UIButton alloc]initWithFrame:CGRectMake(kGHScreenWidth - 15 - 60, 4, 60, 36)];
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_sure addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _sure.tag = GHCustomAlertViewButtonType_sure;
        _sure.layer.masksToBounds = YES;
        _sure.layer.borderWidth = 0.5;
        _sure.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _sure.layer.cornerRadius = 5;
        _sure.titleLabel.font = [UIFont systemFontOfSize:16];

    }
    return _sure;
}
- (UIButton *)cancel {
    if (_cancel == nil) {
        _cancel = [[UIButton alloc]initWithFrame:CGRectMake(15, 4, 60, 36)];
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_cancel addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _cancel.tag = GHCustomAlertViewButtonType_cancel;
        _cancel.layer.masksToBounds = YES;
        _cancel.layer.borderWidth = 0.5;
        _cancel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _cancel.layer.cornerRadius = 5;
        _cancel.titleLabel.font = [UIFont systemFontOfSize:16];

    }
    return _cancel;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake((kGHScreenWidth - 200 ) *0.5, 4, 200, 36)];
        _title.text = self.alertTitle;
        _title.font = [UIFont systemFontOfSize:16];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, 44, kGHScreenWidth, 0.5)];
        _line.backgroundColor = [UIColor lightGrayColor];
    }
    return _line;
}
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kGHScreenHeight, kGHScreenWidth, self.alertHeight)];
        _contentView.backgroundColor =[UIColor whiteColor];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _contentView;
}
- (UIDatePicker *)picker {
    if (_picker == nil) {
        _picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, kGHScreenWidth, 220 - 44)];
        [_picker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [_picker setCalendar:[NSCalendar currentCalendar]];
        [_picker setDate:[NSDate date]];
        _picker.datePickerMode = UIDatePickerModeDate;
        [_picker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
    }
    return _picker;
}

@end
