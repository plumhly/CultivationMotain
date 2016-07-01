//
//  LBRumLoop.m
//  NSRunLoopFun
//
//  Created by libo on 16/5/24.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "LBRumLoop.h"

@interface LBRumLoop ()

@property (nonatomic, assign) BOOL normalThreadDidFinishFlag;
@property (copy, nonatomic) NSDictionary *dic;

@end

@implementation LBRumLoop

- (NSDictionary *)dic {
    if (!_dic) {
        _dic = @{@"1":@"kCFRunLoopEntry", @"2":@"kCFRunLoopBeforeTimers", @"4":@"kCFRunLoopBeforeSources", @"32":@"kCFRunLoopBeforeWaiting", @"64":@"kCFRunLoopAfterWaiting", @"128":@"kCFRunLoopExit"};
    }
    return _dic;
}

- (void)main {
    NSLog(@"enter thread");
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    CFRunLoopObserverContext context = {NULL, (__bridge void *)self, NULL, NULL, NULL};
    CFRunLoopObserverRef runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, callBack, &context);
    
    if (runLoopObserver) {
        CFRunLoopRef cfRunLoop = runLoop.getCFRunLoop;
        CFRunLoopAddObserver(cfRunLoop, runLoopObserver, kCFRunLoopDefaultMode);
    }
//     创建一个Timer，重复调用来驱动Run Loop
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handerTimerTask) userInfo:nil repeats:YES];
//    [runLoop run];
    NSInteger runCount = 10;
    do {
         NSLog(@"LoopCount: %ld", runCount);
        [runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        [runLoop run];
        runCount -= 1;
    } while (runCount);
    NSLog(@"Thread Exit");
}


void callBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    NSLog(@"%ld",activity);
    NSLog(@"%@",observer);
}

- (void)handerTimerTask {
    NSLog(@"timer");
}

// Normal Thread Task
- (void)handleNormalThreadButtonTouchUpInside {
    NSLog(@"Enter handleNormalThreadButtonTouchUpInside");
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    CFRunLoopObserverContext context = {NULL, (__bridge void *)self, NULL, NULL, NULL};
    CFRunLoopObserverRef runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, callBack, &context);
    
    if (runLoopObserver) {
        CFRunLoopRef cfRunLoop = runLoop.getCFRunLoop;
        CFRunLoopAddObserver(cfRunLoop, runLoopObserver, kCFRunLoopDefaultMode);
    }
    self.normalThreadDidFinishFlag = NO;
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(handleNormalThreadTask) object:nil];
    [thread start];
    while (!self.normalThreadDidFinishFlag) {
//        [NSThread sleepForTimeInterval:0.5];
        [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"End RunLoop");
    }
    NSLog(@"Exit handleNormalThreadButtonTouchUpInside");
}
- (void)handleNormalThreadTask {
    NSLog(@"Enter Normal Thread");
    for (NSInteger i = 0; i < 5; i ++) {
        NSLog(@"In Normal Thread, count = %ld", i);
        sleep(1);
    }
//    _normalThreadDidFinishFlag = YES;
    
    NSLog(@"Exit Normal Thread");
    
#if 0
    // 错误示范
    _runLoopThreadDidFinishFlag = YES;
    // 这个时候并不能执行线程完成之后的任务，因为Run Loop所在的线程并不知道runLoopThreadDidFinishFlag被重新赋值。Run Loop这个时候没有被任务事件源唤醒。
    // 你会发现这个时候点击屏幕中的UI，线程将会继续执行。 因为Run Loop被UI事件唤醒。
    // 正确的做法是使用 "selector"方法唤醒Run Loop。 即如下:
#else
    [self performSelectorOnMainThread:@selector(updateRunLoopThreadDidFinishFlag) withObject:nil waitUntilDone:NO];
#endif
}

- (void)updateRunLoopThreadDidFinishFlag {
    self.normalThreadDidFinishFlag = YES;
}
@end
