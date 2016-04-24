//
//  AffinetransformView.m
//  CGAffinetransformFun
//
//  Created by libo on 16/4/24.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "AffinetransformView.h"

#define agree(a) (M_PI * a / 180)

@implementation AffinetransformView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    //旋转
    CGAffineTransform transform = CGAffineTransformMakeRotation(agree(45));
    
    CGRect aRect = CGRectMake(100 , 100, 50, 50);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, &transform, aRect);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
//    CGContextFillRect(context, aRect);
    CGPathRelease(path);
}


@end
