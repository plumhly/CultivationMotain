//
//  ViewController.m
//  LearnAnimationFun
//
//  Created by libo on 16/7/12.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "LayerLabel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;

@property (weak, nonatomic) IBOutlet UIView *shadowView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

//test sublayerTransform

@property (weak, nonatomic) IBOutlet UIImageView *leftView;

@property (weak, nonatomic) IBOutlet UIImageView *rightView;

@property (strong, nonatomic) CALayer *blueLayer;
@property (strong, nonatomic) CALayer *greenLayer;

@property (strong, nonatomic) CAScrollLayer *scrollLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CALayer *subLayer = [CALayer layer];
//    subLayer.frame = CGRectMake(0, 0, 240, 130);
//    subLayer.backgroundColor = [UIColor redColor].CGColor;
//    [self.layerView.layer addSublayer:subLayer];
    
//    UIImage *image = [UIImage imageNamed:@"Cone"];
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
//    [self testShadow];
//    [self testMask];
//    [self testOpacity];
//    [self testAffineTransiform];
//    [self testCATransform3D];
//    [self testRrawPictureUsingCAShapeLayer];UIFont
//    [self testTextUsingCATextLayer];
//    [self testLayerLabel];
//    [self testTransformLayer];
//    [self testGradientLayer];
//    [self testReplictorLayer];
//    [self testCAScrollLayer];
    [self testCAEmitterLayer];
}

- (void)testCAEmitterLayer {
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = self.shadowView.bounds;
    [self.shadowView.layer addSublayer:emitterLayer];
    
    emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    emitterLayer.emitterPosition = CGPointMake(emitterLayer.frame.size.width / 2.0, emitterLayer.frame.size.height / 2.0);
//    emitterLayer.duration = 20;
//    emitterLayer.preservesDepth = NO;
    
    CAEmitterCell *emitterCell = [[CAEmitterCell alloc]init];
    emitterCell.scale = [UIScreen mainScreen].scale;
    emitterCell.contents = (__bridge id)[UIImage imageNamed:@"Spark"].CGImage;
    emitterCell.birthRate = 150;//每秒产生的spark数量
    emitterCell.lifetime = 5.0; //持续时间
    emitterCell.color = [UIColor redColor].CGColor;
    emitterCell.alphaSpeed = -0.4;
    emitterCell.velocity = 50;
//    emitterCell.repeatDuration = 20;
    emitterCell.repeatCount = 1;
    emitterCell.emissionRange = M_PI * 2;//发射的角度
//    emitterCell.emissionLatitude = 100;//发射的z轴方向的角度
//    emitterCell.emissionLongitude = 90;
//    emitterCell.xAcceleration = 100;
//    emitterCell.yAcceleration = 100;
//    emitterCell.zAcceleration = 100;
    emitterLayer.emitterCells = @[emitterCell];
    
    
}

- (void)testCAScrollLayer {
    _scrollLayer = [CAScrollLayer layer];
//    _scrollLayer.contents = (__bridge id)[UIImage imageNamed:@"Snowmanbig"].CGImage;
    _scrollLayer.frame = self.shadowView.bounds;
    [self.shadowView.layer addSublayer:_scrollLayer];
    
    CALayer *layer = [CALayer layer];
    layer.contents = (__bridge id)[UIImage imageNamed:@"Snowmanbig"].CGImage;
    layer.frame = CGRectMake(-100, -100, 600, 480);
    [_scrollLayer addSublayer:layer];
    
    UIPanGestureRecognizer *recognizer = nil;
    recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.shadowView addGestureRecognizer:recognizer];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer
{
    //get the offset by subtracting the pan gesture
    //translation from the current bounds origin
    CGPoint offset = self.shadowView.bounds.origin;
    offset.x -= [recognizer translationInView:self.shadowView].x;
    offset.y -= [recognizer translationInView:self.shadowView].y;
    
    //scroll the layer
    [self.scrollLayer scrollToPoint:offset];
    
    //reset the pan gesture translation
//    [recognizer setTranslation:CGPointZero inView:self.shadowView];
}

