//
//  RunLoopSource.m
//  NSRunLoopFun
//
//  Created by plum on 16/5/25.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "RunLoopSource.h"

@implementation RunLoopSource



@end


void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode) {
    RunLoopSource *obj = (RunLoopSource *)CFBridgingRelease(info);
    AppDelegate *del = [AppDelegate share ];
}




@implementation runLoopContext



@end
