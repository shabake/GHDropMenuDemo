//
//  GHDropMenuWaterFallCell.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/19.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHDropMenuWaterFallCell.h"
#import "GHWaterFallLabel.h"

@interface GHDropMenuWaterFallCell()
@property (nonatomic , strong) GHWaterFallLabel *waterFallLabel;
@property (nonatomic , assign) CGFloat cellHeight;

@end

@implementation GHDropMenuWaterFallCell

- (void)setTags:(NSMutableArray *)tags {
    _tags = tags;
    self.waterFallLabel.tags = tags;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.waterFallLabel];
}
- (CGFloat)getCellHeight  {
    NSLog(@"self.waterFallLabel.frame.size.height%f",self.waterFallLabel.frame.size.height);
    return self.waterFallLabel.frame.size.height;
}
- (void)layoutSubviews {
    [super layoutSubviews];
        
}

- (GHWaterFallLabel *)waterFallLabel {
    if (_waterFallLabel == nil) {
        _waterFallLabel = [[GHWaterFallLabel alloc]init];
        [_waterFallLabel setPoint:CGPointMake(0, 0)];
        _waterFallLabel.backgroundColor = [UIColor redColor];
        _waterFallLabel.textBlock = ^(GHWaterFallLabel * _Nonnull waterFallLabel, NSString * _Nonnull text, NSInteger index) {
            
        };
    }
    return _waterFallLabel;
}
@end
