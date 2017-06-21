//
//  ViewController.m
//  QWAlert
//
//  Created by QW on 2017/6/19.
//  Copyright © 2017年 邱威. All rights reserved.
//

#import "ViewController.h"
#import "QWAlertView.h"

@interface ViewController ()<QWAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    QWAlertView *alert = [[QWAlertView alloc] init];
    alert.delegate = self;
    [alert show:@"提示" message:@"我有一只小毛驴，我有一只小毛驴，我有一只小毛驴，我有一只小毛驴，我有一只小毛驴" otherButtonTitles:@"第一个", @"第二个", @"第三个", nil];
}

- (void)alertView:(QWAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"第一个");
    } else if (buttonIndex == 1) {
        NSLog(@"第二个");
    } else if (buttonIndex == 2) {
        NSLog(@"第三个");
    }
}

@end
