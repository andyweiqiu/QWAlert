//
//  QWAlertView.h
//  QWAlert
//
//  Created by QW on 2017/6/19.
//  Copyright © 2017年 邱威. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QWAlertView;
@protocol QWAlertViewDelegate <NSObject>

- (void)alertView:(QWAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface QWAlertView : UIView

/* 弹出框标题 会覆盖show:message:otherButtonTitles:该方法传过来的标题*/
@property (nonatomic, copy) NSString *title;

/* 弹出框内容 会覆盖show:message:otherButtonTitles:该方法传过来的内容*/
@property (nonatomic, copy) NSString *text;

@property (nonatomic, weak) id<QWAlertViewDelegate> delegate;

/* 设置弹出框标题的字体大小 默认 systemFont:22.*/
@property (nonatomic, strong) UIFont *titleFont;

/* 设置弹出框内容的字体大小 默认 systemFont:16.*/
@property (nonatomic, strong) UIFont *textFont;

/* 设置弹出框底部按钮的字体大小 默认 systemFont:15.*/
@property (nonatomic, strong) UIFont *buttonFont;

/* 设置弹出框标题的字体颜色*/
@property (nonatomic, strong) UIColor *titleColor;

/* 设置弹出框内容的字体颜色*/
@property (nonatomic, strong) UIColor *textColor;

/* 设置弹出框底部按钮的字体颜色*/
@property (nonatomic, strong) UIColor *buttonTextColor;

/* 设置弹出框底部按钮的背景颜色*/
@property (nonatomic, strong) UIColor *buttonBackgroundColor;

/* 设置弹出框背景的颜色 默认是白色*/
@property (nonatomic, strong) UIColor *mainBackgroundColor;

/* 设置弹出框分割线颜色*/
@property (nonatomic, strong) UIColor *lineBackgroundColor;

/* 设置弹出框圆角半径*/
@property (nonatomic, assign) CGFloat cornerRadius;

/* 设置弹出框底部按钮圆角半径*/
@property (nonatomic, assign) CGFloat buttonCornerRadius;

/* 设置分割线的高度 默认高度 1.*/
@property (nonatomic, assign) CGFloat lineHeight;


- (void) show:(NSString *)tip message:(NSString *)message otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end

@interface BottomButton : UIButton

@property (nonatomic, strong) UIFont *font;

// 设置按钮的标题 只有UIControlStateNormal状态
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, assign) CGFloat cornerRadius;

@end