- (void)testReplictorLayer {
    /*
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.shadowView.bounds;
    [self.shadowView.layer addSublayer:replicatorLayer];
//    self.shadowView.layer.position = CGPointMake(0, 0);
    replicatorLayer.instanceCount = 3;
//    replicatorLayer.instanceColor =
    replicatorLayer.instanceRedOffset = -0.1;
    replicatorLayer.instanceBlueOffset = -0.1;
    CGPoint center = self.shadowView.center;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 0, 0);
    transform = CATransform3DRotate(transform, M_PI / 3.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, 0, 0);
    replicatorLayer.instanceTransform = transform;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 0, 50, 50);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [replicatorLayer addSublayer:layer];
    */
    //反射
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.shadowView.bounds;
    [self.shadowView.layer addSublayer:replicatorLayer];
    //    self.shadowView.layer.position = CGPointMake(0, 0);
    replicatorLayer.instanceCount = 2;
    //    replicatorLayer.instanceColor =
    replicatorLayer.instanceAlphaOffset = -0.6;
    CATransform3D transform = CATransform3DIdentity;
//    transform = CATransform3DTranslate(transform, 0, 52, 0);
//    transform = CATransform3DRotate(transform, M_PI / 3.0, 0, 0, 1);
    transform = CATransform3DScale(transform, 1, -1, 0);
    replicatorLayer.instanceTransform = transform;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(130, 100, 40, 40);
    layer.contents = (__bridge id)[UIImage imageNamed:@"Cone"].CGImage;
    [replicatorLayer addSublayer:layer];
    
}

