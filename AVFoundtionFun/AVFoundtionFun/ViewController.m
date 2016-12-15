//
//  ViewController.m
//  AVFoundtionFun
//
//  Created by libo on 2016/12/2.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
//#import <Photos/Photos.h>

#define mp3_url @"http://avatar.anzogame.com/face/lscs/345/073/9109/56fa66303d606.MP3"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self learnALAssetLibrary];
    [self learnAVURLAsset];
    
}

- (void)learnAVURLAsset {
    NSURL *url = [NSURL URLWithString:mp3_url];
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:url options:@{AVURLAssetPreferPreciseDurationAndTimingKey: [NSNumber numberWithBool:YES]}];
    NSArray *keys = @[@"duration"];//AVURLAsset的属性
    
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        
        NSError *error = nil;
        AVKeyValueStatus status = [asset statusOfValueForKey:@"duration" error:&error];
        NSLog(@"");
        
    }];
    
    
    NSLog(@"");
}

- (void)learnALAssetLibrary {
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc]init];
    [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                ALAssetRepresentation *represent = [result defaultRepresentation];
                NSURL *url = [represent url];
                AVAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
                NSLog(@"");
            }
            
        }];
        
    } failureBlock:^(NSError *error) {
         NSLog(@"No groups");
    }];
}

- (void)learnPHotoLibrary {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
