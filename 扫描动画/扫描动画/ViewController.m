//
//  ViewController.m
//  扫描动画
//
//  Created by plum on 2017/8/25.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "ViewController.h"
#import "PlumScanView.h"

@interface ViewController ()

@property (nonatomic, strong) PlumScanView *sca;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sca = [PlumScanView scanView];
    [self.view addSubview:_sca];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
