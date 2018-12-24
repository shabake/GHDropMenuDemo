//
//  NSString+Size.h
//  Field
//
//  Created by 赵治玮 on 2017/11/9.
//  Copyright © 2017年 赵治玮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
