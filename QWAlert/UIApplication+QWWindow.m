//
//  UIApplication+QWWindow.m
//  QWAlert
//
//  Created by QW on 2017/6/21.
//  Copyright © 2017年 邱威. All rights reserved.
//

#import "UIApplication+QWWindow.h"

@implementation UIApplication (QWWindow)

+ (UIWindow*)mainWindow {
    id appDelegate  = [UIApplication sharedApplication].delegate;
    return [appDelegate performSelector:@selector(window) withObject:nil ];
}

@end
