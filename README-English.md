![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/appveyor/ci/gruntjs/grunt.svg)
![](https://img.shields.io/vscode-marketplace/d/repo.svg)
![](https://img.shields.io/cocoapods/l/packageName.svg)

# GHDropMenu Simple use, no intrusion, no pollution to the original project

`Filter menu` `Jingdong screening menu` `MeiTuan screening menu` `E-commerce general screening menu`

中文文档 | English

---

![Untitled.gif](https://upload-images.jianshu.io/upload_images/1419035-55dd0f6eafb19fd7.gif?imageMogr2/auto-orient/strip)

---

#### 使用方法:

```Objective-C
GHDropMenu *dropMenu = [GHDropMenu creatDropMenuWithConfiguration:nil frame:CGRectMake(0, kGHSafeAreaTopHeight,kGHScreenWidth, 44) dropMenuTitleBlock:^(GHDropMenuModel * _Nonnull dropMenuModel) {
        weakSelf.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",dropMenuModel.title];
    } dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {
        [weakSelf getStrWith:tagArray];
    }];
    dropMenu.durationTime = 0.5;
    dropMenu.delegate = self;
    dropMenu.dataSource = self;
    [self.view addSubview:dropMenu];
```
#### Implement data source method:
```Objective-C
// Returns the number of filter menu titles
- (NSArray *)columnTitlesInMeun:(GHDropMenu *)menu {
}

// Returns options for each column of the filter menu
- (NSArray *)menu:(GHDropMenu *)menu numberOfColumns:(NSInteger)columns {
}
```
--- 
### 2019.1.6 Update

```diff
+ Increase price input judgment logic
	* Enter two digits at the decimal point
	* The first digit cannot be entered in the decimal point
	* Increase the check method when the minimum price is greater than the maximum price pop-up prompt and clear user input
	


```
### 2018.12.30 Update

```diff
+ Filter menu to increase adsorption
+ Optional tableView floating menu and collectionView floating menu respectively
+ Add separate skid menu filter
+ fit x, xs, xr, xsmax
+ Remove the animation you just created
+ Custom filter headers, custom filter content, custom filter tags, custom filter header content
+ array out of bounds processing
+ Price input screening
+ Implement tag tag, single-select, multi-select, uncheck effect
+ Keep last selected option
+ Animation expand, remove
+ can re-incoming the model and refreshing the data source
+ Select the content to call back through the proxy
+ No pollution to the original project, you can use it directly into the project.
+ dropMenu's title adaptive width

- Remove the titleView initialization animation

```


### Instructions
* GHDropMenufolder Dragged into the project
* 导入 `GHDropMenu.h `

```Objective-C
    /** Configuring the filter menu model */
    GHDropMenuModel *configuration = [[GHDropMenuModel alloc]init];
    /** Configure Filter Menu to record user selection Default NO */
    configuration.recordSeleted = NO;
    /** Set the data source*/
    configuration.titles = [configuration creaDropMenuData];
    
    /** Create dropMenu configuration model &&frame */
    GHDropMenu *dropMenu = [[GHDropMenu alloc]creatDropMenuWithConfiguration:configuration frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    dropMenu.delegate = self;
    
    [self.view addSubview:dropMenu];
    
```

* Need to construct json data
```
See demo
```

* When you need to return to the previous page, you need to call the method of closing the menu.
```
- (vold)closeMenu;
```


### Nest
- [ ] Optimize your code and improve your documentation
- [ ] Add a similar multi-level menu selection for boss



### If you have any questions during use, please harass me. If you are helpful, please help me with a little help. The younger is grateful:blush:

### Email `45329453@qq.com `

[Pay attention to my blog, nothing to write small things](https://www.jianshu.com/u/884a67907187)

---
