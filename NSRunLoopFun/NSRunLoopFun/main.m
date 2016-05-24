//
//  main.m
//  NSRunLoopFun
//
//  Created by libo on 16/5/24.
//  Copyright © 2016年 libo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBRumLoop.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        LBRumLoop *runLoop = [[LBRumLoop alloc]init];
        [runLoop handleNormalThreadButtonTouchUpInside];
    }
    return 0;
}
