//
//  UILabel+QWSpacing.m
//  QWAlert
//
//  Created by QW on 2017/6/21.
//  Copyright © 2017年 邱威. All rights reserved.
//

#import "UILabel+QWSpacing.h"

@implementation UILabel (QWSpacing)

- (void)setLineSpacing:(CGFloat)lineSpacing kernSpacing:(CGFloat)kernSpacing value:(NSString*)value font:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = lineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(kernSpacing)};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:value attributes:dic];
    self.attributedText = attributeStr;
}

- (CGFloat)getHeightWithFrameWidth:(CGFloat)frameWidth lineSpacing:(CGFloat)lineSpacing kernSpacing:(CGFloat)kernSpacing  {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    style.lineSpacing = lineSpacing;
    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(frameWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.font, NSParagraphStyleAttributeName: style, NSKernAttributeName:@(kernSpacing)} context:nil].size;
    return size.height;
}


@end
