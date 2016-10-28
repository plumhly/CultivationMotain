//
//  CoordinatingController.h
//  TouchPainter
//
//  Created by libo on 16/10/28.
//  Copyright © 2016年 plum. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CanvasViewController;

@interface CoordinatingController : UIViewController


+ (instancetype)shareInstance;

@property (strong, nonatomic) CanvasViewController *canvasViewController;

@end
