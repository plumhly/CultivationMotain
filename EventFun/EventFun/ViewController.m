//
//  ViewController.m
//  EventFun
//
//  Created by libo on 2016/12/5.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oritentionChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
multiplyByInverseOfAttitude:
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)oritentionChanged:(NSNotification *)noti {
    NSLog(@"我检测到了");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"停止shake了");
}

@end
