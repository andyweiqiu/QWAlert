//
//  UILabel+Spacing.h
//  QWAlert
//
//  Created by XMQ on 2017/6/21.
//  Copyright © 2017年 XMQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Spacing)

- (void)setLineSpacing:(CGFloat)lineSpacing kernSpacing:(CGFloat)kernSpacing value:(NSString*)value font:(UIFont*)font;

- (CGFloat)getHeightWithFrameWidth:(CGFloat)frameWidth lineSpacing:(CGFloat)lineSpacing;

@end
