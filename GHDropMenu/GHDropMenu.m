//
//  GHDropMenu.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/14.
//  Copyright © 2018年 GHome. All rights reserved.
//  gitHub:https://github.com/shabake/GHDropMenuDemo

#import "GHDropMenu.h"
#import "NSArray+Bounds.h"
#import "NSString+Size.h"
#import "UIView+Extension.h"
#import "GHDropMenuModel.h"
#import "GHDropMenuTitleItem.h"

#pragma mark - - - -- - - -- - - - GHDropMenuCell
@interface  GHDropMenuCell : UITableViewCell
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@end
@interface GHDropMenuCell()
@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , strong) UIImageView *imgView;

@end
@implementation GHDropMenuCell
- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.title.text = dropMenuModel.title;
    self.title.textColor = dropMenuModel.cellSeleted ? dropMenuModel.optionSeletedColor:dropMenuModel.optionNormalColor;
    self.imgView.hidden = !dropMenuModel.cellSeleted;
    self.title.font = dropMenuModel.optionFont > 0 ?dropMenuModel.optionFont :[UIFont systemFontOfSize:13];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self addSubview:self.title];
    [self addSubview:self.line];
    [self addSubview:self.imgView];

}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(20, 0, 200, self.frame.size.height);
    self.line.frame = CGRectMake(20, self.frame.size.height - 1, self.frame.size.width - 40, 1);
    self.imgView.frame = CGRectMake(self.frame.size.width - 20 - 15, (self.frame.size.height - 15 ) * 0.5, 15, 15);
}
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"check_selected"];
        _imgView.hidden = YES;
    }
    return _imgView;
}
- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor darkGrayColor];
        _line.alpha = .1;
    }
    return _line;
}
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.font = [UIFont systemFontOfSize:13];
    }
    return _title;
}

#pragma mark - - - -- - - -- - - - GHDropMenuCell

@end

#pragma mark - - - - GHDropMenuFilterHeader
@class GHDropMenuFilterHeader;
@protocol GHDropMenuFilterHeaderDelegate <NSObject>
- (void)dropMenuFilterHeader: (GHDropMenuFilterHeader *)header dropMenuModel: (GHDropMenuModel *)dropMenuModel;
@end

@interface GHDropMenuFilterHeader : UICollectionReusableView
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <GHDropMenuFilterHeaderDelegate> delegate;

@end
@interface GHDropMenuFilterHeader()
@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UILabel *details;
@property (nonatomic , strong) UIImageView *imageView;

@end
@implementation GHDropMenuFilterHeader

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
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuFilterHeader:dropMenuModel:)]) {
        [self.delegate dropMenuFilterHeader:self dropMenuModel:self.dropMenuModel];
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
#pragma mark - - - - - - - - GHDropMenuFilterHeader

@end
@class GHDropMenuFilterSingleInputItem;
@protocol GHDropMenuFilterSingleInputItemDelegate <NSObject>
- (void)dropMenuFilterSingleInputItem: (GHDropMenuFilterSingleInputItem *)item dropMenuModel: (GHDropMenuModel *)dropMenuModel;
@end

@interface GHDropMenuFilterSingleInputItem : UICollectionViewCell
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <GHDropMenuFilterSingleInputItemDelegate> delegate;

@end
@interface GHDropMenuFilterSingleInputItem()
@property (nonatomic , strong)UITextField *textField;
@end
@implementation GHDropMenuFilterSingleInputItem
- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.textField.text = dropMenuModel.singleInput;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}
- (void)configuration {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.textField];
}

- (void)textChange: (NSNotification *)noti {
    self.dropMenuModel.singleInput = self.textField.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuFilterSingleInputItem:dropMenuModel:)]) {
        [self.delegate dropMenuFilterSingleInputItem:self dropMenuModel:self.dropMenuModel];
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupUI {
    [self addSubview:self.textField];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = (self.frame.size.width - 2 * 10 - 10) / 2;
    self.textField.frame = CGRectMake(0, 0, width, self.frame.size.height);
    
}
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        _textField.layer.cornerRadius = 10;
        _textField.layer.masksToBounds = YES;
        _textField.layer.borderWidth = 0.5;
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.font = [UIFont systemFontOfSize:13];
        _textField.textColor = [UIColor darkGrayColor];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.tintColor = [UIColor orangeColor];
        _textField.placeholder = @"请输入";
    }
    return _textField;
}

@end

#pragma mark - - - - - - - - GHDropMenuFilterInputItem
@class GHDropMenuFilterInputItem;
@protocol GHDropMenuFilterInputItemDelegate <NSObject>
- (void)dropMenuFilterInputItem: (GHDropMenuFilterInputItem *)item dropMenuModel: (GHDropMenuModel *)dropMenuModel;
@end

@interface GHDropMenuFilterInputItem : UICollectionViewCell
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <GHDropMenuFilterInputItemDelegate> delegate;

@end
@interface GHDropMenuFilterInputItem()
@property (nonatomic , strong)UITextField *leftTextField;
@property (nonatomic , strong)UITextField *rightTextField;
@property (nonatomic , strong)UIView *line;

@end
@implementation GHDropMenuFilterInputItem
- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.leftTextField.text = dropMenuModel.minPrice;
    self.rightTextField.text = dropMenuModel.maxPrice;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}
