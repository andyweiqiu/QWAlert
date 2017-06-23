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
//    QWAlertView *alert = [[QWAlertView alloc] initWithTitle:@"提示" message:@"我有一只小毛驴，我从来也不骑，有一天我心血来潮骑着去赶集，我手里拿着小皮鞭，我心里很得意" otherButtonTitles:@"第一个", @"第二个", @"第三个", nil];
//    alert.delegate = self;
//    
//    [alert show];
//    
//    alert.title = @"警告";
//    
//    alert.textColor = [UIColor purpleColor];
//    
//    alert.buttonBackgroundColor = [UIColor blueColor];
//    
//    alert.mainBackgroundColor = [UIColor yellowColor];
//    
//    alert.lineBackgroundColor = [UIColor redColor];
//    
//    alert.cornerRadius = 10.;
//    
//    alert.lineHeight = 3.;
    
//    [QWAlertView alertWithTitle:@"提示" message:@"有一天我心血来潮骑着去赶集，我手里拿着小皮鞭，我心里很得意，我有一只小毛驴，我从来也不骑" otherButtonTitles:@"第一个", @"第二个", @"第三个", nil];
    
    [QWAlertView alertWithTitle:@"呼哈" message:@"有一天我心血来潮骑着去赶集，我手里拿着小皮鞭，我心里很得意，我有一只小毛驴，我从来也不骑" configuration:@{@"titleColor": [UIColor redColor]} otherButtonTitles:@"确定", @"取消", nil];
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
