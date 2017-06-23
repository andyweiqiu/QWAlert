//
//  QWAlertConst.h
//  QWAlert
//
//  Created by QW on 2017/6/20.
//  Copyright © 2017年 邱威. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//覆盖层背景颜色
#define QWAlertCoverBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.48]

#define QWAlertColor(r, g, b) [UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:1.]

#define bottomButtonTag  1000

// 标题文本颜色
#define QWAlertHeaderTextColor QWAlertColor(244, 177, 177)

// 底部按钮背景颜色
#define QWAlertBottomButtonBackgroundColor QWAlertColor(30, 45, 83)

// 分割线颜色
#define QWAlertLineColor QWAlertColor(200, 201, 201)

// 标题文本字体大小
#define QWAlertHeaderLabelFont [UIFont systemFontOfSize:22.]

// 内容文本字体大小
#define QWAlertLabelFont [UIFont systemFontOfSize:16.]

// 底部按钮字体大小
#define QWAlertBottomButtonLabelFont [UIFont systemFontOfSize:15.]


UIKIT_EXTERN const CGFloat QWAlertMainViewDefaultHeight;
UIKIT_EXTERN const CGFloat QWAlertContentDefaultHeight;
UIKIT_EXTERN const CGFloat QWAlertHeaderHeight;
UIKIT_EXTERN const CGFloat QWAlertBottomHeight;

UIKIT_EXTERN const CGFloat QWAlertMainViewHorizontalOffset;
UIKIT_EXTERN const CGFloat QWAlertContentHorizontalOffset;
UIKIT_EXTERN const CGFloat QWAlertContentLineSpacing; //行间距
UIKIT_EXTERN const CGFloat QWAlertContentKernSpacing; //字间距

UIKIT_EXTERN const CGFloat QWAlertBottomButtonHorizontalSpacing;
UIKIT_EXTERN const CGFloat QWAlertBottomButtonHeight;

UIKIT_EXTERN const CGFloat QWAlertMainViewCornerRadius;
UIKIT_EXTERN const CGFloat QWAlertBottomButtonCornerRadius;
