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
    NSArray *titles = @[@"智能排序",@"价格",@"品牌",@"筛选"];
    NSArray *data1 = @[@"价格从高到低",@"价格从低到高"];
    NSMutableArray *dataArray1 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < data1.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = data1[index];
        [dataArray1 addObject:dropMenuModel];
    }
    
    NSArray *data2 = @[@"0 - 10 元",@"10-20 元",@"20-50 元",@"50-100 元",@"100 - 1000元"];
    NSMutableArray *dataArray2 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < data2.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = data2[index];
        [dataArray2 addObject:dropMenuModel];
    }
    
    NSArray *data3 = @[@"psp",@"psv",@"nswitch"];
    NSMutableArray *dataArray3 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < data3.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = data3[index];
        [dataArray3 addObject:dropMenuModel];
    }
  
    NSArray *data4 = @[@"上午",@"下午",@"早上",@"晚上"];
    NSMutableArray *dataArray4 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < data4.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.tagName = data4[index];
        [dataArray4 addObject:dropMenuModel];
    }
    
    NSArray *data5 = @[@"呵呵",@"哈哈",@"嘿嘿",@"呵呵",@"哈哈",@"嘿嘿"];
    NSMutableArray *dataArray5 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < data5.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.tagName = data5[index];
        [dataArray5 addObject:dropMenuModel];
    }
    NSArray *sectionHeaderTitles = @[@"第一行",@"呵呵哒"];
    NSMutableArray *sections = [NSMutableArray array];
    
    for (NSInteger index = 0; index < sectionHeaderTitles.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.sectionHeaderTitle = sectionHeaderTitles[index];
        if (index == 0) {
            dropMenuModel.dataArray = dataArray4;
        } else if (index == 1) {
            dropMenuModel.dataArray = dataArray5;
        }
        [sections addObject:dropMenuModel];
    }
    NSMutableArray *titlesArray = [NSMutableArray array];
    NSArray *types = @[
                       @(GHDropMenuTypeTitle),
                       @(GHDropMenuTypeTitle),
                       @(GHDropMenuTypeTitle),
                       @(GHDropMenuTypeFilter),
                       ];
    
    for (NSInteger index = 0 ; index < titles.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = titles[index];
        NSNumber *typeNum = types[index];
        dropMenuModel.dropMenuType = typeNum.integerValue;
        if (index == 0) {
            dropMenuModel.dataArray = dataArray1;
        } else if (index == 1) {
            dropMenuModel.dataArray = dataArray2;
        } else if (index == 2) {
            dropMenuModel.dataArray = dataArray3;
        } else if (index == 3) {
            dropMenuModel.dataArray = dataArray4;
            dropMenuModel.sections = sections;
        }
        dropMenuModel.identifier = index;
        [titlesArray addObject:dropMenuModel];
    }
    
    GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
    dropMenuModel.frame = CGRectMake(0, kSafeAreaTopHeight, [UIScreen mainScreen].bounds.size.width, 44);
    dropMenuModel.titles = titlesArray.mutableCopy;
    dropMenuModel.menuHeight = 60;

    GHDropMenu *dropMenu = [[GHDropMenu alloc]creatDropMenuWithConfiguration:dropMenuModel];
    dropMenu.delegate = self;
    self.dropMenu = dropMenu;
    
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
            [string appendFormat:@"%@",dropMenuTagModel.tagName];
        }
    } else {
        [string appendFormat:@"%@",dropMenuModel.title];
    }
    self.textView.text = [NSString stringWithFormat:@"筛选结果 : %@",string];
    /** do someting your word... */
}

@end
