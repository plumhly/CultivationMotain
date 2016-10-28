//
//  SetStrokeColorCommand.m
//  TouchPainter
//
//  Created by libo on 16/10/28.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "SetStrokeColorCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"

@implementation SetStrokeColorCommand

- (void)execute {
    float redValue = 0.0;
    float greenValue = 0.0;
    float blueValue = 0.0;
    
    //get rgb
    [_delegate command:self didRequestColorComponentsForRed:&redValue green:&greenValue blue:&blueValue];
    

    //创建颜色
    UIColor *color = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
    
    //把它赋值给canvasViewController
    CoordinatingController *coordinator = [CoordinatingController shareInstance];
    CanvasViewController *controller = coordinator.canvasViewController;
    controller.strokeColor = color;
    
    //转发成功消息
    [_delegate command:self didFinishUpdateColorWithColor:color];

}


@end
