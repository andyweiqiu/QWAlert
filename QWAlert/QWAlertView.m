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
#import <objc/runtime.h>

@interface QWAlertView ()
{
    NSString *_tip;
    NSString *_message;
    va_list _argList;
    
    NSDictionary *_configuration;
    
    NSString *_otherButtonTitles;
    
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
        [self registerForKVO];
    }
    
    return self;
}

- (void)dealloc {
    [self unregisterFromKVO];
}

- (instancetype)initWithTitle:(NSString *)tip message:(NSString *)message otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    if (self = [super init]) {
        [self setup];
        [self registerForKVO];
        
        va_list argList;
        
        va_start(argList, otherButtonTitles);
        
        [self show:tip message:message configuration:nil otherButtonTitles:otherButtonTitles parameters:argList];
        
        va_end(argList);
    }
    return self;
}

+ (void)alertWithTitle:(NSString *)tip message:(NSString *)message otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    QWAlertView *alertView = [[self alloc] init];
    
    va_list argList;
    
    va_start(argList, otherButtonTitles);
    
    [alertView show:tip message:message configuration:nil otherButtonTitles:otherButtonTitles parameters:argList];
    
    va_end(argList);
    
    [alertView show];
}

+ (void)alertWithTitle:(NSString *)tip message:(NSString *)message configuration:(NSDictionary *)configuration otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    QWAlertView *alertView = [[self alloc] init];
    
    va_list argList;
    
    va_start(argList, otherButtonTitles);
    
    [alertView show:tip message:message configuration:configuration otherButtonTitles:otherButtonTitles parameters:argList];
    
    va_end(argList);
    
    [alertView show];
}

- (void) show:(NSString *)tip message:(NSString *)message configuration:(NSDictionary *)configuration otherButtonTitles:(NSString *)otherButtonTitles parameters:(va_list)argList {
    
    _tip = tip;
    _message = message;
    _argList = argList;
    _otherButtonTitles = otherButtonTitles;
    
    [self setProperties];
}

/* 显示*/
- (void)show {
    self.titleLabel.text = _tip;
    
    [self.contentLabel setLineSpacing:QWAlertContentLineSpacing kernSpacing:QWAlertContentKernSpacing value:_message font:QWAlertLabelFont];
    
    [self setupFrame];
    
    NSMutableArray *otherButtonTitleArray = [[NSMutableArray alloc] init];
    
    [otherButtonTitleArray addObject:_otherButtonTitles];
    
    NSString *arg = nil;
    
    while ((arg = va_arg(_argList, NSString *)))
    {
        [otherButtonTitleArray addObject:arg];
    }
    
    _bottomButtonTitles = [NSArray arrayWithArray:otherButtonTitleArray];
    
    [self setupBottomButton];
    
    [[UIApplication mainWindow] addSubview:self];
}

- (void)setProperties {
    
    if (_configuration) {
        
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList(self.class, &outCount);// 获得所有的成员变量
        NSArray *allKeys = _configuration.allKeys;
        
        for (int i=0; i<outCount; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = @(property_getName(property));
            for (NSString *key in allKeys) {
                if ([propertyName isEqualToString:key]) {
                    [self setValue:_configuration[key] forKey:propertyName];
                }
            }
        }
    }
}

- (void)setup {
    _lineHeight = 1.;
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
    CGFloat textHeight = [self.contentLabel getHeightWithFrameWidth:contentWidth lineSpacing:QWAlertContentLineSpacing kernSpacing:QWAlertContentKernSpacing];
    
    CGFloat offset = 0; //相对一行文本的偏移量 (默认一行文本的高度为30.)
    if (textHeight > QWAlertContentDefaultHeight) {
        offset = textHeight - QWAlertContentDefaultHeight;
    }
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.mainView.frame = CGRectMake(0, 0, mainViewWidth, QWAlertMainViewDefaultHeight+offset);
    self.mainView.center = self.center;
    
    self.titleLabel.frame = CGRectMake(QWAlertContentHorizontalOffset, 0, contentWidth, QWAlertHeaderHeight);
    
    self.line.frame = CGRectMake(QWAlertContentHorizontalOffset, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height, contentWidth, self.lineHeight);
    
    self.contentLabel.frame = CGRectMake(QWAlertContentHorizontalOffset, self.line.frame.origin.y+self.line.frame.size.height+25, contentWidth, textHeight);
    
    self.bottomView.frame = CGRectMake(QWAlertContentHorizontalOffset, self.mainView.frame.size.height-QWAlertBottomHeight, contentWidth, QWAlertBottomHeight);
    
}

