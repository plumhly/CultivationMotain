//
//  ViewController.m
//  __Attribute__Ex
//
//  Created by plum on 2017/9/7.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

static void cleanupString(__strong NSString **p) {
    NSLog(@"%@", *p);
}

static void cleanupBlock(__strong void(^*block)()) {
    (*block)();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    {
        NSString *name __attribute__((cleanup(cleanupString),unused)) = @"libo";
    }
    
    {
        __strong void(^block)() __attribute__((cleanup(cleanupBlock))) = ^{
            NSLog(@"dying");
        };
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
