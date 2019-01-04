//
//  GHDropMenuFilterSectionHeader.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHDropMenuFilterSectionHeader.h"
#import "GHDropMenuModel.h"
#import "NSString+Size.h"

@interface GHDropMenuFilterSectionHeader()

@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UILabel *details;
@property (nonatomic , strong) UIImageView *imageView;

@end

@implementation GHDropMenuFilterSectionHeader

- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.title.text = dropMenuModel.sectionHeaderTitle;
    self.details.text = dropMenuModel.sectionHeaderDetails.length?dropMenuModel.sectionHeaderDetails:@"全部";
    self.imageView.highlighted = dropMenuModel.sectionSeleted ? YES:NO;
    self.details.hidden = (dropMenuModel.filterCellType == GHDropMenuFilterCellTypeInput  ||
                           dropMenuModel.filterCellType == GHDropMenuFilterCellTypeSingleInput )? YES:NO;
    self.imageView.hidden = self.details.hidden ;
    CGSize titleSize = [self.title.text sizeWithFont:[UIFont boldSystemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];
    self.title.frame = CGRectMake(10, 0, titleSize.width, self.frame.size.height);
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}
- (void)configuration {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}
- (void)tap:(UITapGestureRecognizer *)gesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuFilterSectionHeader:dropMenuModel:)]) {
        [self.delegate dropMenuFilterSectionHeader:self dropMenuModel:self.dropMenuModel];
    }
}
- (void)setupUI {
    [self addSubview:self.title];
    [self addSubview:self.details];
    [self addSubview:self.imageView];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize titleSize = [self.title.text sizeWithFont:[UIFont boldSystemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];
    CGSize detailsSize = [self.details.text sizeWithFont:[UIFont boldSystemFontOfSize:11] maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];
    
    self.title.frame = CGRectMake(10, 0, titleSize.width, self.frame.size.height);
    self.imageView.frame = CGRectMake(self.frame.size.width - 10 - 10, (self.frame.size.height - 5 ) * 0.5, 10, 5);
    
    self.details.frame = CGRectMake(self.frame.size.width - 10 - 15 - (self.frame.size.width - 10 - 15 - detailsSize.width), 0,self.frame.size.width - 10 - 15 - detailsSize.width, self.frame.size.height);
}
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"expand_down"];
        _imageView.highlightedImage = [UIImage imageNamed:@"expand_up"];
    }
    return _imageView;
}
- (UILabel *)details {
    if (_details == nil) {
        _details = [[UILabel alloc]init];
        _details.textAlignment = NSTextAlignmentRight;
        _details.userInteractionEnabled = YES;
        _details.font = [UIFont boldSystemFontOfSize:11];
        _details.textColor = [UIColor orangeColor];
        _details.text = @"全部";
    }
    return _details;
}
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.userInteractionEnabled = YES;
        _title.font = [UIFont boldSystemFontOfSize:14];
        _title.textColor = [UIColor darkGrayColor];
    }
    return _title;
}
@end
