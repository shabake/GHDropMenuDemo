//
//  GHDebugViewController.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/27.
//  Copyright © 2018年 GHome. All rights reserved.
//  gitHub:https://github.com/shabake/GHDropMenuDemo

#import "GHDebugViewController.h"
#import "UILabel+GHome.h"
#import "UIView+Extension.h"
#import "NSArray+Bounds.h"
#import "GHWaterFallLabel.h"

@interface GHDebugViewController ()
@property (nonatomic , strong) GHWaterFallLabel *waterFallLabel;
@property (nonatomic , strong) NSMutableArray *tags;

@end
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@implementation GHDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"debug";
    self.view.backgroundColor = [UIColor whiteColor];
//
//    [self.tags addObject:@"呵呵啊"];
//    [self.tags addObject:@"嘻嘻"];
//    [self.tags addObject:@"哈"];
//    [self.tags addObject:@"哦"];
//    [self.tags addObject:@"嘻嘻"];
//    [self.tags addObject:@"哈"];
//    [self.tags addObject:@"哦"];
//    [self.tags addObject:@"嘻嘻"];
//    [self.tags addObject:@"哈"];
//    [self.tags addObject:@"哦"];
//
//    GHWaterFallLabel *waterFallLabel = [GHWaterFallLabel creatWaterFallLabelWithPoint:CGPointMake(0, 64) tags:self.tags];
//    waterFallLabel.isMultiple = YES;
//    [self.view addSubview:waterFallLabel];
//    waterFallLabel.multipleBlock = ^(GHWaterFallLabel * _Nonnull waterFallLabe, NSArray * _Nonnull array) {
//        NSLog(@"%@",array);
//    };
//    waterFallLabel.textBlock = ^(GHWaterFallLabel * _Nonnull waterFallLabe, NSString * _Nonnull text, NSInteger index) {
//        NSLog(@"%@",text);
//    };
    
    UIGraphicsBeginImageContext(CGSizeMake(20, 20));
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //// Shadow Declarations
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowColor = UIColor.blackColor;
    shadow.shadowOffset = CGSizeMake(0, 0);
    shadow.shadowBlurRadius = 2;
    
    //// Rectangle Drawing
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(2, 2, 16, 16) cornerRadius: 3];
    [UIColor.whiteColor setFill];
    [rectanglePath fill];
    
    ////// Rectangle Inner Shadow
    CGContextSaveGState(context);
    CGContextClipToRect(context, rectanglePath.bounds);
    CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
    
    CGContextSetAlpha(context, CGColorGetAlpha([shadow.shadowColor CGColor]));
    CGContextBeginTransparencyLayer(context, NULL);
    {
        UIColor* opaqueShadow = [shadow.shadowColor colorWithAlphaComponent: 1];
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [opaqueShadow CGColor]);
        CGContextSetBlendMode(context, kCGBlendModeSourceOut);
        CGContextBeginTransparencyLayer(context, NULL);
        
        [opaqueShadow setFill];
        [rectanglePath fill];
        
        CGContextEndTransparencyLayer(context);
    }
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 88, kScreenWidth, 40)];
    view.backgroundColor = [UIColor colorWithPatternImage:image];
    view.contentMode = UIViewContentModeBottom;
    [self.view addSubview:view];

}

- (NSMutableArray *)tags {
    if (_tags == nil) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
@end
