//
//  GHDropMenuModel.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHDropMenuModel.h"
#import "NSArray+Bounds.h"
#import "NSString+Arc4random.h"

@implementation GHDropMenuModel
- (NSArray *)creatRandomDropMenuData {
    /** 构造第一列数据 */
    NSMutableArray *dataArray1 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < 4; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [NSString stringWithFormat:@"%@第1列第%ld行",[NSString arc4randomStringWithCount:10 minCount:4],(long)index];
        [dataArray1 addObject:dropMenuModel];
    }
    
    /** 构造第二列数据 */
    NSMutableArray *dataArray2 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < 5; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [NSString stringWithFormat:@"%@第2列第%ld行",[NSString arc4randomStringWithCount:10 minCount:4],(long)index];
        [dataArray2 addObject:dropMenuModel];
    }
    
    /** 构造第三列数据 */
    NSMutableArray *dataArray3 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < 7; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [NSString stringWithFormat:@"%@第3列第%ld行",[NSString arc4randomStringWithCount:10 minCount:4],(long)index];
        [dataArray3 addObject:dropMenuModel];
    }
    
    /** 构造第四列数据 */
    NSMutableArray *dataArray4 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < 7; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [NSString stringWithFormat:@"%@第4列第%ld行",[NSString arc4randomStringWithCount:10 minCount:4],(long)index];
        [dataArray4 addObject:dropMenuModel];
    }
    
    NSMutableArray *titlesArray = [NSMutableArray array];
    NSArray *types = @[
                       @(GHDropMenuTypeTitle),
                       @(GHDropMenuTypeTitle),
                       @(GHDropMenuTypeTitle),
                       @(GHDropMenuTypeTitle),
                       ];
    /** 菜单标题 */
    NSArray *titles = @[@"智能排序",@"价格",@"品牌",@"时间1"];

    for (NSInteger index = 0 ; index < titles.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = titles[index];
        dropMenuModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
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
        }
        dropMenuModel.identifier = index;
        [titlesArray addObject:dropMenuModel];
    }
    return titlesArray;
}
- (NSArray *)creatNormalDropMenuData {
    
    /** 构造第一列数据 */
    NSArray *line1 = @[@"价格从高到低",@"价格从低到高",@"距离从远到近",@"销量从低到高",@"信用从高到低"];
    NSMutableArray *dataArray1 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < line1.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [line1 by_ObjectAtIndex:index];
        [dataArray1 addObject:dropMenuModel];
    }
    
    /** 构造第二列数据 */
    NSArray *line2 = @[@"0 - 10 元",@"10-20 元",@"20-50 元",@"50-100 元",@"100 - 1000元",@"1000 - 10000 元",@"10000-100000 元",@"100000-500000 元",@"500000-1000000 元",@"1000000以上"];
    NSMutableArray *dataArray2 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < line2.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [line2 by_ObjectAtIndex:index];
        [dataArray2 addObject:dropMenuModel];
    }
    
    /** 构造第三列数据 */
    NSArray *line3 = @[@"psp",@"psv",@"nswitch",@"gba",@"gbc",@"gbp",@"ndsl",@"3ds"];
    NSMutableArray *dataArray3 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < line3.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [line3 by_ObjectAtIndex:index];
        dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTagCollection;
        [dataArray3 addObject:dropMenuModel];
    }
    
    /** 构造第四列数据 */
    NSArray *line4 = @[@"上午",@"下午",@"早上",@"晚上",@"清晨",@"黄昏"];
    NSMutableArray *dataArray4 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < line4.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [line4 by_ObjectAtIndex:index];
        [dataArray4 addObject:dropMenuModel];
    }
    
    NSMutableArray *titlesArray = [NSMutableArray array];
    NSArray *types = @[
                       @(GHDropMenuTypeTitle),
                       @(GHDropMenuTypeTitle),
                       @(GHDropMenuTypeTitle),
                       @(GHDropMenuTypeTitle),
                       ];
    /** 菜单标题 */
    NSArray *titles = @[@"智能排序",@"价格",@"品牌",@"时间1"];
    
    for (NSInteger index = 0 ; index < titles.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = titles[index];
        dropMenuModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
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
        }
        dropMenuModel.identifier = index;
        [titlesArray addObject:dropMenuModel];
    }
    return titlesArray;
}
- (NSArray *)creaDropMenuData {
    
    /** 构造第一列数据 */
    NSArray *line1 = @[@"价格从高到低",@"价格从低到高",@"距离从远到近",@"销量从低到高",@"信用从高到低"];
    NSMutableArray *dataArray1 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < line1.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [line1 by_ObjectAtIndex:index];
        [dataArray1 addObject:dropMenuModel];
    }
    
    /** 构造第二列数据 */
    NSArray *line2 = @[@"0 - 10 元",@"10-20 元",@"20-50 元",@"50-100 元",@"100 - 1000元",@"1000 - 10000 元",@"10000-100000 元",@"100000-500000 元",@"500000-1000000 元",@"1000000以上"];
    NSMutableArray *dataArray2 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < 1; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [line2 by_ObjectAtIndex:index];
        dropMenuModel.waterFallTags = line2;
        [dataArray2 addObject:dropMenuModel];
    }
    
    /** 构造第三列数据 */
    NSArray *line3 = @[@"psp",@"psv",@"nswitch",@"gba",@"gbc",@"gbp",@"ndsl",@"3ds"];
    NSMutableArray *dataArray3 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < line3.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [line3 by_ObjectAtIndex:index];
        [dataArray3 addObject:dropMenuModel];
    }
    
    /** 构造右侧弹出筛选菜单第一行数据 */
    NSArray *row1 = @[@"上午",@"下午",@"早上",@"晚上",@"清晨",@"黄昏"];
    NSMutableArray *dataArray4 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < row1.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.tagName = [row1 by_ObjectAtIndex:index];
        [dataArray4 addObject:dropMenuModel];
    }
    /** 构造右侧弹出筛选菜单第二行数据 */
    NSArray *row2 = @[@"呵呵",@"哈哈",@"嘿嘿",@"呵呵",@"哈哈",@"嘿嘿"];
    NSMutableArray *dataArray5 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < row2.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.tagName = [row2 by_ObjectAtIndex:index];
        [dataArray5 addObject:dropMenuModel];
    }
    
    /** 构造右侧弹出筛选菜单第三行数据 */
    NSMutableArray *dataArray6 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < 1; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        [dataArray6 addObject:dropMenuModel];
    }
    
    /** ... */
    NSArray *row4 = @[@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录"];
    NSMutableArray *dataArray7 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < row4.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.tagName = [row4 by_ObjectAtIndex:index];
        [dataArray7 addObject:dropMenuModel];
    }
    
    NSArray *row5 = @[@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录"];
    NSMutableArray *dataArray8 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < row5.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.tagName = [row5 by_ObjectAtIndex:index];
        [dataArray8 addObject:dropMenuModel];
    }
    
    NSMutableArray *dataArray9 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < 1; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        [dataArray9 addObject:dropMenuModel];
    }
    
    /** 设置构造右侧弹出筛选菜单每行的标题 */
    NSArray *sectionHeaderTitles = @[@"单选",@"多选",@"价格",@"多数据单选",@"多数据多选",@"输入框"];
    NSMutableArray *sections = [NSMutableArray array];
    
    for (NSInteger index = 0; index < sectionHeaderTitles.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.sectionHeaderTitle = sectionHeaderTitles[index];
        
        if (index == 0) {
            dropMenuModel.dataArray = dataArray4;
            /** 单选 */
            dropMenuModel.isMultiple = NO;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
        } else if (index == 1) {
            dropMenuModel.dataArray = dataArray5;
            /** 多选 */
            dropMenuModel.isMultiple = YES;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
            
        } else if (index == 2) {
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeInput;
            dropMenuModel.dataArray = dataArray6;
        } else if (index == 3){
            dropMenuModel.dataArray = dataArray7;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
        } else if (index == 4) {
            dropMenuModel.dataArray = dataArray8;
            dropMenuModel.isMultiple = YES;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
        } else if (index == 5) {
            dropMenuModel.dataArray = dataArray9;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeSingleInput;
        }
        [sections addObject:dropMenuModel];
    }
    
    NSArray *sectionHeader1Titles = @[@"单选",@"多选",@"价格",@"多数据单选",@"多数据多选",@"输入框"];
    NSMutableArray *section1s = [NSMutableArray array];
    
    for (NSInteger index = 0; index < sectionHeader1Titles.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.sectionHeaderTitle = sectionHeader1Titles[index];
        
        if (index == 0) {
            dropMenuModel.dataArray = dataArray4;
            /** 单选 */
            dropMenuModel.isMultiple = NO;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
        } else if (index == 1) {
            dropMenuModel.dataArray = dataArray5;
            /** 多选 */
            dropMenuModel.isMultiple = YES;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
        } else if (index == 2) {
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeInput;
            dropMenuModel.dataArray = dataArray6;
        } else if (index == 3){
            dropMenuModel.dataArray = dataArray7;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
        } else if (index == 4) {
            dropMenuModel.dataArray = dataArray8;
            dropMenuModel.isMultiple = YES;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
        } else if (index == 5) {
            dropMenuModel.dataArray = dataArray9;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeSingleInput;
        }
        [section1s addObject:dropMenuModel];
    }
    
    NSMutableArray *titlesArray = [NSMutableArray array];
    NSArray *types = @[
                       @(GHDropMenuTypeTitle),
                       @(GHDropMenuTypeTitle),
                       @(GHDropMenuTypeOptionCollection),
                       @(GHDropMenuTypeFilter),
                       ];
    /** 菜单标题 */
    NSArray *titles = @[@"智能排序",@"价格",@"品牌1",@"筛选"];
    
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
//            dropMenuModel.dataArray = dataArray3;
            dropMenuModel.sections = section1s;
            dropMenuModel.sectionCount = 4.01;
            dropMenuModel.menuWidth = [UIScreen mainScreen].bounds.size.width;

        } else if (index == 3) {
            dropMenuModel.dataArray = dataArray4;
            dropMenuModel.sections = sections;
            dropMenuModel.sectionCount = 3.01;
            dropMenuModel.menuWidth = [UIScreen mainScreen].bounds.size.width * 0.9;
        }
        dropMenuModel.identifier = index;
        [titlesArray addObject:dropMenuModel];
    }
    return titlesArray;
}
- (NSArray *)creaFilterDropMenuData {
    
    
    /** 构造右侧弹出筛选菜单第一行数据 */
    NSArray *row1 = @[@"上午",@"下午",@"早上",@"晚上",@"清晨",@"黄昏"];
    NSMutableArray *dataArray4 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < row1.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.tagName = [row1 by_ObjectAtIndex:index];
        [dataArray4 addObject:dropMenuModel];
    }
    /** 构造右侧弹出筛选菜单第二行数据 */
    NSArray *row2 = @[@"呵呵",@"哈哈"];
    NSMutableArray *dataArray5 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < row2.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.tagName = [row2 by_ObjectAtIndex:index];
        [dataArray5 addObject:dropMenuModel];
    }
    
    /** 构造右侧弹出筛选菜单第三行数据 */
    NSMutableArray *dataArray6 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < 1; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        [dataArray6 addObject:dropMenuModel];
    }
    /** ... */
    NSArray *row4 = @[@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录"];
    NSMutableArray *dataArray7 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < row4.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.tagName = [row4 by_ObjectAtIndex:index];
        [dataArray7 addObject:dropMenuModel];
    }
    
    NSArray *row5 = @[@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录",@"注",@"册用",@"户登",@"录后",@"才能首页",@"发表",@"评论录"];
    NSMutableArray *dataArray8 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < row5.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.tagName = [row5 by_ObjectAtIndex:index];
        [dataArray8 addObject:dropMenuModel];
    }
    
    
    NSMutableArray *dataArray9 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < 1; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        [dataArray9 addObject:dropMenuModel];
    }
    
    /** 设置构造右侧弹出筛选菜单每行的标题 */
    NSArray *sectionHeaderTitles = @[@"单选",@"多选",@"价格",@"多数据单选",@"多数据多选",@"输入框"];
    NSMutableArray *sections = [NSMutableArray array];
    
    for (NSInteger index = 0; index < sectionHeaderTitles.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.sectionHeaderTitle = sectionHeaderTitles[index];
        if (index == 0) {
            dropMenuModel.dataArray = dataArray4;
            /** 单选 */
            dropMenuModel.isMultiple = NO;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
        } else if (index == 1) {
            dropMenuModel.dataArray = dataArray5;
            /** 多选 */
            dropMenuModel.isMultiple = YES;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
            
        } else if (index == 2) {
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeInput;
            dropMenuModel.dataArray = dataArray6;
        }  else if (index == 3){
            dropMenuModel.dataArray = dataArray7;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
        } else if (index == 4) {
            dropMenuModel.dataArray = dataArray8;
            dropMenuModel.isMultiple = YES;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeTag;
        } else if (index == 5) {
            dropMenuModel.dataArray = dataArray9;
            dropMenuModel.filterCellType = GHDropMenuFilterCellTypeSingleInput;
        }
        [sections addObject:dropMenuModel];
    }
    NSMutableArray *titlesArray = [NSMutableArray array];
    NSArray *types = @[
                       @(GHDropMenuTypeFilter),
                       ];
    /** 菜单标题 */
    for (NSInteger index = 0 ; index < 1; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        NSNumber *typeNum = types[index];
        dropMenuModel.dropMenuType = typeNum.integerValue;
        dropMenuModel.sectionCount = 3.01f;
        dropMenuModel.menuWidth = [UIScreen mainScreen].bounds.size.width * 0.9;

        dropMenuModel.dataArray = dataArray4;
        dropMenuModel.sections = sections;
        
        dropMenuModel.identifier = index;
        [titlesArray addObject:dropMenuModel];
    }
    return titlesArray;
}
@end
