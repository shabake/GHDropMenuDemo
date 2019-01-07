//
//  GHComplexMenuViewController.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/29.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "GHComplexMenuViewController.h"
#import "GHDropMenu.h"
#import "GHDropMenuModel.h"

@interface GHComplexMenuViewController ()<GHDropMenuDelegate>
@property (nonatomic , strong)GHDropMenu *dropMenu;

@end

@implementation GHComplexMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self style1];
}
- (void)back {

    [super back];
    [self.dropMenu closeMenu];

}
#pragma mark - 样式1
- (void)style1 {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kGHScreenWidth, 44)];
    label.text = @"样式1";
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    /** 配置筛选菜单模型 */
    GHDropMenuModel *configuration = [[GHDropMenuModel alloc]init];
    /** 配置筛选菜单是否记录用户选中 默认NO */
    configuration.recordSeleted = NO;
  
    /** 设置数据源 */
    configuration.titles = [configuration creaDropMenuData];
    /** 创建dropMenu 配置模型 && frame */
    weakself(self);
    GHDropMenu *dropMenu = [GHDropMenu creatDropMenuWithConfiguration:configuration frame:CGRectMake(0, kGHSafeAreaTopHeight,kGHScreenWidth, 44) dropMenuTitleBlock:^(GHDropMenuModel * _Nonnull dropMenuModel) {
        weakSelf.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",dropMenuModel.title];
    } dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {
        [weakSelf getStrWith:tagArray];
    }];
    dropMenu.titleSeletedImageName = @"up_normal";
    dropMenu.titleNormalImageName = @"down_normal";
    dropMenu.delegate = self;
    dropMenu.durationTime = 0.5;
    self.dropMenu = dropMenu;
    [self.view addSubview:dropMenu];
}


#pragma mark - 代理方法;
- (void)dropMenu:(GHDropMenu *)dropMenu dropMenuTitleModel:(GHDropMenuModel *)dropMenuTitleModel {
    self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",dropMenuTitleModel.title];
}
- (void)dropMenu:(GHDropMenu *)dropMenu tagArray:(NSArray *)tagArray {
    [self getStrWith:tagArray];
}

- (void)getStrWith: (NSArray *)tagArray {
    NSMutableString *string = [NSMutableString string];
    if (tagArray.count) {
        for (GHDropMenuModel *dropMenuTagModel in tagArray) {
            if (dropMenuTagModel.tagSeleted) {
                if (dropMenuTagModel.tagName.length) {
                    [string appendFormat:@"%@",dropMenuTagModel.tagName];
                }
            }
            if (dropMenuTagModel.maxPrice.length) {
                [string appendFormat:@"最大价格%@",dropMenuTagModel.maxPrice];
            }
            if (dropMenuTagModel.minPrice.length) {
                [string appendFormat:@"最小价格%@",dropMenuTagModel.minPrice];
            }
            if (dropMenuTagModel.singleInput.length) {
                [string appendFormat:@"%@",dropMenuTagModel.singleInput];
            }
        }
    }
    self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",string];
}

@end