- (void)configuration {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.leftTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.rightTextField];
}

- (void)textChange: (NSNotification *)noti {
    
    if (self.leftTextField.text.length) {
        self.dropMenuModel.minPrice = self.leftTextField.text;
    }
    if (self.rightTextField.text.length) {
        self.dropMenuModel.maxPrice = self.rightTextField.text;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuFilterInputItem:dropMenuModel:)]) {
        [self.delegate dropMenuFilterInputItem:self dropMenuModel:self.dropMenuModel];
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupUI {
    [self addSubview:self.leftTextField];
    [self addSubview:self.line];
    [self addSubview:self.rightTextField];

}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = (self.frame.size.width - 2 * 10 - 10) / 2;
    self.leftTextField.frame = CGRectMake(0, 0, width, self.frame.size.height);
    self.line.frame = CGRectMake(width + 10, (self.frame.size.height - 1) * 0.5, 10, 1);
    self.rightTextField.frame = CGRectMake(self.line.frame.origin.x+ self.line.frame.size.width + 10, 0, width, self.frame.size.height);
}
- (UITextField *)rightTextField {
    if (_rightTextField == nil) {
        _rightTextField = [[UITextField alloc]init];
        _rightTextField.layer.cornerRadius = 10;
        _rightTextField.layer.masksToBounds = YES;
        _rightTextField.layer.borderWidth = 0.5;
        _rightTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _rightTextField.textAlignment = NSTextAlignmentCenter;
        _rightTextField.font = [UIFont systemFontOfSize:13];
        _rightTextField.textColor = [UIColor darkGrayColor];
        _rightTextField.placeholder = @"请输入最高价";
        _rightTextField.keyboardType = UIKeyboardTypeNumberPad;
        _rightTextField.tintColor = [UIColor orangeColor];
    }
    return _rightTextField;
}
- (UITextField *)leftTextField {
    if (_leftTextField == nil) {
        _leftTextField = [[UITextField alloc]init];
        _leftTextField.layer.cornerRadius = 10;
        _leftTextField.layer.masksToBounds = YES;
        _leftTextField.layer.borderWidth = 0.5;
        _leftTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _leftTextField.textAlignment = NSTextAlignmentCenter;
        _leftTextField.font = [UIFont systemFontOfSize:13];
        _leftTextField.textColor = [UIColor darkGrayColor];
        _leftTextField.placeholder = @"请输入最低价";
        _leftTextField.keyboardType = UIKeyboardTypeNumberPad;
        _leftTextField.tintColor = [UIColor orangeColor];
    }
    return _leftTextField;
}
- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor darkGrayColor];
        _line.alpha = 0.5;
    }
    return _line;
}
#pragma mark - - - - - - - - GHDropMenuFilterInputItem

@end
#pragma mark - - - - - - - - GHDropMenuFilterItem
@class GHDropMenuFilterItem,GHDropMenuModel;
@protocol GHDropMenuFilterItemDelegate <NSObject>
- (void)dropMenuFilterItem: (GHDropMenuFilterItem *)item dropMenuModel:(GHDropMenuModel *)dropMenuModel;
@end

@interface GHDropMenuFilterItem : UICollectionViewCell
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <GHDropMenuFilterItemDelegate>delegate;
@end
@interface GHDropMenuFilterItem()
@property (nonatomic , strong) UILabel *title;

@end
@implementation GHDropMenuFilterItem
- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.title.text = dropMenuModel.tagName;
    self.title.backgroundColor = dropMenuModel.tagSeleted ? [UIColor orangeColor]:[UIColor whiteColor];
    self.title.textColor = dropMenuModel.tagSeleted ?[UIColor whiteColor]:[UIColor darkGrayColor];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);

}
- (void)setupUI {
    [self addSubview:self.title];

}
- (void)tap:(UITapGestureRecognizer *)gesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuFilterItem:dropMenuModel:)]) {
        [self.delegate dropMenuFilterItem:self dropMenuModel:self.dropMenuModel];
    }
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.userInteractionEnabled = YES;
        _title.text = @"1";
        _title.layer.masksToBounds = YES;
        _title.layer.cornerRadius = 10;
        _title.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _title.layer.borderWidth = 0.5;
        _title.font = [UIFont systemFontOfSize:13];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [_title addGestureRecognizer:tap];
        
    }
    return _title;
}
#pragma mark - - - - - - - - GHDropMenuFilterItem

@end
#pragma mark - - - - GHDropMenuTitle 自定义view

#pragma mark - - - -- - - -- - - -- - - -- - - -- - - -- - - -- - - -- - - - GHDropMenu 筛选菜单开始
/** 按钮类型 */
typedef NS_ENUM (NSUInteger,GHDropMenuButtonType ) {
    /** 确定 */
    GHDropMenuButtonTypeSure = 1,
    /** 重置 */
    GHDropMenuButtonTypeReset,
};

typedef NS_ENUM (NSUInteger,GHDropMenuShowType ) {
    GHDropMenuShowTypeCommon = 1,
    GHDropMenuShowTypeOnlyFilter,
};