- (void)setupBottomButton {
    CGFloat width = (self.bottomView.frame.size.width-(_bottomButtonTitles.count-1)*QWAlertBottomButtonHorizontalSpacing)/_bottomButtonTitles.count;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i=0; i<_bottomButtonTitles.count; i++) {
        x = (width+QWAlertBottomButtonHorizontalSpacing)*i;
        BottomButton *button = [BottomButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, width, QWAlertBottomButtonHeight);
        button.backgroundColor = QWAlertBottomButtonBackgroundColor;
        
        [button setTitle:_bottomButtonTitles[i] forState:UIControlStateNormal];
        button.font = QWAlertBottomButtonLabelFont;
        
        button.cornerRadius = QWAlertBottomButtonCornerRadius;
        button.tag = i+bottomButtonTag;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomView addSubview:button];
    }
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
#pragma mark Get

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

#pragma mark - KVO

- (void)registerForKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (NSArray *)observableKeypaths {
    return [NSArray arrayWithObjects:@"title", @"text", @"titleFont", @"textFont", @"buttonFont", @"titleColor", @"textColor", @"buttonTextColor", @"buttonBackgroundColor", @"mainBackgroundColor", @"lineBackgroundColor", @"cornerRadius", @"buttonCornerRadius", @"lineHeight", nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
    } else {
        [self updateUIForKeypath:keyPath];
    }
}

- (void)updateUIForKeypath:(NSString *)keyPath {
    if ([keyPath isEqualToString:@"mainBackgroundColor"]) {
        self.mainView.backgroundColor = self.mainBackgroundColor;
    } else if ([keyPath isEqualToString:@"title"]) {
        self.titleLabel.text = self.title;
    } else if ([keyPath isEqualToString:@"titleFont"]) {
        self.titleLabel.font = self.titleFont;
    } else if ([keyPath isEqualToString:@"titleColor"]) {
        self.titleLabel.textColor = self.titleColor;
    } else if ([keyPath isEqualToString:@"text"]) {
        self.contentLabel.text = self.text;
        [self setupFrame];
    }  else if ([keyPath isEqualToString:@"textFont"]) {
        self.contentLabel.font = self.textFont;
    }  else if ([keyPath isEqualToString:@"textColor"]) {
        self.contentLabel.textColor = self.textColor;
    } else if ([keyPath isEqualToString:@"lineBackgroundColor"]) {
        self.line.backgroundColor = self.lineBackgroundColor;
    } else if ([keyPath isEqualToString:@"cornerRadius"]) {
        self.mainView.layer.cornerRadius = self.cornerRadius;
        self.mainView.layer.masksToBounds = YES;
    } else if ([keyPath isEqualToString:@"lineHeight"]) {
        [self setupFrame];
    } else if ([keyPath isEqualToString:@"buttonCornerRadius"]) {
        for (UIView *sub in self.bottomView.subviews) {
            if ([sub isKindOfClass:[BottomButton class]]) {
                ((BottomButton *)sub).cornerRadius = self.buttonCornerRadius;
            }
        }
    } else if ([keyPath isEqualToString:@"buttonFont"]) {
        for (UIView *sub in self.bottomView.subviews) {
            if ([sub isKindOfClass:[BottomButton class]]) {
                ((BottomButton *)sub).font = self.buttonFont;
            }
        }
    } else if ([keyPath isEqualToString:@"buttonTextColor"]) {
        for (UIView *sub in self.bottomView.subviews) {
            if ([sub isKindOfClass:[BottomButton class]]) {
                ((BottomButton *)sub).textColor = self.buttonTextColor;
            }
        }
    } else if ([keyPath isEqualToString:@"buttonBackgroundColor"]) {
        for (UIView *sub in self.bottomView.subviews) {
            if ([sub isKindOfClass:[BottomButton class]]) {
                ((BottomButton *)sub).backgroundColor = self.buttonBackgroundColor;
            }
        }
    }
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end


#pragma mark -

@interface BottomButton ()

@end

@implementation BottomButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self registerForKVO];
    }
    
    return self;
}

- (void)dealloc {
    [self unregisterFromKVO];
}

#pragma mark - KVO

- (void)registerForKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (NSArray *)observableKeypaths {
    return [NSArray arrayWithObjects:@"font", @"textColor", @"cornerRadius", nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
    } else {
        [self updateUIForKeypath:keyPath];
    }
}

- (void)updateUIForKeypath:(NSString *)keyPath {
    if ([keyPath isEqualToString:@"font"]) {
        self.titleLabel.font = self.font;
    } else if ([keyPath isEqualToString:@"textColor"]) {
        [self setTitleColor:self.textColor forState:UIControlStateNormal];
    } else if ([keyPath isEqualToString:@"cornerRadius"]) {
        self.layer.cornerRadius = self.cornerRadius;
        self.layer.masksToBounds = YES;
    }
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

@end
