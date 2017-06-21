//
//  UIApplication+window.m
//  QWAlert
//
//  Created by XMQ on 2017/6/21.
//  Copyright © 2017年 XMQ. All rights reserved.
//

#import "UIApplication+window.h"

@implementation UIApplication (window)

+ (UIWindow*)mainWindow {
    id appDelegate  = [UIApplication sharedApplication].delegate;
    return [appDelegate performSelector:@selector(window) withObject:nil ];
}

@end
