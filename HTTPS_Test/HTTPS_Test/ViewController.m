//
//  ViewController.m
//  HTTPS_Test
//
//  Created by libo on 2016/12/1.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "ViewController.h"
#import "NSConnectionTestTrust.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSConnectionTestTrust new] loadData];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
