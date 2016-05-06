//
//  ViewController.m
//  SelectMenu
//
//  Created by plum on 16/5/6.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "ViewController.h"
#import "PLMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"圣骑士", @"法师", @"战士", @"牧师"];
    PLMenu *menu = [[PLMenu alloc]initMenuWithArray:array];
    [self.view addSubview:menu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