@interface GHDropMenu()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,GHDropMenuFilterItemDelegate,GHDropMenuFilterHeaderDelegate,GHDropMenuFilterInputItemDelegate,GHDropMenuFilterSingleInputItemDelegate,GHDropMenuTitleItemDelegate>


/** 顶部菜单 */
@property (nonatomic , strong) UICollectionView *collectionView;
/** 顶部菜单布局 */
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;
/** 弹出菜单 */
@property (nonatomic , strong) UITableView *tableView;
/** 弹出菜单内容数组 */
@property (nonatomic , strong) NSMutableArray *contents;
/** 菜单的高度 */
@property (nonatomic , assign) CGFloat menuHeight;
@property (nonatomic , strong) UIView *topLine;
@property (nonatomic , strong) UIView *bottomLine;
@property (nonatomic , strong) UIView *bottomView;
/** 弹出菜单选中index */
@property (nonatomic , assign) NSInteger currentIndex;
/** 筛选器 */
@property (nonatomic , strong) UICollectionView *filter;
@property (nonatomic , strong) UICollectionViewFlowLayout *filterFlowLayout;
/** 重置 */
@property (nonatomic , strong) UIButton *reset;
/** 确定 */
@property (nonatomic , strong) UIButton *sure;
/** 遮罩 */
@property (nonatomic , strong) UIControl *filterCover;

@property (nonatomic , strong) NSIndexPath *currentIndexPath;

@property (nonatomic , strong) UIControl *titleCover;

@property (nonatomic , strong) DropMenuTitleBlock dropMenuTitleBlock;

@property (nonatomic , strong) DropMenuTagArrayBlock dropMenuTagArrayBlock;

@property (nonatomic , assign) GHDropMenuShowType dropMenuShowType;

@end
@implementation GHDropMenu
#pragma mark - 初始化
+ (instancetype)creatDropFilterMenuWidthConfiguration: (GHDropMenuModel *)configuration
                                dropMenuTagArrayBlock: (DropMenuTagArrayBlock)dropMenuTagArrayBlock {
    GHDropMenu *dropMenu = [[GHDropMenu alloc]initWithFrame:CGRectMake(0,0, kGHScreenWidth, kGHScreenHeight)];
    dropMenu.dropMenuShowType = GHDropMenuShowTypeOnlyFilter;
    dropMenu.titles = configuration.titles.mutableCopy;
    dropMenu.dropMenuTagArrayBlock = dropMenuTagArrayBlock;
    [dropMenu setupFilterUI];
    return dropMenu;

}

#pragma mark - 初始化
+ (instancetype)creatDropMenuWithConfiguration: (GHDropMenuModel *)configuration frame: (CGRect)frame dropMenuTitleBlock: (DropMenuTitleBlock)dropMenuTitleBlock dropMenuTagArrayBlock: (DropMenuTagArrayBlock)dropMenuTagArrayBlock {
    GHDropMenu *dropMenu = [[GHDropMenu alloc]initWithFrame:CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height)];
    dropMenu.configuration = configuration;
    dropMenu.menuHeight = frame.size.height;
    dropMenu.tableY = frame.origin.y + frame.size.height;
    dropMenu.dropMenuTitleBlock = dropMenuTitleBlock;
    dropMenu.dropMenuTagArrayBlock = dropMenuTagArrayBlock;
    dropMenu.dropMenuShowType = GHDropMenuShowTypeCommon;
    [dropMenu setupUI];
    return dropMenu;
}

