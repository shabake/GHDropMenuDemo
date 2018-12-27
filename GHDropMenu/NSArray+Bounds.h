//
//  NSArray+GH.h
//  Field
//
//  Created by 赵治玮 on 2017/11/8.
//  Copyright © 2017年 赵治玮. All rights reserved.
//  gitHub:https://github.com/shabake/GHDropMenuDemo

#import <Foundation/Foundation.h>

@interface NSArray (Bounds)
/**  数组类别，防止下标越界(越界时返回nil，需要单独处理) */
- (id)by_ObjectAtIndex:(NSUInteger)index;
@end
