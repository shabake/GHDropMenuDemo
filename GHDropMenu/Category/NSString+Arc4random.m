//
//  NSString+Arc4random.m
//  XFSSalesSecretary
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "NSString+Arc4random.h"

@implementation NSString (Arc4random)

+ (NSString *)arc4randomStringWithCount: (NSInteger)range minCount: (NSInteger)minCount {
    NSMutableString *str = [NSMutableString string];
    /** 随机生成汉字 */
    for (NSInteger index = 0; index <(arc4random() % range) + minCount ; index++) {
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger randomH = 0xA1 + arc4random()%(0xFE - 0xA1+1);
        NSInteger randomL = 0xB0 + arc4random()%(0xF7 - 0xB0+1);
        NSInteger number = (randomH<<8)+randomL;
        NSData *data = [NSData dataWithBytes:&number length:2];
        NSString *string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        [str appendString:string];
    }
    return str.mutableCopy;
}
@end
