//
//  TestTargetQueue.m
//  GCDAssist
//
//  Created by libo on 2017/1/20.
//  Copyright © 2017年 libo. All rights reserved.
//

#import "TestTargetQueue.h"

@implementation TestTargetQueue

+ (void)plum {
    
    //创建两个串行队列
    dispatch_queue_t queueA = dispatch_queue_create("com.plum.a", NULL);
    dispatch_queue_t queueB = dispatch_queue_create("com.plum.b", NULL);
    
    dispatch_set_target_queue(queueB, queueA);
    
    static int kQueueSpecify;
    CFStringRef value1 = CFSTR("queueA1");
    CFStringRef value2 = CFSTR("queueA2");
    dispatch_queue_set_specific(queueA, &kQueueSpecify, (void *)value1, (dispatch_function_t)testValueRealease);
    dispatch_queue_set_specific(queueA, &kQueueSpecify, (void *)value2, (dispatch_function_t)testValueRealease);
    
    
    dispatch_async(queueA, ^{
        
        CFStringRef va = dispatch_get_specific(&kQueueSpecify);
        NSLog(@"queueA1");
    });
    
    dispatch_async(queueA, ^{
        NSLog(@"queueA2");
    });
    
    dispatch_async(queueB, ^{
        NSLog(@"queueB1");
    });
    
    dispatch_async(queueB, ^{
        NSLog(@"queueB2");
    });
    
}

void testValueRealease() {
    NSLog(@"key释放了");
}


@end
