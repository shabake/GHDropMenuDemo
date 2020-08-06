![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/appveyor/ci/gruntjs/grunt.svg)
![](https://img.shields.io/vscode-marketplace/d/repo.svg)
![](https://img.shields.io/cocoapods/l/packageName.svg)

# GHDropMenu 简单使用 无入侵 对原项目无污染

想要[Flutter版筛选菜单](https://github.com/shabake/GHDropMenuDemo_flutter)点击这里

`筛选菜单` `京东筛选菜单` `美团筛选菜单` `电商通用筛选菜单`

中文文档 | [English](https://github.com/shabake/GHDropMenuDemo/blob/master/README-English.md)

---

![Untitled.gif](https://upload-images.jianshu.io/upload_images/1419035-55dd0f6eafb19fd7.gif?imageMogr2/auto-orient/strip)

---

#### 使用方法:

![12.png](https://upload-images.jianshu.io/upload_images/1419035-46b3260c4c3c49a4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 实现数据源方法:

![2.png](https://upload-images.jianshu.io/upload_images/1419035-8bef7e6a81c99d5c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--- 
### 2019.1.6 更新

```diff
+ 增加价格输入判断逻辑
	* 小数点最多输入两位
	* 第一位不能输入小数点
	* 增加校验方法,当最小价格大于最大价格弹窗提示并且清空用户输入
	

```
### 2018.12.30更新

```diff
+ 增加吸附效果的筛选菜单
+ 分别可选tableView悬浮菜单和collectionView悬浮菜单
+ 增加单独侧滑菜单筛选
+ 适配x,xs,xr,xsmax
+ 去掉刚开始创建的动画
+ 自定义筛选标题,自定义筛选内容,自定义筛选标签,自定义筛选头部内容
+ 数组越界处理
+ 价格输入筛选
+ 实现tag标签,单选,多选,取消选中效果
+ 保留上次选中选项
+ 动画展开,移除
+ 可以重新传入模型,重新刷新数据源
+ 选中内容通过代理的方式回调
+ 对原有项目无污染,直接拖进项目即可使用
+ dropMenu的title自适应宽度

- 去掉titleView初始化动画

```


### 使用方法
* `GHDropMenu`文件夹 拖入项目中
* 导入 `GHDropMenu.h`

![3.png](https://upload-images.jianshu.io/upload_images/1419035-4725c4ae4bbea0f8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


* 需要构造`json`数据


* 当需要返回上级页面的时候需要调用关闭菜单的方法

![4.png](https://upload-images.jianshu.io/upload_images/1419035-178dc3d875136ed4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 接下来要做的
- [ ] 优化代码,完善文档
- [ ] 增加类似`boss`直聘多级菜单选择



### 在使用中如有任何问题欢迎骚扰我,如果对你有帮助请点帮我一个✨,小弟感激不尽:blush:

### 邮箱 `45329453@qq.com `

[关注我的博客 没事写点小东西](https://www.jianshu.com/u/884a67907187)

---