- (void)testGradientLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.shadowView.bounds;
    [self.shadowView.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    gradientLayer.locations = @[@(0), @(0.2), @(0.5)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
}

- (CALayer *)faceWithTransform:(CATransform3D)transform {
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
     //apply a random color
    CGFloat red = rand() / (double)INT_MAX;
    CGFloat green = rand() / (double)INT_MAX;
    CGFloat blue = rand() / (double)INT_MAX;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    face.backgroundColor = color.CGColor;
    face.transform = transform;
    return face;
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform {
    //create cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //center
    cube.position = CGPointMake(self.shadowView.frame.size.width / 2.0, self.shadowView.frame.size.height / 2.0);
    cube.transform = transform;
    return cube;
}

- (void)testTransformLayer {
    /*
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 500.0;
    self.layerView.layer.sublayerTransform = transform;
    
    //cube1
    CATransform3D ct1 = CATransform3DIdentity;
    ct1 = CATransform3DTranslate(ct1, -50, 0, 0);
    ct1 = CATransform3DRotate(ct1, -M_PI_4, 0, 1, 0);
    [self.shadowView.layer addSublayer:[self cubeWithTransform:ct1]];
    
    //cube1
    CATransform3D ct2 = CATransform3DIdentity;
    ct2 = CATransform3DTranslate(ct2, 100, 0, 0);
    ct2 = CATransform3DRotate(ct2, -M_PI_4, 1, 0, 0);
    ct2 = CATransform3DRotate(ct2, -M_PI_4, 0, 1, 0);
    [self.shadowView.layer addSublayer:[self cubeWithTransform:ct2]];
    */
    
    CATransformLayer *layer = [CATransformLayer layer];
    layer.frame = CGRectMake(0, 0, 300, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.shadowView.layer addSublayer:layer];
    
    
}

- (void)testLayerLabel {
    LayerLabel  *layLable = [[LayerLabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    layLable.text = @"哈哈";
    layLable.textColor = [UIColor redColor];
    [self.shadowView addSubview:layLable];
}

- (void)testTextUsingCATextLayer {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.layerView.bounds;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.wrapped = YES;
    UIFont *font = [UIFont systemFontOfSize:18];
    CFStringRef fontstring = (__bridge CFStringRef)font.fontName;
//    CGFontRef fontRef = CGFontCreateWithFontName(fontstring);
    CTFontRef fontRef = CTFontCreateWithName(fontstring, 18, NULL);
    textLayer.fontSize = font.pointSize;
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    textLayer.font = fontRef;

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:text];
    //using attribute
    //用KCT 不用 NS是因为假象系统在6.0以前。
    NSDictionary *dic = @{(__bridge id)kCTForegroundColorAttributeName :[UIColor blackColor],
                          (__bridge id)kCTFontAttributeName : (__bridge id)fontRef};
    
    [string setAttributes:dic range:NSMakeRange(0, text.length)];

    NSDictionary *dic2 = @{(__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor redColor].CGColor,
                          (__bridge id)kCTUnderlineStyleAttributeName : @(kCTUnderlineStyleSingle),
                          (__bridge id)kCTUnderlineColorAttributeName : [UIColor redColor] };
    
    [string setAttributes:dic2 range:NSMakeRange(6, 5)];
    //    textLayer.string = text;
    textLayer.string = string;
    
    textLayer.contentsScale = [UIScreen mainScreen].scale;//contentsScale默认为1.0，不写这个会有模糊的问题
    [self.shadowView.layer addSublayer:textLayer];
    
}


- (void)testRrawPictureUsingCAShapeLayer {
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    [path moveToPoint:CGPointMake(175, 100)];
//    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(150, 125)];
//    [path addLineToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(125, 225)];
//    [path moveToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(175, 225)];
//    [path moveToPoint:CGPointMake(100, 150)];
//    [path addLineToPoint:CGPointMake(200, 150)];
    
    //单独添加圆角
    UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerBottomRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) byRoundingCorners:corner cornerRadii:CGSizeMake(20, 20)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 10;
    shapeLayer.path = path.CGPath;
    [self.shadowView.layer addSublayer:shapeLayer];
}

- (void)testCATransform3D {
    _shadowView.layer.contents = (__bridge id)[UIImage imageNamed:@"Snowman"].CGImage;
    
    CATransform3D transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    
    //透视
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = -1/500.0;
    
//    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    
    
    _shadowView.layer.doubleSided = NO;//是否双面绘制
    _shadowView.layer.transform = transform;
    
    // sublayerTransform
    
//    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
//    self.leftView.layer.transform = transform1;
//    
//    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
//    self.rightView.layer.transform = transform2;
    
    //扁平化
    
}


- (void)testAffineTransiform {
    _shadowView.layer.contents = (__bridge id)[UIImage imageNamed:@"Snowman"].CGImage;
    
    //one way
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI / 6);
    transform = CGAffineTransformTranslate(transform, 100, 0);
    transform = CGAffineTransformScale(transform, 0.2, 0.2);
    
    
    //other way
//    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI / 6);
//    transform = CGAffineTransformScale(transform, 0.2, 0.2);
//    transform = CGAffineTransformConcat(transform, CGAffineTransformMakeTranslation(100, 0));
    
    _shadowView.layer.affineTransform = transform;
    
//    _shadowView.layer.transform = CATransform3DMakeRotation(M_PI_4, -1, -1, 5);
}


- (void)testOpacity {
    _blueLayer = [CALayer layer];
    _blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    _blueLayer.frame = CGRectMake(10, 10, 100, 100);
    [_shadowView.layer addSublayer:_blueLayer];
    
    _greenLayer = [CALayer layer];
    _greenLayer.backgroundColor = [UIColor greenColor].CGColor;
    _greenLayer.frame = CGRectMake(0, 0, 50, 50);
    [_blueLayer addSublayer:_greenLayer];
    _blueLayer.opacity = 0.5;
    _greenLayer.opacity = 0.5;
    _blueLayer.shouldRasterize = YES;
    _blueLayer.rasterizationScale = [UIScreen mainScreen].scale;
    
//    _shadowView.layer.opacity = 0.5;
}

- (void)testMask {
    UIImage *image = [UIImage imageNamed:@"Igloo"];
    self.shadowView.layer.contents = (__bridge id)image.CGImage;
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contents = (__bridge id)[UIImage imageNamed:@"Cone"].CGImage;
    maskLayer.frame = self.shadowView.bounds;
    
    self.shadowView.layer.mask = maskLayer;
    
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
    /*
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
    testArchorPoint.layer.frame = CGRectMake(20, 10, 40, 50);
//    testArchorPoint.layer.geometryFlipped = YES;
    NSLog(@"After");
    NSLog(@"frame = %@",NSStringFromCGRect(testArchorPoint.layer.frame));
    NSLog(@"bounds = %@",NSStringFromCGRect(testArchorPoint.layer.bounds));
    NSLog(@"position = %@",NSStringFromCGPoint(testArchorPoint.layer.position));
    NSLog(@"archorPoint = %@",NSStringFromCGPoint(testArchorPoint.layer.anchorPoint));
    */
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.frame = CGRectMake(0, 0, 40, 50);
    [self.shadowView.layer addSublayer:layer];
    
    NSLog(@"frame = %@",NSStringFromCGRect(layer.frame));
    NSLog(@"bounds = %@",NSStringFromCGRect(layer.bounds));
    NSLog(@"position = %@",NSStringFromCGPoint(layer.position));
    NSLog(@"archorPoint = %@",NSStringFromCGPoint(layer.anchorPoint));
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

/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //containPoint
 
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
*/
@end
