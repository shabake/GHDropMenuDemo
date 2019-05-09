![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
![](https://img.shields.io/appveyor/ci/gruntjs/grunt.svg)
![](https://img.shields.io/vscode-marketplace/d/repo.svg)
![](https://img.shields.io/cocoapods/l/packageName.svg)

# GHDropMenu Simple use, no intrusion, no pollution to the original project

`Filter menu` `Jingdong screening menu` `MeiTuan screening menu` `E-commerce general screening menu`

[Chinese](https://github.com/shabake/GHDropMenuDemo) | English
---

![Untitled.gif](https://upload-images.jianshu.io/upload_images/1419035-55dd0f6eafb19fd7.gif?imageMogr2/auto-orient/strip)

---

#### 使用方法:

![12.png](https://upload-images.jianshu.io/upload_images/1419035-46b3260c4c3c49a4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### Implement data source method:
![2.png](https://upload-images.jianshu.io/upload_images/1419035-8bef7e6a81c99d5c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
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

![3.png](https://upload-images.jianshu.io/upload_images/1419035-4725c4ae4bbea0f8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* Need to construct json data


* When you need to return to the previous page, you need to call the method of closing the menu.
![4.png](https://upload-images.jianshu.io/upload_images/1419035-178dc3d875136ed4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### Nest
- [ ] Optimize your code and improve your documentation
- [ ] Add a similar multi-level menu selection for boss



### If you have any questions during use, please harass me. If you are helpful, please help me with a little help. The younger is grateful:blush:

### Email `45329453@qq.com `

[Pay attention to my blog, nothing to write small things](https://www.jianshu.com/u/884a67907187)

---
