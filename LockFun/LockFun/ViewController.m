//
//  ViewController.m
//  LockFun
//
//  Created by libo on 16/7/13.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testSynchronized];
//    [self testDisPatch_semaphore];
//    [self testNSLock];
//    [self testNSRecursiveLock];
//    [self testNSConditionLock];
//    [self testNSCondition];
//    [self test_pthread_mutex];
//    [self test_pthread_mutex_recursive];
    [self testOSSpinLock];
}

- (void)testOSSpinLock {
    __block OSSpinLock theLock = OS_SPINLOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSpinLockLock(&theLock);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(9);
        NSLog(@"需要线程同步的操作1 结束");
        OSSpinLockUnlock(&theLock);
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        //       int index = pthread_mutex_trylock(&theLock);
        OSSpinLockLock(&theLock);
        NSLog(@"需要线程同步的操作2");
        OSSpinLockUnlock(&theLock);
    });
}

- (void)test_pthread_mutex_recursive {
    
    __block pthread_mutex_t theLock = PTHREAD_RECURSIVE_MUTEX_INITIALIZER;
    //    pthread_mutex_init(&theLock, NULL);
    /*
    pthread_mutexattr_t attribute;
    pthread_mutexattr_init(&attribute);
    pthread_mutexattr_settype(&attribute, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&theLock, &attribute);
    pthread_mutexattr_destroy(&attribute);
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void(^RecorsiveMethod)(int);
        RecorsiveMethod = ^(int value) {
            pthread_mutex_lock(&theLock);
            //           BOOL is = [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
            //            NSLog(@"%d",is);
            if (value > 0) {
                NSLog(@"%d",value);
                sleep(4);
                RecorsiveMethod(value - 1);
            }
            pthread_mutex_unlock(&theLock);
        };
        RecorsiveMethod(5);
    });
}

- (void)test_pthread_mutex {
    
    __block pthread_mutex_t theLock = PTHREAD_MUTEX_INITIALIZER;
//    pthread_mutex_init(&theLock, NULL);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        pthread_mutex_lock(&theLock);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(9);
        NSLog(@"需要线程同步的操作1 结束");
        pthread_mutex_unlock(&theLock);
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
//       int index = pthread_mutex_trylock(&theLock);
        pthread_mutex_lock(&theLock);
        NSLog(@"需要线程同步的操作2");
        pthread_mutex_unlock(&theLock);
    });
}

- (void)testNSCondition {
    NSMutableArray *products = [NSMutableArray array];
    NSCondition *lock = [[NSCondition alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [lock lock];
            if (products.count == 0) {
                NSLog(@"等待1");
                [lock wait];
            }
//            [products removeObjectAtIndex:0];
            NSLog(@"移除");
            [lock unlock];
//            sleep(10);
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            
            [lock lock];
            NSLog(@"添加");
//            [products addObject:[NSObject new]];
            [lock signal];
             [lock unlock];
        }
    });
}

- (void)testNSConditionLock {
    NSMutableArray *products = [NSMutableArray array];
    NSInteger HAS_DATA = 1;
    NSInteger NO_DATA = 0;
    NSConditionLock *lock = [[NSConditionLock alloc]initWithCondition:HAS_DATA];//初始的时候给设置初始化的condition
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [lock lockWhenCondition:NO_DATA];
//            [products addObject:[NSObject new]];
            NSLog(@"products number is %ld",(long)products.count);
            [lock unlockWithCondition:HAS_DATA];
            sleep(10);
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
             NSLog(@"等待");
            [lock lockWhenCondition:HAS_DATA];
//            [products removeObjectAtIndex:0];
            NSLog(@"清空数组");
            [lock unlockWithCondition:NO_DATA];
        }
    });
}

- (void)testNSRecursiveLock {
//    NSLock *lock = [[NSLock alloc]init];
    NSRecursiveLock *lock = [[NSRecursiveLock alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void(^RecorsiveMethod)(int);
        RecorsiveMethod = ^(int value) {
            [lock lock];
//           BOOL is = [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
//            NSLog(@"%d",is);
            if (value > 0) {
                NSLog(@"%d",value);
                sleep(4);
                RecorsiveMethod(value - 1);
            }
            [lock unlock];
        };
        RecorsiveMethod(5);
    });
   

}

- (void)testNSLock {
    NSLock *lock = [[NSLock alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        NSLog(@"需要线程同步的操作1 开始");
        sleep(3);
        NSLog(@"需要线程同步的操作1 结束");
        [lock unlock];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        if ([lock tryLock]) {
            NSLog(@"1获取lock成功");
            [lock unlock];
        } else {
            NSLog(@"1获取lock失败");
        }
        NSTimeInterval interval = 3.0;
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:interval];
        if ([lock lockBeforeDate:date]) {
             NSLog(@"2获取lock成功");
            [lock unlock];
        } else {
            NSLog(@"2获取lock失败");
        }
    });
}

- (void)testSynchronized {
    NSObject *obj = [[NSObject alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                @synchronized (obj) {
        NSLog(@"需要线程同步的操作1 开始");
        sleep(3);
        NSLog(@"需要线程同步的操作1 结束");
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (obj) {
            NSLog(@"需要线程同步的操作2");
        }
    });
}

- (void)testDisPatch_semaphore {
    //overTime > sleep time 才能有同步的功能
    /*原因：dispatch_semaphore_wait(semaphore, overTime);在到达overtime之后就会执行dispatch_semaphore_wait之后的代码了
     dispatch_semaphore_create()中填入0就没作用
     */
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 13 * NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(semaphore, overTime);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(5);
        NSLog(@"需要线程同步的操作1 结束");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(semaphore, overTime);
        NSLog(@"需要线程同步的操作2");
        dispatch_semaphore_signal(semaphore);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
