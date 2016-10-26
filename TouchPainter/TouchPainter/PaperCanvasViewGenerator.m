//
//  PaperCanvasViewGenerator.m
//  TouchPainter
//
//  Created by plum on 2016/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "PaperCanvasViewGenerator.h"
#import "PaperCanvasView.h"

@implementation PaperCanvasViewGenerator

+ (CanvasView *)canvasViewWithFrame:(CGRect)frame {
    return [[PaperCanvasView alloc]initWithFrame:frame];
}

@end
