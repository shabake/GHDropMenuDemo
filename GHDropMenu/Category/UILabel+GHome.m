//
//  UILabel+GHome.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/6.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "UILabel+GHome.h"
#import <objc/runtime.h>

@implementation UILabel (GHome)
- (NSTextAttachment *)attach {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAttach:(NSTextAttachment *)attach {
    objc_setAssociatedObject(self, @selector(attach), attach, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)width {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setWidth:(CGFloat)width {
    objc_setAssociatedObject(self, @selector(width), @(width), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (CGFloat)adaptWithText: (NSString *)text
                    font: (UIFont *)font
                maxWidth: (CGFloat)maxWidth   {
    self.text = text;
    self.font = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    return size.height;
}

- (void)adaptWithText: (NSString *)text
                frame: (CGRect)frame
                 font: (UIFont *)font {
    self.text = text;
    self.font = font;
    self.numberOfLines = 0;
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, size.width, size.height);
    self.width = size.width;
}

- (void)creatRichTextWithText: (NSString *)text
                        frame: (CGRect)frame
                         font: (UIFont *)font
                    imageName: (NSString *)imageName {

    if (text.length == 0) {
        return;
    }
    text = [NSString stringWithFormat:@"%@ ",text];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:text];

    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    UIImage *image = [UIImage imageNamed:imageName];
  
    self.numberOfLines = 0;
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = image;
    attach.bounds = CGRectMake(0, 3, 10, 6);
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attach];
    self.attach = attach;
    
    [attString insertAttributedString:str atIndex:attString.length];
    
    self.attributedText = attString;
    self.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
    CGFloat labelMaxWidth = [UIScreen mainScreen].bounds.size.width / 4;/** 最大宽度*/
    CGFloat labelWidth = (size.width+ 10) > labelMaxWidth ?labelMaxWidth :size.width + 10;
    self.frame = CGRectMake((labelMaxWidth -labelWidth) * 0.5, (size.height -frame.origin.y) * 0.5, labelWidth, size.height);
}
- (void)setText: (NSString *)text imageName: (NSString *)imageName{
    [self creatRichTextWithText:text frame:self.frame font:self.font imageName:imageName];
}
@end
