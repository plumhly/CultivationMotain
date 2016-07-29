//
//  ViewController.m
//  MultiThreadFun
//
//  Created by plum on 16/7/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "ViewController.h"
#import "PlumThread.h"

@interface ViewController ()

@property (nonatomic,strong) NSThread *thread;
@property (strong, nonatomic) dispatch_group_t group;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isGetNotificatoin) name:
    NSWillBecomeMultiThreadedNotification object:nil];
    
//    NSDictionary *dic = @{@"a":@"b"};
//    NSMutableDictionary *mutableDic = [dic mutableCopy];
//    
//    [mutableDic setValue:nil forKey:@"c"];
//    
//    [dic setValue:@"a" forKey:@"a"];
    
    
//    [self testNSThread];
//    [self testCustomThread];
//    [self testNSOperation];
    [self testGCD];
}

- (void)testGCD {
    
    NSMutableArray *array = [NSMutableArray array];
    NSLock *lock = [[NSLock alloc]init];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //1.dispatch_group
    /*
    self.group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (NSInteger index = 0; index < 4000; index ++) {
        dispatch_group_async(self.group, queue, ^{
            [self addItemToArray:@(index) array:array lock:lock];
        });
    }
    
    dispatch_group_notify(self.group, queue, ^{
        NSLog(@"%ld",array.count);
    });
    */
    
    //2.dispatch_apply
    /*
    CFTimeInterval first = CFAbsoluteTimeGetCurrent();
    for (int index = 0; index < 10000; index++) {
        NSLog(@"");
    }
    CFTimeInterval last = CFAbsoluteTimeGetCurrent();
    
    CFTimeInterval forInterval = last - first;
    
    CFTimeInterval disFirst = CFAbsoluteTimeGetCurrent();
    dispatch_apply(10000, queue, ^(size_t index) {
        [array addObject:@(index)];
        NSLog(@"");
    });
     CFTimeInterval disLast = CFAbsoluteTimeGetCurrent();
    CFTimeInterval disInterval = disLast - disFirst;
    NSLog(@"");
     */
    
    //3.dispatch_barrier
   
    /*
    dispatch_async( queue, ^{
         dispatch_queue_t myQueue = dispatch_queue_create("com.anzogame.test", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(myQueue, ^{
            NSLog(@"1");
        });
        
        dispatch_async(myQueue, ^{
            NSLog(@"2");
        });
        
        dispatch_sync(myQueue, ^{
            NSLog(@"3");
            //        sleep(10);
        });
        
        dispatch_async(myQueue, ^{
            NSLog(@"4");
        });
        
        dispatch_async(myQueue, ^{
            NSLog(@"5");
        });
    });
    */
    
    //4 dispatch_source
    
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_OR, 0, 0, queue);
    dispatch_source_set_event_handler(source, ^{
        NSLog(@"处理事情");
      unsigned long data =  dispatch_source_get_data(source);
        NSLog(@"%lu",data);
    });
    for (int index = 0; index < 3; index++) {
        dispatch_source_merge_data(source, index+1);
    }
    
    dispatch_resume(source);
}

- (void)addItemToArray:(NSNumber *)number array:(NSMutableArray *)array lock:(NSLock *)lock{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        [array addObject:number];
        [lock unlock];
    });
    
}



- (void)testNSOperation {
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(printLog:) object:nil];
    
 NSInvocationOperation *invocationOperation2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(log) object:nil];
    [invocationOperation2 setQueuePriority:NSOperationQueuePriorityHigh];
    
//    [invocationOperation start];
    NSOperationQueue *operationQueue1 = [[NSOperationQueue alloc]init];
    operationQueue1.maxConcurrentOperationCount = 1;
    [operationQueue1 addOperations:@[invocationOperation, invocationOperation2] waitUntilFinished:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testCustomThread {
    PlumThread *thread = [[PlumThread alloc]initWithTarget:self selector:@selector(printLog:) object:@""];
    [thread start];
}

- (void)testNSThread {
    _thread = [[NSThread alloc]initWithTarget:self selector:@selector(printLog:) object:@"libo"];
    _thread.name = @"thread1";
    NSDictionary *dic = @{@"dd":@"ff"};
//    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
//    [NSThread exit];
    [_thread start];
//    [self performSelector:@selector(doSomeThing) onThread:thread withObject:nil waitUntilDone:NO];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(doSomeThing) userInfo:nil repeats:YES];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:@selector(init)]];
//    [invocation setTarget: self];
//    [invocation setSelector:@selector(doSomeThing)];
    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 invocation:invocation repeats:YES];
//   NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(doSomeThing) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]];
//    [timer fire];
//    [NSThread detachNewThreadSelector:@selector(printLog:) toTarget:self withObject:@"libo"];
//    [self sleepAction];
}

- (void)sleepAction {
    sleep(3);
    NSLog(@"");
}

- (void)isGetNotificatoin {
    NSLog(@"");
}

- (void)log {
    NSLog(@"1");
}

- (void)printLog:(NSString *)object {
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"========");
//    [[NSRunLoop currentRunLoop] run];
//    BOOL ret = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
//                                        beforeDate:[NSDate distantFuture]];
    [_thread cancel];
}

- (void)doSomeThing {
    NSLog(@"do something");
}


- (void)dealloc {
    
}
@end
