//
//  ViewController.m
//  LearnAnimationFun
//
//  Created by libo on 16/7/12.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (strong, nonatomic) CALayer *blueLayer;
@property (strong, nonatomic) CALayer *greenLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CALayer *subLayer = [CALayer layer];
//    subLayer.frame = CGRectMake(0, 0, 240, 130);
//    subLayer.backgroundColor = [UIColor redColor].CGColor;
//    [self.layerView.layer addSublayer:subLayer];
    
//    UIImage *image = [UIImage imageNamed:@"1.jpg"];
//    self.layerView.layer.contents = (__bridge id)image.CGImage;
//    self.layerView.layer.contentsGravity = kCAGravityCenter;
//    self.layerView.layer.shadowOpacity = 0.5;
//    self.layerView.layer.shadowOffset = CGSizeMake(10, 10);
//    self.layerView.frame = CGRectMake(10, 10, 100, 100);
//    self.layerView.layer.contentsScale = 3.0;
//    self.layerView.contentScaleFactor = image.scale;
//    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
//    self.layerView.layer.masksToBounds = YES;
//    self.layerView.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
//    
//    [self testLayerDelegate];
//    [self testPositonAndArchorPoint];
//    [self testContainPointAndHitTest];
    [self testShadow];
}

- (void)testShadow {
    _blueLayer = [CALayer layer];
    _blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    _blueLayer.shadowOpacity = 0.5;
    _blueLayer.shadowOffset = CGSizeMake(0, 10);
    _blueLayer.shadowRadius = 10;
    
//    CGPathRef path = CGPathCreateWithRect(self.layerView.bounds, NULL);
    CGPathRef path = CGPathCreateWithEllipseInRect(self.layerView.bounds, NULL);
    _blueLayer.shadowPath = path;
    
    CGPathRelease(path);
    _blueLayer.frame = CGRectMake(-50, -50, 100, 100);
    [self.shadowView.layer addSublayer:_blueLayer];
    
//    self.layerView.layer.shadowOffset = CGSizeMake(0, 10);
//    self.layerView.layer.shadowOpacity = 0.5;
//    self.shadowView.layer.masksToBounds = YES;
    
    
}

- (void)testContainPointAndHitTest {
    _blueLayer = [CALayer layer];
    _blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    _blueLayer.frame = CGRectMake(0, 0, 100, 100);
    [self.layerView.layer addSublayer:_blueLayer];
    
    _greenLayer = [CALayer layer];
    _greenLayer.backgroundColor = [UIColor greenColor].CGColor;
    _greenLayer.frame = CGRectMake(50, 50, 400, 400);
    [self.layerView.layer addSublayer:_greenLayer];
    _blueLayer.zPosition = 1;
    
    NSLog(@"%@",self.layerView.layer.sublayers);
}



- (void)testLayerDelegate {
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.delegate = self;
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:blueLayer];
    [blueLayer display];
}

- (void)testPositonAndArchorPoint {
    UIView *testArchorPoint = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 40, 50)];
    testArchorPoint.backgroundColor = [UIColor redColor];
    [self.layerView addSubview:testArchorPoint];
    
    NSLog(@"Before");
    NSLog(@"frame = %@",NSStringFromCGRect(testArchorPoint.layer.frame));
    NSLog(@"bounds = %@",NSStringFromCGRect(testArchorPoint.layer.bounds));
    NSLog(@"position = %@",NSStringFromCGPoint(testArchorPoint.layer.position));
    NSLog(@"archorPoint = %@",NSStringFromCGPoint(testArchorPoint.layer.anchorPoint));
    
    
//    self.layerView.transform = CGAffineTransformTranslate(self.layerView.transform, 10, 10);
//    self.layerView.layer.geometryFlipped = YES;
//    self.view.transform = CGAffineTransformMakeTranslation(10, 10);
    testArchorPoint.layer.anchorPoint = CGPointMake(0, 0);
//    testArchorPoint.layer.geometryFlipped = YES;
    NSLog(@"After");
    NSLog(@"frame = %@",NSStringFromCGRect(testArchorPoint.layer.frame));
    NSLog(@"bounds = %@",NSStringFromCGRect(testArchorPoint.layer.bounds));
    NSLog(@"position = %@",NSStringFromCGPoint(testArchorPoint.layer.position));
    NSLog(@"archorPoint = %@",NSStringFromCGPoint(testArchorPoint.layer.anchorPoint));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 10);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeRect(ctx, layer.bounds);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //containPoint
    /*
    CGPoint point = [[touches anyObject] locationInView:self.view];
    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.layerView.layer containsPoint:point]) {
        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
        if ([self.blueLayer containsPoint:point]) {
            NSLog(@"点击了蓝色图层");
        } else {
            NSLog(@"点击了白色图层");
        }
    }
     */
    
    //hit test
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CALayer *layer = [self.layerView.layer hitTest:point];
    if (layer == _blueLayer) {
        NSLog(@"点击了蓝色图层");
    } else if(layer == _greenLayer){
        NSLog(@"点击了绿色图层");
    } else {
        NSLog(@"点击了白色图层");
    }
    
}

@end
