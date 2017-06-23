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

/* 代理*/
@property (nonatomic, weak) id<QWAlertViewDelegate> delegate;

/* 弹出框标题的字体大小 默认 systemFont:22.*/
@property (nonatomic, strong) UIFont *titleFont;

/* 弹出框内容的字体大小 默认 systemFont:16.*/
@property (nonatomic, strong) UIFont *textFont;

/* 弹出框底部按钮的字体大小 默认 systemFont:15.*/
@property (nonatomic, strong) UIFont *buttonFont;

/* 弹出框标题的字体颜色*/
@property (nonatomic, strong) UIColor *titleColor;

/* 弹出框内容的字体颜色*/
@property (nonatomic, strong) UIColor *textColor;

/* 弹出框底部按钮的字体颜色*/
@property (nonatomic, strong) UIColor *buttonTextColor;

/* 弹出框底部按钮的背景颜色*/
@property (nonatomic, strong) UIColor *buttonBackgroundColor;

/* 弹出框背景的颜色 默认是白色*/
@property (nonatomic, strong) UIColor *mainBackgroundColor;

/* 弹出框分割线颜色*/
@property (nonatomic, strong) UIColor *lineBackgroundColor;

/* 弹出框圆角半径*/
@property (nonatomic, assign) CGFloat cornerRadius;

/* 弹出框底部按钮圆角半径*/
@property (nonatomic, assign) CGFloat buttonCornerRadius;

/* 分割线的高度 默认高度 1.*/
@property (nonatomic, assign) CGFloat lineHeight;

/**
 初始化 QWAlertView 
 @param tip 标题
 @param message 内容
 @param otherButtonTitles ... 动态按钮
 
 @return 返回一个QWAlertView的实例
 */
- (instancetype)initWithTitle:(NSString *)tip message:(NSString *)message otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 该方法返回默认的弹出框
 @param tip 标题
 @param message 内容
 @param otherButtonTitles ... 动态按钮
 */
+ (void)alertWithTitle:(NSString *)tip message:(NSString *)message otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/* 
 根据配置信息返回自定义的弹出框
 @param tip 标题
 @param message 内容
 @param configuration 根据configuration给出的配置信息来动态的显示弹出框
    例如：@{@"titleColor": [UIColor redColor]} key为属性名称 value为对应类型的值,弹出框的标题将显示为红色
 @param otherButtonTitles ... 动态按钮
 */
+ (void)alertWithTitle:(NSString *)tip message:(NSString *)message configuration:(NSDictionary *)configuration otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 显示弹出框
 */
- (void)show;

@end


@interface BottomButton : UIButton

@property (nonatomic, strong) UIFont *font;

// 设置按钮的标题 只有UIControlStateNormal状态
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, assign) CGFloat cornerRadius;

@end
