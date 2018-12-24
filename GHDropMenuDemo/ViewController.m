//
//  ViewController.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/14.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "ViewController.h"
#import "GHDropMenu.h"

@interface ViewController ()<GHDropMenuDelegate>
@property (nonatomic , strong)GHDropMenu *dropMenu;
@property (nonatomic , strong)UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /** 去掉导航条模糊 */
    self.navigationController.navigationBar.translucent = NO;
    
    /** 导航条名称 */
    self.navigationItem.title = @"筛选菜单";
    
    /** 配置筛选菜单模型 */
    GHDropMenuModel *configuration = [[GHDropMenuModel alloc]init];
    /** 配置筛选菜单是否记录用户选中 默认NO */
    configuration.recordSeleted = NO;
    /** 设置数据源 */
    configuration.titles = [configuration creaDropMenuData];
    
    /** 创建dropMenu 配置模型 &&frame */
    GHDropMenu *dropMenu = [[GHDropMenu alloc]creatDropMenuWithConfiguration:configuration frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    dropMenu.delegate = self;
    
    [self.view addSubview:dropMenu];
    
    
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 400, kScreenWidth, 100)];
    textView.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)dropMenu:(GHDropMenu *)dropMenu dropMenuModel:(GHDropMenuModel *)dropMenuModel tagArray:(NSArray *)tagArray {
    NSMutableString *string = [NSMutableString string];
    if (tagArray.count) {
        for (GHDropMenuModel *dropMenuTagModel in tagArray) {
            if (dropMenuTagModel.tagSeleted) {
                if (dropMenuTagModel.tagName.length) {
                    [string appendFormat:@"%@",dropMenuTagModel.tagName];
                }
            }
    
            if (dropMenuTagModel.maxPrice.length) {
                NSLog(@"%@",dropMenuTagModel.maxPrice);
                [string appendFormat:@"最大价格%@",dropMenuTagModel.maxPrice];
            }
            if (dropMenuTagModel.minPrice.length) {
                [string appendFormat:@"最小价格%@",dropMenuTagModel.minPrice];
            }
        }
    } else {
        [string appendFormat:@"%@",dropMenuModel.title];
    }
    
    self.textView.text = [NSString stringWithFormat:@"筛选结果 : %@",string];
    
    /** do someting your word... */
}

@end
