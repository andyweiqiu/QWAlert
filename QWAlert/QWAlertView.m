//
//  QWAlertView.m
//  QWAlert
//
//  Created by QW on 2017/6/19.
//  Copyright © 2017年 邱威. All rights reserved.
//

#import "QWAlertView.h"
#import "UIApplication+QWWindow.h"
#import "UILabel+QWSpacing.h"
#import "QWAlertConst.h"

#define bottomButtonTag  1000

@interface QWAlertView ()
{
    NSArray *_bottomButtonTitles;
}

/** 弹出框 */
@property (nonatomic, strong) UIView *mainView;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 分割线 */
@property (nonatomic, strong) UIView *line;
/** 内容 */
@property (nonatomic, strong) UILabel *contentLabel;
/** 底部按钮容器 */
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation QWAlertView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)dealloc {
    
}

- (void)setup {
    self.backgroundColor = QWAlertCoverBackgroundColor;
    
    [self addSubview:self.mainView];
    
    [self.mainView addSubview:self.titleLabel];
    [self.mainView addSubview:self.line];
    [self.mainView addSubview:self.contentLabel];
    [self.mainView addSubview:self.bottomView];
}

- (void)setupFrame {
    //弹出框宽
    CGFloat mainViewWidth = SCREEN_WIDTH - 2*QWAlertMainViewHorizontalOffset;
    
    //弹出框内容的宽
    CGFloat contentWidth = mainViewWidth - 2*QWAlertContentHorizontalOffset;
    
    //内容的文本高度
    CGFloat textHeight = [self.contentLabel getHeightWithFrameWidth:contentWidth lineSpacing:QWAlertContentLineSpacing];
    NSLog(@"%f", textHeight);
    
    CGFloat offset = 0; //相对一行文本的偏移量 (默认一行文本的高度为30.)
    if (textHeight > QWAlertContentDefaultHeight) {
        offset = textHeight - QWAlertContentDefaultHeight;
    }
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.mainView.frame = CGRectMake(0, 0, mainViewWidth, QWAlertMainViewDefaultHeight+offset);
    self.mainView.center = self.center;
    
    self.titleLabel.frame = CGRectMake(QWAlertContentHorizontalOffset, 0, contentWidth, QWAlertHeaderHeight);
    
    self.line.frame = CGRectMake(QWAlertContentHorizontalOffset, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height, contentWidth, 1);
    
    self.contentLabel.frame = CGRectMake(QWAlertContentHorizontalOffset, self.line.frame.origin.y+self.line.frame.size.height+25, contentWidth, textHeight);
    
    self.bottomView.frame = CGRectMake(QWAlertContentHorizontalOffset, self.mainView.frame.size.height-QWAlertBottomHeight, contentWidth, QWAlertBottomHeight);
    
}

- (void)setupBottomButton {
    CGFloat width = (self.bottomView.frame.size.width-(_bottomButtonTitles.count-1)*QWAlertBottomButtonHorizontalSpacing)/_bottomButtonTitles.count;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i=0; i<_bottomButtonTitles.count; i++) {
        x = (width+QWAlertBottomButtonHorizontalSpacing)*i;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, width, QWAlertBottomButtonHeight);
        button.backgroundColor = QWAlertBottomButtonBackgroundColor;
        
        [button setTitle:_bottomButtonTitles[i] forState:0];
        button.titleLabel.font = QWAlertBottomButtonLabelFont;
        
        button.layer.cornerRadius = QWAlertBottomButtonCornerRadius;
        button.layer.masksToBounds = YES;
        button.tag = i+bottomButtonTag;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomView addSubview:button];
    }
}

- (void) show:(NSString *)tip message:(NSString *)message otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    
    self.titleLabel.text = tip;
    
    [self.contentLabel setLineSpacing:QWAlertContentLineSpacing kernSpacing:QWAlertContentKernSpacing value:message font:[UIFont systemFontOfSize:16.]];
    
    [self setupFrame];
    
    NSString *arg = nil;
    
    va_list argList;
    
    NSMutableArray *otherButtonTitleArray = [[NSMutableArray alloc] init];
    
    [otherButtonTitleArray addObject:otherButtonTitles];
    
    va_start(argList, otherButtonTitles);
    while ((arg = va_arg(argList, NSString *)))
    {
        [otherButtonTitleArray addObject:arg];
    }
    va_end(argList);
    
    _bottomButtonTitles = [NSArray arrayWithArray:otherButtonTitleArray];
    
    [self setupBottomButton];
    
   [[UIApplication mainWindow] addSubview:self];
}

- (void)buttonClicked:(UIButton *)button {
    self.alpha = 0.0f;
    [self removeFromSuperview];
    NSInteger index = button.tag - bottomButtonTag;
    if (_delegate && [_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [_delegate alertView:self clickedButtonAtIndex:index];
    }
}

#pragma mark -
#pragma mark get - set

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.cornerRadius = QWAlertMainViewCornerRadius;
        _mainView.layer.masksToBounds = YES;
    }
    
    return _mainView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = QWAlertHeaderTextColor;
        _titleLabel.font = QWAlertHeaderLabelFont;
    }
    
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = QWAlertLabelFont;
    }
    
    return _contentLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = QWAlertLineColor;
    }
    
    return _line;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    
    return _bottomView;
}

#pragma mark -

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setText:(NSString *)text{
    _text = text;
    
    self.contentLabel.text = text;
    [self setupFrame]; //需要重新布局
}

// - 字体大小
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    
    self.titleLabel.font = titleFont;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    
    self.contentLabel.font = textFont;
}

- (void)setButtonFont:(UIFont *)buttonFont {
    _buttonFont = buttonFont;
}

// - 字体颜色
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.titleLabel.textColor = titleColor;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.contentLabel.textColor = textColor;
}

@end
