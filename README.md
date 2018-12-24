![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
# GHDropMenuDemo
**自由定制电商筛选菜单**

**超级简单好用的电商筛选菜单** 


###2018.12.25更新

* dropMenu的title自适应宽度
* 增加适量注释,模型封装
* 外部模型控制内部用户点击筛选是否记录
* 适配x,xs,xr,xsmax
* 去掉刚开始创建的动画

--
![image.png](https://upload-images.jianshu.io/upload_images/1419035-0ca99960ec7aa25e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/240)

![Untitled.gif](https://upload-images.jianshu.io/upload_images/1419035-5392ec271c8ed736.gif?imageMogr2/auto-orient/strip)
* **自定义筛选标题,自定义筛选内容,自定义筛选标签,自定义筛选头部内容**
* **数组越界处理**
* **价格输入筛选**
* **实现tag标签,单选,多选,取消选中效果**
* **保留上次选中选项**
* **动画展开,移除**
* **可以重新传入模型,重新刷新数据源**
* **选中内容通过代理的方式回调**
* **对原有项目无污染,直接拖进项目即可使用**<br/>


###使用方法
* 导入
```
#import "GHDropMenu.h"
```

```
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
    
```

* 需要构造json数据
```
详见demo
```

###在使用中如有任何问题欢迎骚扰我,如果对你有帮助请点帮我一个✨,小弟感激不尽

###联系我
**邮箱:45329453@qq.com**

###博客
**简书:https://www.jianshu.com/u/884a67907187**

---
 <br />一个爱研究的程序员