- (void)setDataSource:(id<GHDropMenuDataSource>)dataSource {
    _dataSource = dataSource;
    if (dataSource == nil) {
        return;
    }
    NSArray *tempArray = nil;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(columnTitlesInMeun:)]) {
        tempArray = [self.dataSource columnTitlesInMeun:self];
    }
    NSMutableArray *titles = [NSMutableArray array];
    for (NSInteger index = 0; index < tempArray.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = [tempArray by_ObjectAtIndex:index];
        dropMenuModel.dropMenuType = GHDropMenuTypeTitle;
        [titles addObject:dropMenuModel];
    }
    self.titles = titles.copy;

    if (self.dataSource && [self.dataSource respondsToSelector:@selector(menu:numberOfColumns:)]) {
        for (NSInteger index = 0; index < titles.count; index++) {
            GHDropMenuModel *dropMenuTitleModel = [titles by_ObjectAtIndex:index];
            NSArray *temp = [self.dataSource menu:self numberOfColumns:index];

            NSMutableArray *dataArray = [NSMutableArray array];
            for (NSInteger j = 0; j < temp.count; j++) {
                GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
                dropMenuModel.title = [temp by_ObjectAtIndex:j];
                [dataArray addObject: dropMenuModel];
            }
            dropMenuTitleModel.dataArray = dataArray;
        }

    }
    [self.collectionView reloadData];
}
- (void)setTitles:(NSArray *)titles {
    _titles = titles.copy;
    [self.collectionView reloadData];

}
- (void)setTableY:(CGFloat)tableY {
    _tableY = tableY;
    self.tableView.y = tableY;
    self.titleCover.y = self.tableView.y;
}
- (void)setOptionNormalColor:(UIColor *)optionNormalColor {
    _optionNormalColor = optionNormalColor;
    for (GHDropMenuModel *dropMenuTitleModel in self.titles) {
        for (GHDropMenuModel *dropMenuOptionModel  in dropMenuTitleModel.dataArray) {
            dropMenuOptionModel.optionNormalColor = optionNormalColor;
        }
    }
    [self.tableView reloadData];
}
- (void)setOptionSeletedColor:(UIColor *)optionSeletedColor {
    _optionSeletedColor = optionSeletedColor;
    for (GHDropMenuModel *dropMenuTitleModel in self.titles) {
        for (GHDropMenuModel *dropMenuOptionModel  in dropMenuTitleModel.dataArray) {
            dropMenuOptionModel.optionSeletedColor = optionSeletedColor;
        }
    }
    [self.tableView reloadData];
}
- (void)setOptionFont:(UIFont *)optionFont {
    _optionFont = optionFont;
    for (GHDropMenuModel *dropMenuTitleModel in self.titles) {
        for (GHDropMenuModel *dropMenuOptionModel  in dropMenuTitleModel.dataArray) {
            dropMenuOptionModel.optionFont = optionFont;
        }
    }
    [self.tableView reloadData];
}
- (void)setTitleNormalImageName:(NSString *)titleNormalImageName {
    _titleNormalImageName = titleNormalImageName;
    for (GHDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleNormalImageName = titleNormalImageName;
    }
    [self.collectionView reloadData];
}
- (void)setTitleSeletedImageName:(NSString *)titleSeletedImageName {
    _titleSeletedImageName = titleSeletedImageName;
    for (GHDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleSeletedImageName = titleSeletedImageName;
    }
    [self.collectionView reloadData];
}
- (void)setTitleSeletedColor:(UIColor *)titleSeletedColor {
    _titleSeletedColor = titleSeletedColor;
    for (GHDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleSeletedColor = titleSeletedColor;
    }
    [self.collectionView reloadData];
}
- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    for (GHDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleNormalColor = titleNormalColor;
    }
    [self.collectionView reloadData];
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    for (GHDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleFont = titleFont;
    }
    [self.collectionView reloadData];
}
- (void)setTitleViewBackGroundColor:(UIColor *)titleViewBackGroundColor {
    for (GHDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleViewBackGroundColor = titleViewBackGroundColor;
    }
    [self.collectionView reloadData];
}

- (void)setConfiguration:(GHDropMenuModel *)configuration {
    _configuration = configuration;
    self.titles = configuration.titles.copy;
    for (GHDropMenuModel *dropMenuTitleModel in self.titles) {
        for (GHDropMenuModel *dropMenuCellModel in dropMenuTitleModel.dataArray) {
            NSLog(@"titleSeleted%d",dropMenuCellModel.cellSeleted);
        }
    }
    [self.collectionView reloadData];
    self.currentIndex = 0;
//    [self resetMenuStatus];
}
- (instancetype)new {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"请使用方法 creatDropMenuWithConfiguration: or creatDropFilterMenuWidthConfiguration: 代替初始化" userInfo:nil];
}
- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"请使用方法 creatDropMenuWithConfiguration: or creatDropFilterMenuWidthConfiguration: 代替初始化" userInfo:nil];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self defaultConfiguration];
    }
    return self;
}
- (void)defaultConfiguration {
    self.menuHeight = 44;
    self.currentIndex = 0;
}

#pragma mark - 消失
- (void)dismiss {
    
    GHDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex:self.currentIndex];
    self.filterCover.backgroundColor = [UIColor clearColor];
    self.titleCover.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:self.durationTime animations:^{
        if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeTitle /** 普通菜单 */) {
            self.tableView.frame = CGRectMake(0, self.tableY , self.frame.size.width, 0);
            self.titleCover.frame = CGRectMake(0, self.tableY, kGHScreenWidth, 0);
        } else if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeFilter /** 筛选菜单 */) {
            self.filterCover.frame = CGRectMake(kGHScreenWidth, 0, kGHScreenWidth, kGHScreenHeight);
        }
      
    } completion:^(BOOL finished) {
        if (self.dropMenuShowType == GHDropMenuShowTypeOnlyFilter) {
            [self.layer setOpacity:0.0];
        }
        [self.tableView reloadData];
    }];
    
}
#pragma mark - 弹出
- (void)show {
    [self.tableView reloadData];
    [self.filter reloadData];
    if (self.dropMenuShowType == GHDropMenuShowTypeOnlyFilter) {
        [self.layer setOpacity:1];
    }
    GHDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex:self.currentIndex];
    if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeFilter /** 筛选菜单 */) {
        self.titleCover.backgroundColor = [UIColor clearColor];
    }
    [UIView animateWithDuration:self.durationTime animations:^{
        if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeTitle /** 普通菜单 */) {
            self.tableView.frame = CGRectMake(0, self.tableY, self.frame.size.width, dropMenuTitleModel.dataArray.count * 44);
            self.titleCover.frame = CGRectMake(0, self.tableY, kGHScreenWidth, kGHScreenHeight - self.menuHeight - kGHSafeAreaTopHeight);
        } else if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeFilter /** 筛选菜单 */) {
            self.tableView.frame = CGRectMake(0, self.tableY, self.frame.size.width, 0);
            self.titleCover.frame = CGRectMake(0, self.tableY, self.frame.size.width, 0);
            self.filterCover.frame = CGRectMake(0, 0, kGHScreenWidth, kGHScreenHeight);
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeFilter /** 筛选菜单 */) {
                self.filterCover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];

            } else if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeTitle) {
                self.titleCover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
            }
        } completion:^(BOOL finished) {
        }];
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, kGHScreenWidth, self.menuHeight);
    self.topLine.frame = CGRectMake(0, 0, kGHScreenWidth, 1);
    self.bottomLine.frame = CGRectMake(0, self.menuHeight - 1, kGHScreenWidth, 1);
    self.tableView.frame = CGRectMake(0, self.tableY, self.frame.size.width, 0);
}
#pragma mark - 创建UI 添加控件
- (void)setupUI {

    [self addSubview:self.collectionView];
    [kKeyWindow addSubview:self.filterCover];
    [kKeyWindow addSubview:self.titleCover];
    [self.filterCover addSubview:self.filter];
    [self.filterCover addSubview:self.bottomView];
    [self.filterCover addSubview:self.sure];
    [self.filterCover addSubview:self.reset];
    [self.collectionView addSubview:self.bottomLine];
    [kKeyWindow addSubview:self.tableView];
}

