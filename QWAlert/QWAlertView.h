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
@property (nonatomic, strong) UIColor *buttonColor;



- (void) show:(NSString *)tip message:(NSString *)message otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
