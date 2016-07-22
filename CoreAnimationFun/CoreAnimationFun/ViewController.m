//
//  ViewController.m
//  CoreAnimationFun
//
//  Created by libo on 16/7/10.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    image.frame = CGRectMake(0, 100, 100, 100);
    [self.view addSubview:image];
    
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"position";
//    animation.fromValue = 0;
////    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(200, 200)];
////    animation.toValue = 
////    animation.byValue = @200;
//    animation.repeatCount = 1;
//    animation.duration = 2.0;
//    animation.fillMode = kCAFillModeBackwards;
//    animation.removedOnCompletion = NO;
//    
//    [image.layer addAnimation:animation forKey:@"basic"];
//
//    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
//    image1.frame = CGRectMake(0, 100, 100, 100);
//    [self.view addSubview:image1];
//    
//    animation.beginTime = CACurrentMediaTime() + 0.5;
//    [image1.layer addAnimation:animation forKey:@"basica"
//     ];
    
//    image.layer.position =CGPointMake(100, 200);
    
//    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
//    keyFrameAnimation.keyPath = @"position.x";
//    keyFrameAnimation.values = @[@0,@-10, @10, @0];
//    keyFrameAnimation.keyTimes = @[@0, @(1/3.0), @(2/3.0), @1];
//    keyFrameAnimation.duration = 0.4;
//    keyFrameAnimation.additive = YES;
//    
//    [image.layer addAnimation:keyFrameAnimation  forKey:@"shake"];
    
//    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
//    CGRect boundingRect = CGRectMake(0, -100, 300, 300);
//    rotation.keyPath = @"position";
//    rotation.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
//    rotation.duration = 4;
//    rotation.additive = YES;
//    rotation.repeatCount = HUGE_VALF;
//    rotation.calculationMode = kCAAnimationCubic;
//    rotation.rotationMode = kCAAnimationRotateAuto;
//    
//    [image.layer addAnimation:rotation forKey:@"orbit"];
//
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    view1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view1];
    
//    CABasicAnimation *animation = [CABasicAnimation animation];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.values = @[@0, @50, @100, @150, @400, @150, @400];
    animation.keyTimes = @[@0, @(1/6.0), @(2/6.0), @(3/6.0), @(4/6.0), @(5/6.0), @(1)];
    animation.keyPath = @"position.y";
    animation.duration = 1;
    animation.repeatCount = 5;
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.1 :0.3 :.5f :0.9];
    
    [view.layer addAnimation:animation forKey:@"function"];
    view.layer.position = CGPointMake(0, 400);
    
    
    /*
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @-1;
    zPosition.toValue = @1;
    zPosition.duration = 1.2;
    
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[@0, @(0.14), @(0)];
    rotation.duration = 1.2;
    rotation.keyTimes = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[
                        [NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(110, -20)],
                        [NSValue valueWithCGPoint:CGPointZero]
                        ];
    position.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    
    position.additive = YES;
    position.duration = 1.2;
    
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
    group.animations = @[zPosition, rotation, position];
    group.duration = 1.2;
    group.beginTime = 0.5;
    [view.layer addAnimation:group forKey:@"shuffle"];
    
//    view.layer.zPosition = 1;
    
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @-1;
    zPosition.toValue = @1;
    zPosition.duration = 1.2;
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[ @0, @0.14, @0 ];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[
                        [NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(110, -20)],
                        [NSValue valueWithCGPoint:CGPointZero]
                        ];
    position.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    position.additive = YES;
    position.duration = 1.2;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[ zPosition, rotation, position ];
    group.duration = 1.2;
    group.beginTime = 0.5;
    
    [view1.layer addAnimation:group forKey:@"shuffle"];
    
//    view.layer.zPosition = 1;
    
    */
    
    
    //贝塞尔曲线路径
//    UIBezierPath *movePath = [UIBezierPath bezierPath];
//    [movePath moveToPoint:CGPointMake(10.0, 10.0)];
//    [movePath addQuadCurveToPoint:CGPointMake(100, 300) controlPoint:CGPointMake(300, 100)];
//    
//    //以下必须导入QuartzCore包
//    　　//关键帧动画（位置）
//    CAKeyframeAnimation * posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    posAnim.path = movePath.CGPath;
//    posAnim.removedOnCompletion = YES;
    
    //缩放动画
//    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
//    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1)];
//    scaleAnim.removedOnCompletion = YES;
//    
    //透明动画
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
//    opacityAnim.removedOnCompletion = YES;
    
    //动画组
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:opacityAnim, nil];
    animGroup.duration = 1;
    
    [view1.layer addAnimation:animGroup forKey:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
