//
//  PlumThread.m
//  MultiThreadFun
//
//  Created by plum on 16/7/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "PlumThread.h"


@interface PlumThread()


@end

@implementation PlumThread
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)main {
    
    NSLog(@"main函数被执行了");
}

- (NSString *)authorName {
    return @"Plum";
}

@end
