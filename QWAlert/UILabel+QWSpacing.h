//
//  UILabel+QWSpacing.h
//  QWAlert
//
//  Created by QW on 2017/6/21.
//  Copyright © 2017年 邱威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (QWSpacing)

- (void)setLineSpacing:(CGFloat)lineSpacing kernSpacing:(CGFloat)kernSpacing value:(NSString*)value font:(UIFont*)font;

- (CGFloat)getHeightWithFrameWidth:(CGFloat)frameWidth lineSpacing:(CGFloat)lineSpacing kernSpacing:(CGFloat)kernSpacing;


@end
