//
//  ViewController.m
//  NSProgressTest
//
//  Created by libo on 16/11/7.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property NSProgress *overallProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _progressView.progress = 0;
    
    [self startLongOperation];
}

- (void)startLongOperation {
    self.overallProgress = [NSProgress progressWithTotalUnitCount:100];
    [self.overallProgress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    self.overallProgress.cancellationHandler = ^{
        NSLog(@"我cancel了");
    };
    
    self.overallProgress.pausingHandler = ^{
        NSLog(@"我pause了");
    };
    
    self.overallProgress.resumingHandler = ^{
        NSLog(@"我resume了");
    };
    
    
    
    
    
    
//    [self.overallProgress becomeCurrentWithPendingUnitCount:50];
    [self work1];
//    [self.overallProgress resignCurrent];
//    
//    [self.overallProgress becomeCurrentWithPendingUnitCount:50];
    [self work2];
//    [self.overallProgress resignCurrent];
}

- (void)work1 {
    __block NSProgress *firstTaskProgress = [NSProgress progressWithTotalUnitCount:100 parent:_overallProgress pendingUnitCount:50];
    firstTaskProgress.totalUnitCount = 100;
    // Perform first task...
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (_overallProgress.paused) {
            [timer invalidate];
        }
        firstTaskProgress.completedUnitCount++;
        if (firstTaskProgress.completedUnitCount == 50) {
            [_overallProgress pause];
            
            [self performSelector:@selector(hh) withObject:nil afterDelay:5];
            
        }
        
        if (firstTaskProgress.completedUnitCount >= 100) {
            [timer invalidate];
        }
    }];
}
- (void)hh {
    [_overallProgress resume];
}

- (void)work2 {
   __block NSProgress *secondTaskProgress = [NSProgress progressWithTotalUnitCount:100 parent:_overallProgress pendingUnitCount:50];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        secondTaskProgress.completedUnitCount++;
        
        if (secondTaskProgress.completedUnitCount == 50) {
            [secondTaskProgress pause];
            
        }
        
        
        if (secondTaskProgress.completedUnitCount >= 100) {
            [timer invalidate];
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"%@",change);
    [_progressView setProgress:[change[@"new"] floatValue] animated:YES];
    NSLog(@"===%@====%@", _overallProgress.localizedDescription,_overallProgress.localizedAdditionalDescription);
}


@end
