//
//  NSString+Size.m
//  Field
//
//  Created by 赵治玮 on 2017/11/9.
//  Copyright © 2017年 赵治玮. All rights reserved.
//  gitHub:https://github.com/shabake/GHDropMenuDemo

#import "NSString+Size.h"

@implementation NSString (Size)
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
 
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    
}
@end
