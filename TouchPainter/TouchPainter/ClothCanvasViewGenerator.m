//
//  ClothCanvasViewGenerator.m
//  TouchPainter
//
//  Created by plum on 2016/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "ClothCanvasViewGenerator.h"
#import "ClothCanvasView.h"

@implementation ClothCanvasViewGenerator

+ (CanvasView *)canvasViewWithFrame:(CGRect)frame {
    return [[ClothCanvasView alloc]initWithFrame:frame];
}

@end
