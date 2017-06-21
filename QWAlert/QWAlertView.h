//
//  QWAlertView.h
//  QWAlert
//
//  Created by XMQ on 2017/6/19.
//  Copyright © 2017年 XMQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QWAlertView;
@protocol QWAlertViewDelegate <NSObject>

- (void)alertView:(QWAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface QWAlertView : UIView

@property (nonatomic, weak) id<QWAlertViewDelegate> delegate;

- (void) show:(NSString *)tip message:(NSString *)message otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