- (void)setupFilterUI {
    [kKeyWindow addSubview:self];
    [self addSubview:self.filterCover];
    [self.filterCover addSubview:self.filter];
    [self.filterCover addSubview:self.bottomView];
    [self.filterCover addSubview:self.sure];
    [self.filterCover addSubview:self.reset];
}
/** 重置menu 状态 */
- (void)resetMenuStatus {
    for (GHDropMenuModel *dropMenuModel in self.titles) {
        dropMenuModel.titleSeleted = NO;
    }
    [self.filter reloadData];
    [self.collectionView reloadData];
    [self dismiss];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self resetMenuStatus];
}
- (void)dropMenuFilterSingleInputItem:(GHDropMenuFilterSingleInputItem *)item dropMenuModel:(GHDropMenuModel *)dropMenuModel {
    GHDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex: self.currentIndex];
    GHDropMenuModel *dropMenuSectionModel = [dropMenuTitleModel.sections by_ObjectAtIndex: dropMenuModel.indexPath.section];
    GHDropMenuModel *dropMenuTagModel = [dropMenuSectionModel.dataArray by_ObjectAtIndex:dropMenuModel.indexPath.row];
    dropMenuTagModel.singleInput = dropMenuModel.singleInput;
}
- (void)dropMenuFilterInputItem:(GHDropMenuFilterInputItem *)item dropMenuModel:(GHDropMenuModel *)dropMenuModel {
    
    GHDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex: self.currentIndex];
    GHDropMenuModel *dropMenuSectionModel = [dropMenuTitleModel.sections by_ObjectAtIndex: dropMenuModel.indexPath.section];
    GHDropMenuModel *dropMenuTagModel = [dropMenuSectionModel.dataArray by_ObjectAtIndex:dropMenuModel.indexPath.row];
    dropMenuTagModel.minPrice = dropMenuModel.minPrice;
    dropMenuTagModel.maxPrice = dropMenuModel.maxPrice;
}
- (void)dropMenuFilterHeader:(GHDropMenuFilterHeader *)header dropMenuModel:(GHDropMenuModel *)dropMenuModel {
    dropMenuModel.sectionSeleted = !dropMenuModel.sectionSeleted;
    [self.filter reloadData];
}
#pragma mark - tag标签点击方法
- (void)dropMenuFilterItem: (GHDropMenuFilterItem *)item dropMenuModel:(GHDropMenuModel *)dropMenuModel {
    GHDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex: self.currentIndex];
    GHDropMenuModel *dropMenuSectionModel = [dropMenuTitleModel.sections by_ObjectAtIndex: dropMenuModel.indexPath.section];
    /** 处理多选 单选*/
    [self actionMultipleWithDropMenuModel:dropMenuModel dropMenuSectionModel:dropMenuSectionModel];
    /** 处理sectionDetails */
    [self actionSectionHeaderDetailsWithDropMenuModel:dropMenuModel dropMenuSectionModel:dropMenuSectionModel];
    [self.filter reloadData];
}
#pragma mark - 处理sectionHeaderDetails
- (void)actionSectionHeaderDetailsWithDropMenuModel: (GHDropMenuModel *)dropMenuModel dropMenuSectionModel: (GHDropMenuModel *)dropMenuSectionModel {
    
    NSMutableString *details = [NSMutableString string];
    for (GHDropMenuModel *dropMenuTagModel in dropMenuSectionModel.dataArray) {
        if (dropMenuTagModel.tagSeleted) {
            [details appendFormat:@"%@,", dropMenuTagModel.tagName];
        }
    }
    if (details.length) {
        [details deleteCharactersInRange:NSMakeRange(details.length - 1, 1)];
    }
    dropMenuSectionModel.sectionHeaderDetails = details;
}
#pragma mark - 处理单选 多选
- (void)actionMultipleWithDropMenuModel: (GHDropMenuModel *)dropMenuModel dropMenuSectionModel: (GHDropMenuModel *)dropMenuSectionModel {
    
    /** 处理单选 */
    NSString *currentSeletedStr = [NSString string];
    if (dropMenuSectionModel.isMultiple) {
        
    } else {
        for (GHDropMenuModel *dropMenuTagModel in dropMenuSectionModel.dataArray) {
            if (dropMenuTagModel.tagSeleted) {
                currentSeletedStr = dropMenuTagModel.tagName;
            }
            dropMenuTagModel.tagSeleted = NO;
        }
    }
    
    if (self.currentIndexPath != dropMenuModel.indexPath /** 不是第一次选中 */) {
        if ([currentSeletedStr isEqualToString:dropMenuModel.tagName]) {
            dropMenuModel.tagSeleted = NO;
        } else {
            dropMenuModel.tagSeleted = !dropMenuModel.tagSeleted ;
        }
        self.currentIndexPath = dropMenuModel.indexPath;
    } else {
        if ([currentSeletedStr isEqualToString:dropMenuModel.tagName]) {
            if (dropMenuSectionModel.isMultiple) {
                dropMenuModel.tagSeleted = YES;
            } else {
                dropMenuModel.tagSeleted = NO;
            }
        } else {
            dropMenuModel.tagSeleted = !dropMenuModel.tagSeleted ;
        }
        self.currentIndexPath = nil;
    }
    
}
#pragma mark - 点击顶部titleView 代理回调
- (void)dropMenuTitleItem: (GHDropMenuTitleItem *)item
            dropMenuModel: (GHDropMenuModel *)dropMenuModel {
    dropMenuModel.titleSeleted = !dropMenuModel.titleSeleted;
    self.currentIndex = dropMenuModel.indexPath.row;
    if (dropMenuModel.titleSeleted) {
        /** 取出数组 展示*/
        self.contents = dropMenuModel.dataArray.copy;
        for (GHDropMenuModel *model in self.titles) {
            if (model.identifier != dropMenuModel.identifier) {
                model.titleSeleted = NO;
            }
        }
        [self show];
    } else {
        [self dismiss];
    }
    [self.collectionView reloadData];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *seletedIndexPath = nil;
    for (GHDropMenuModel *dropMenuModel in self.titles) {
        if (dropMenuModel.titleSeleted) {
            seletedIndexPath = dropMenuModel.indexPath;
        }
    }
    GHDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex: seletedIndexPath.row];

    GHDropMenuModel *dropMenuModel = [dropMenuTitleModel.dataArray by_ObjectAtIndex: indexPath.row];
    dropMenuModel.indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:dropMenuTitleModel.indexPath.row];

    GHDropMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHDropMenuCellID"];
    cell.dropMenuModel = dropMenuModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    GHDropMenuModel *dropMenuModel = [self.titles by_ObjectAtIndex: self.currentIndex];
    for (GHDropMenuModel *dropMenuContentModel in dropMenuModel.dataArray) {
        dropMenuContentModel.cellSeleted = NO;
    }
    GHDropMenuModel *contentModel = [dropMenuModel.dataArray by_ObjectAtIndex:indexPath.row];
    if (self.configuration.recordSeleted) {
        dropMenuModel.title = contentModel.title;
    }
    
    contentModel.cellSeleted = !contentModel.cellSeleted;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenu:dropMenuTitleModel:)]) {
        [self.delegate dropMenu:self dropMenuTitleModel:contentModel];
    }
    
    if (self.dropMenuTitleBlock) {
        self.dropMenuTitleBlock(contentModel);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenu:dropMenuModel:)]) {
        [self.delegate dropMenu:self dropMenuModel:self.configuration];
    }

    [self resetMenuStatus];
}
#pragma mark - collectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section  {
    if (self.filter == collectionView) {
        return CGSizeMake(kGHScreenWidth * 0.8, 10);
    } else {
        return CGSizeZero;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (self.filter == collectionView) {
        return CGSizeMake(kGHScreenWidth * 0.8, 44);
    } else {
        return CGSizeZero;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    GHDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex:self.currentIndex];
    GHDropMenuModel *dropMenuSectionModel = [dropMenuTitleModel.sections by_ObjectAtIndex:indexPath.section];
    dropMenuSectionModel.indexPath = indexPath;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && self.filter == collectionView) {
        GHDropMenuFilterHeader *header  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GHDropMenuFilterHeaderID" forIndexPath:indexPath];
        header.dropMenuModel = dropMenuSectionModel;
        header.delegate = self;
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter] && self.filter == collectionView) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewID" forIndexPath:indexPath];
    } else {
        return [UICollectionReusableView new];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.collectionView) {
        return CGSizeMake(kGHScreenWidth /self.titles.count, self.menuHeight - 0.01f);
    } else if (collectionView == self.filter) {
        GHDropMenuModel *dropMenuModel = [self.titles by_ObjectAtIndex: self.currentIndex];
        GHDropMenuModel *dropMenuSectionModel = dropMenuModel.sections[indexPath.section];
        if (dropMenuSectionModel.filterCellType == GHDropMenuFilterCellTypeTag) {
            return CGSizeMake((kGHScreenWidth * 0.9 - 4 * 10) / 3.01f, 30.01f);
        } else if (dropMenuSectionModel.filterCellType == GHDropMenuFilterCellTypeInput ||
                   dropMenuSectionModel.filterCellType == GHDropMenuFilterCellTypeSingleInput) {
            return CGSizeMake(kGHScreenWidth * 0.9 - 2 * 10,30.01f);
        } else {
            return CGSizeZero;
        }
    } else {
        return CGSizeZero;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    GHDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex: self.currentIndex];
    if (self.filter == collectionView) {
        return dropMenuTitleModel.sections.count;
    } else if (collectionView == self.collectionView){
        return 1;
    } else {
        return 0;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (self.collectionView == collectionView) {
        return self.titles.count;
    } else if (self.filter == collectionView) {
        GHDropMenuModel *dropMenuModel = [self.titles by_ObjectAtIndex: self.currentIndex];
        GHDropMenuModel *dropMenuSectionModel = [dropMenuModel.sections by_ObjectAtIndex: section];
        if (dropMenuSectionModel.filterCellType == GHDropMenuFilterCellTypeTag) {
            return dropMenuSectionModel.sectionSeleted ? dropMenuSectionModel.dataArray.count:dropMenuSectionModel.dataArray.count > 3 ? 3:dropMenuSectionModel.dataArray.count;
        } else if (dropMenuSectionModel.filterCellType == GHDropMenuFilterCellTypeInput ||
                   dropMenuSectionModel.filterCellType == GHDropMenuFilterCellTypeSingleInput) {
            return 1;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}
#pragma mark - - - 返回collectionView item
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (collectionView == self.collectionView) {
        GHDropMenuModel *dropMenuModel = [self.titles by_ObjectAtIndex: indexPath.row];
        dropMenuModel.indexPath = indexPath;
        GHDropMenuTitleItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHDropMenuTitleItemID" forIndexPath:indexPath];
        cell.dropMenuModel = dropMenuModel;
        cell.delegate = self;
        return cell;
    } else if (collectionView == self.filter) {
        NSString *identifier = [NSString stringWithFormat:@"GHDropMenuFilterItemID%ld%ld",(long)indexPath.section,(long)indexPath.row];
        [self.filter registerClass:[GHDropMenuFilterItem class] forCellWithReuseIdentifier:identifier];

        GHDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex: self.currentIndex];
        GHDropMenuModel *dropMenuSectionModel = [dropMenuTitleModel.sections by_ObjectAtIndex: indexPath.section];
      
        GHDropMenuModel *dropMenuTagModel = [dropMenuSectionModel.dataArray by_ObjectAtIndex: indexPath.row];
        dropMenuTagModel.indexPath = indexPath;
        
        if (dropMenuSectionModel.filterCellType == GHDropMenuFilterCellTypeTag) {
            GHDropMenuFilterItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            cell.dropMenuModel = dropMenuTagModel;
            cell.delegate = self;
            return cell;
        } else if (dropMenuSectionModel.filterCellType == GHDropMenuFilterCellTypeInput) {
            GHDropMenuFilterInputItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHDropMenuFilterInputItemID" forIndexPath:indexPath];
            cell.dropMenuModel = dropMenuTagModel;
            cell.delegate = self;
            return cell;
        } else if (dropMenuSectionModel.filterCellType == GHDropMenuFilterCellTypeSingleInput) {
            GHDropMenuFilterSingleInputItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHDropMenuFilterSingleInputItemID" forIndexPath:indexPath];
            cell.dropMenuModel = dropMenuTagModel;
            cell.delegate = self;
            return cell;
        } else  {
            return [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
        }
    } else {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    }
}

- (void)tap: (UITapGestureRecognizer *)gesture {
    [self resetMenuStatus];
}
- (void)clickButton: (UIButton *)button {
    GHDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex:self.currentIndex];

    if (button.tag == GHDropMenuButtonTypeSure) {
        [self resetMenuStatus];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (GHDropMenuModel *dropMenuSectionModel in dropMenuTitleModel.sections) {
            for (GHDropMenuModel *dropMenuTagModel in dropMenuSectionModel.dataArray) {
                if (dropMenuTagModel.tagSeleted) {
                    [dataArray addObject:dropMenuTagModel];
                }
                if (dropMenuSectionModel.filterCellType == GHDropMenuFilterCellTypeInput ||
                    dropMenuSectionModel.filterCellType == GHDropMenuFilterCellTypeSingleInput) {
                    [dataArray addObject:dropMenuTagModel];
                }
            }
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenu:tagArray:)]) {
            [self.delegate dropMenu:self tagArray:dataArray.copy];
        }
        if (self.dropMenuTagArrayBlock) {
            self.dropMenuTagArrayBlock(dataArray.copy);
        }
    } else if (button.tag == GHDropMenuButtonTypeReset){
        for (GHDropMenuModel *dropMenuSectionModel in dropMenuTitleModel.sections) {
            dropMenuSectionModel.sectionHeaderDetails = @"";
            for (GHDropMenuModel *dropMenuTagModel in dropMenuSectionModel.dataArray) {
                dropMenuTagModel.tagSeleted = NO;
                dropMenuTagModel.minPrice = @"";
                dropMenuTagModel.maxPrice = @"";
            }
        }
        [self.filter reloadData];
    }
}
- (void)clickControl {
    
    [self resetMenuStatus];
}
#pragma mark - 懒加载
- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.frame = CGRectMake(self.filter.frame.origin.x, self.filter.frame.size.height + self.filter.frame.origin.y + kFilterButtonHeight,self.filter.frame.size.width , kGHSafeAreaBottomHeight);
    }
    return _bottomView;
}
- (UIControl *)titleCover {
    if (_titleCover == nil) {
        _titleCover = [[UIControl alloc]init];
        _titleCover.frame = CGRectMake(0, self.frame.size.height + kGHSafeAreaTopHeight, kGHScreenWidth, 0);
        [_titleCover addTarget:self action:@selector(clickControl) forControlEvents:UIControlEventTouchUpInside];
        _titleCover.backgroundColor = [UIColor clearColor];
    }
    return _titleCover;
}
- (UIControl *)filterCover {
    if (_filterCover == nil) {
        _filterCover = [[UIControl alloc]init];
        _filterCover.frame = CGRectMake(kGHScreenWidth, 0, kGHScreenWidth, kGHScreenHeight);
        [_filterCover addTarget:self action:@selector(clickControl) forControlEvents:UIControlEventTouchUpInside];
        _filterCover.backgroundColor = [UIColor clearColor];
    }
    return _filterCover;
}
- (UIButton *)reset {
    if (_reset == nil) {
        _reset = [[UIButton alloc]init];
        _reset.frame = CGRectMake(self.filter.frame.origin.x, self.filter.frame.size.height, self.filter.frame.size.width * 0.5, kFilterButtonHeight);
        _reset.backgroundColor = [UIColor whiteColor];
        [_reset setTitle:@"重置" forState:UIControlStateNormal];
        [_reset setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_reset addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _reset.tag = GHDropMenuButtonTypeReset;
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor lightGrayColor];
        line.alpha = .1;
        line.frame = CGRectMake(0, 0, _reset.frame.size.width, 1);
        [_reset addSubview:line];
    }
    return _reset;
}
- (UIButton *)sure {
    if (_sure == nil) {
        _sure = [[UIButton alloc]init];
        _sure.frame = CGRectMake(kGHScreenWidth - self.filter.frame.size.width * 0.5, self.filter.frame.size.height, self.filter.frame.size.width * 0.5, kFilterButtonHeight);
        _sure.backgroundColor = [UIColor orangeColor];
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.tag = GHDropMenuButtonTypeSure;
        [_sure addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _sure;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.tableY, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[GHDropMenuCell class] forCellReuseIdentifier:@"GHDropMenuCellID"];
    }
    return _tableView;
}
- (UICollectionViewFlowLayout *)filterFlowLayout {
    if (_filterFlowLayout == nil) {
        _filterFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        _filterFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _filterFlowLayout.minimumLineSpacing = 10.01f;
        _filterFlowLayout.minimumInteritemSpacing = 10.01f;
    }
    return _filterFlowLayout;
}
- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0.01f;
        _flowLayout.minimumInteritemSpacing = 0.01f;
    }
    return _flowLayout;
}
- (UICollectionView *)filter {
    if (_filter == nil) {
        _filter = [[UICollectionView alloc]initWithFrame:CGRectMake(kGHScreenWidth * 0.1, 0, kGHScreenWidth * 0.9, kGHScreenHeight - kFilterButtonHeight - kGHSafeAreaBottomHeight) collectionViewLayout:self.filterFlowLayout];
        _filter.delegate = self;
        _filter.dataSource = self;
        _filter.layer.shadowColor = [UIColor redColor].CGColor;
        _filter.layer.shadowOffset = CGSizeMake(1000, 10);
        _filter.layer.shadowOpacity = 0.8;
        _filter.contentInset = UIEdgeInsetsMake(20, 10, 0, 10);
        _filter.backgroundColor = [UIColor whiteColor];
        [_filter registerClass:[GHDropMenuFilterItem class] forCellWithReuseIdentifier:@"GHDropMenuFilterItemID"];
        [_filter registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        [_filter registerClass:[GHDropMenuFilterHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GHDropMenuFilterHeaderID"];
        [_filter registerClass:[GHDropMenuFilterInputItem class] forCellWithReuseIdentifier:@"GHDropMenuFilterInputItemID"];
        [_filter registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewID"];
        [_filter registerClass:[GHDropMenuFilterSingleInputItem class] forCellWithReuseIdentifier:@"GHDropMenuFilterSingleInputItemID"];

    }
    return _filter;
}
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(kGHScreenWidth, 0, kGHScreenWidth, self.menuHeight) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.borderColor = [UIColor clearColor].CGColor;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        [_collectionView registerClass:[GHDropMenuTitleItem class] forCellWithReuseIdentifier:@"GHDropMenuTitleItemID"];

    }
    return _collectionView;
}
- (NSMutableArray *)contents {
    if (_contents == nil) {
        _contents = [NSMutableArray array];
    }
    return _contents;
}

- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor darkGrayColor];
        _bottomLine.alpha = .1;
    }
    return _bottomLine;
}
- (UIView *)topLine {
    if (_topLine == nil) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = [UIColor darkGrayColor];
        _topLine.alpha = .1;
    }
    return _topLine;
}

- (void)dealloc {
    NSLog(@"释放了");
}
@end
