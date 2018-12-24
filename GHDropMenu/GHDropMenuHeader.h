//
//  GHDropMenuHeader.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/15.
//  Copyright © 2018年 GHome. All rights reserved.
//

#ifndef GHDropMenuHeader_h
#define GHDropMenuHeader_h

// ScreenWidth & kScreenHeight
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define iPhoneXRAndXSMAX (kScreenWidth == 414.f && kScreenHeight == 896.f ? YES : NO)
// iPhoneX
#define iPhoneXAndXS (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
#define kSafeAreaBottomHeight ((iPhoneXAndXS || iPhoneXRAndXSMAX) ?34 : 0)
// StatusbarH + NavigationH
#define kSafeAreaTopHeight ((iPhoneXAndXS || iPhoneXRAndXSMAX) ? 88.f : 64.f)
// StatusBarHeight
#define kStatusBarHeight (iPhoneX ? 44.f : 20.f)
// NavigationBarHeigth
#define kNavBarHeight 44.f
// TabBarHeight
#define kTabBarHeight  (iPhoneX ? (49.f+34.f) : 49.f)

// KeyWindow
#define kKeyWindow [UIApplication sharedApplication].keyWindow

// Rete
#define kScreenWidthRete   kScreenWidth / 375.0 //比率
#define kScreenHeightRete  kScreenWidth / 667.0 //比率
// AutoSize
#define kAutoWithSize(r) r*kScreenWidth / 375.0
#define kFont(size) kAutoWithSize(size)

#define kAutoHeightSize(r) r*kScreenHeight / 667.0

#define kFilterButtonHeight 44
#define kFilterButtonWidth 44

#endif /* GHDropMenuHeader_h */
