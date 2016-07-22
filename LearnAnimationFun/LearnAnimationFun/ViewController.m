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
#import <GLKit/GLKit.h>
#import <OpenGLES/EAGL.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreImage/CoreImage.h>

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

@property (strong, nonatomic) CALayer *colorLayer;


//CAEAGLLayer
@property (strong, nonatomic) EAGLContext *glContext;
@property (strong, nonatomic) CAEAGLLayer *glLayer;
@property (assign, nonatomic) GLuint frameBuffer;
@property (nonatomic, assign) GLuint colorRenderBuffer;
@property (nonatomic, assign) GLint frameBufferHeight;
@property (nonatomic, assign) GLint frameBufferWidth;
@property (strong, nonatomic) GLKBaseEffect *effect;


@property (strong, nonatomic) CALayer *doorLayer;

@property (strong, nonatomic) UIImageView *ballView;

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
//    [self testCAEmitterLayer];
//    [self testCAEAGLLayer];
//    [self testPlayerLayer];
//    [self testColorLayer];
//    [self testPresentLayer];
//    [self testExplicitAnimtion];
//    [self testExplicitAnimtionWithPath];
//    [self testAutoreverses];
//    [self testManualAnimation];
//    [self drawTimingFuncOption];
    [self testBallBounce];
}

- (void)testBallBounceUsingSeparateFrame {
    self.layerView.hidden = self.contentView.hidden = YES;
    self.ballView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Ball"]];
    [self.view addSubview:self.ballView];
    
    self.ballView.center = CGPointMake(150, 32);
    
    
}

float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time {
    if ([fromValue isKindOfClass:[NSValue class]]) {
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}

- (void)testBallBounce {
    self.layerView.hidden = self.contentView.hidden = YES;
    self.ballView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Ball"]];
    [self.view addSubview:self.ballView];
    
   self.ballView.center = CGPointMake(150, 32);
    
    //animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(150, 32)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 140)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 220)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 250)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)]
                         ];
    animation.timingFunctions = @[
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
                                  ];

    animation.duration = 1.0;
    animation.keyPath = @"position";
    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    self.ballView.layer.position = CGPointMake(150, 268);
    [self.ballView.layer addAnimation:animation forKey:@"bounce"];
    
}

- (void)drawTimingFuncOption {
//    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
    float control1[2] = {};
    float control2[2] = {};
    [function getControlPointAtIndex:1 values:(float *)&control1];
    [function getControlPointAtIndex:2 values:(float *)&control2];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint point1 = CGPointMake(control1[0], control1[1]);
    CGPoint point2 = CGPointMake(control2[0], control2[1]);
    [path moveToPoint:CGPointMake(0, 0)];
    [path addCurveToPoint:CGPointMake(1,1) controlPoint1:point1 controlPoint2:point2];
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 4.0;
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.shadowView.layer addSublayer:layer];
    
    self.shadowView.layer.geometryFlipped = YES;//翻转Y轴
}

- (void)testManualAnimation {
    _doorLayer = [CALayer layer];
    _doorLayer.frame = CGRectMake((self.shadowView.frame.size.width - 100 )/2.0, (self.shadowView.frame.size.height - 100 )/2.0, 100, 100);
    _doorLayer.contents = (__bridge id)[UIImage imageNamed:@"Door"].CGImage;
    _doorLayer.anchorPoint = CGPointMake(0, 0);
    _doorLayer.position = CGPointMake(0, 0.5);
    _doorLayer.speed = 0;
    [self.shadowView.layer addSublayer:_doorLayer];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 /500.0;
    self.shadowView.layer.sublayerTransform = transform;
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [self.view addGestureRecognizer:gesture];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.duration = 2;
    animation.toValue = @(-M_PI_2);
    [_doorLayer addAnimation:animation forKey:@"door"];
    
    
}

- (void)pinch:(UIPanGestureRecognizer *)gesture {
    CGFloat x = [gesture translationInView:self.shadowView].x;
    
    x /= 2000.0;
    
    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    self.doorLayer.timeOffset = timeOffset;
    [gesture setTranslation:CGPointZero inView:self.shadowView];
    
}


- (void)testAutoreverses {
    CALayer *doorLayer = [CALayer layer];
    doorLayer.frame = self.shadowView.bounds;
    doorLayer.contents = (__bridge id)[UIImage imageNamed:@"Door"].CGImage;
    doorLayer.anchorPoint = CGPointMake(0, 0);
    doorLayer.position = CGPointMake(0, 0);
    [self.shadowView.layer addSublayer:doorLayer];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 /500.0;
    self.shadowView.layer.sublayerTransform = transform;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.repeatDuration = 5;//repeatCount
//    animation.beginTime = 0.2;
//    animation.autoreverses = YES;
//    animation.fillMode = kCAFillModeBoth;
//    animation.removedOnCompletion = NO;
    animation.duration = 2.0;
    [doorLayer addAnimation:animation forKey:@"door"];
    
    self.shadowView.layer.speed = 0;
}

- (void)testAnimationGroup {
    self.contentView.hidden = self.layerView.hidden = YES;
    //    UIBezierPath *path = [UIBezierPath bezierPath];
    //    [path moveToPoint:CGPointMake(0, 150)];
    //    [path addCurveToPoint:CGPointMake(300, 150)  controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //    //CAShapelayer
    //    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //    shapeLayer.lineWidth = 2;
    //    shapeLayer.path = path.CGPath;
    //    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    //    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    //
    //    [self.view.layer addSublayer:shapeLayer];
    
    //calayer
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 64, 64);
    layer.position = CGPointMake(35, 150);
    layer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    
    [self.view.layer addSublayer:layer];
    //    //animatiom
    //    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    //    animation.keyPath = @"position";
    //    animation.rotationMode = kCAAnimationRotateAutoReverse;
    //    animation.path = path.CGPath;
    //    animation.duration = 4.0;
    //    [layer addAnimation:animation forKey:nil];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    //    animation.byValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 0, 0, 1)];
    //    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0, 0, 1)];
    
    
    [layer addAnimation:animation forKey:nil];
}

- (void)testExplicitAnimtionWithPath {
    self.contentView.hidden = self.layerView.hidden = YES;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 150)];
    [path addCurveToPoint:CGPointMake(300, 150)  controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //CAShapelayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 2;
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    [self.view.layer addSublayer:shapeLayer];
    
    //calayer
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 64, 64);
    layer.position = CGPointMake(35, 150);
//    layer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    layer.backgroundColor = [UIColor greenColor].CGColor;
    
    [self.view.layer addSublayer:layer];
    //animatiom
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    animation.path = path.CGPath;
    animation.duration = 4.0;
    [layer addAnimation:animation forKey:nil];
    
    CABasicAnimation *baseAnimation = [CABasicAnimation animation];
    baseAnimation.keyPath = @"backgroundColor";
    baseAnimation.duration = 2.0;
    baseAnimation.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 4.0;
    animationGroup.animations = @[animation, baseAnimation];
    [layer addAnimation:animationGroup forKey:@"group"];
    
    
}

- (void)testExplicitAnimtion {
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.shadowView.layer addSublayer:self.colorLayer];
}

- (void)testPresentLayer{
    self.contentView.hidden = self.layerView.hidden = YES;
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.width / 2);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        //randomize the layer background color
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.4];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}

- (void)testColorLayer {
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = self.shadowView.bounds;
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    
    
//    CATransition *transition  = [CATransition animation];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromLeft;
//    self.colorLayer.actions = @{@"backgroundColor": transition};
//    NSDictionary *dic = self.colorLayer.style;
    
    [self.shadowView.layer addSublayer:self.colorLayer];
    
    //test
//    NSLog(@"OutBlock %@",[self.shadowView actionForLayer:self.shadowView.layer forKey:@"backgroundColor"]);
//    
//    //begin animation
//    [UIView beginAnimations:nil context:NULL];
//    NSLog(@"inBlock %@",[self.shadowView actionForLayer:self.shadowView.layer forKey:@"backgroundColor"]);
//    [UIView commitAnimations];
}

- (IBAction)buttonClick:(id)sender {
    /*
//    [CATransaction begin];
//    [UIView beginAnimations:nil context:NULL];
//    CFTimeInterval interval = 1.0;
//    [CATransaction setAnimationDuration:interval];
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//    [UIView commitAnimations];
//    [CATransaction commit];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.delegate = self;
    animation.toValue = (__bridge id)color.CGColor;
    
    [self.colorLayer addAnimation:animation forKey:nil];
    */
    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"backgroundColor";
//    animation.values = @[(__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
//    animation.duration = 2.0;
//    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [self.colorLayer addAnimation:animation forKey:nil];
    
    //1.test CATransition

//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionFade;
//    [self.leftView.layer addAnimation:transition forKey:nil];
//    
//    self.leftView.image  = [UIImage imageNamed:@"Ship"];
//
    //2.用UIViwe的过渡效果
//    [UIView transitionWithView:self.leftView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        self.leftView.image  = [UIImage imageNamed:@"Ship"];
//    } completion:^(BOOL finished) {
//        
//    }];
    
    //3.自定义动画
    /*
    UIGraphicsBeginImageContextWithOptions(self.layerView.bounds.size, YES, 0);
    [self.layerView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = self.layerView.bounds;
    [self.layerView addSubview:imageView];
    
    //update the view (we'll simply randomize the layer background color)
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.layerView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    
    //perform animation (anything you like)
    [UIView animateWithDuration:1.0 animations:^{
        //scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        imageView.transform = transform;
        imageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        //remove the cover view now we're finished with it
        [imageView removeFromSuperview];
    }];
     */
    
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag; {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    
    [CATransaction commit];
}

- (void)testPlayerLayer {
    /*
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Ship" withExtension:@"mp4"];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.shadowView.bounds;
    [self.shadowView.layer addSublayer:playerLayer];
    [player play];
    
    */
    
    //结合transform3d
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Ship" withExtension:@"mp4"];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(0, 0, 100, 100);
    playerLayer.borderWidth = 10;
    playerLayer.borderColor = [UIColor redColor].CGColor;
    
    CATransform3D trandform = CATransform3DIdentity;
    trandform = CATransform3DRotate(trandform, M_PI_4, 1, 1, 0);
    trandform.m34 = -1 / 500.0;
    playerLayer.transform = trandform;
    playerLayer.masksToBounds = YES;
    [self.shadowView.layer addSublayer:playerLayer];
    [player play];
    
}

- (void)setUpBuffer {
    //set up frame buffer
    glGenFramebuffers(1, &_frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
    
    //set up color render buffer
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
    [self.glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.glLayer];
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_frameBufferWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_frameBufferHeight);
    
    //check success
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
    {
        NSLog(@"Failed to make complete framebuffer object: %i", glCheckFramebufferStatus(GL_FRAMEBUFFER));
    }
}

- (void)tearDownBuffer {
    if (_frameBuffer) {
        glDeleteFramebuffers(1, &_frameBuffer);
        _frameBuffer = 0;
    }
    if (_colorRenderBuffer) {
        glDeleteRenderbuffers(1, &_colorRenderBuffer);
        _colorRenderBuffer = 0;
    }
}

- (void)drawFrame {
    //bind framebuffer & set viewport
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
    glViewport(0, 0, _frameBufferWidth, _frameBufferHeight);
    
    //bind shader program
    [self.effect prepareToDraw];
    
    //clear the screen
    glClear(GL_COLOR_BUFFER_BIT); glClearColor(0.0, 0.0, 0.0, 1.0);
    
    //set up vertices
    GLfloat vertices[] = {
        -0.5f, -0.5f, -1.0f, 0.0f, 0.5f, -1.0f, 0.5f, -0.5f, -1.0f,
    };
    
    //set up colors
    GLfloat colors[] = {
        0.0f, 0.0f, 1.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f, 1.0f, 0.0f, 0.0f, 1.0f,
    };
    
    //draw triangle
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, vertices);
    glVertexAttribPointer(GLKVertexAttribColor,4, GL_FLOAT, GL_FALSE, 0, colors);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
    //present render buffer
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [self.glContext presentRenderbuffer:GL_RENDERBUFFER];

}

- (void)testCAEAGLLayer {
    self.glContext = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.glContext];
    
     //set up layer
    self.glLayer = [CAEAGLLayer layer];
    self.glLayer.frame = self.shadowView.bounds;
    [self.shadowView.layer addSublayer:self.glLayer];
    self.glLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking:@NO ,kEAGLDrawablePropertyColorFormat:kEAGLColorFormatRGBA8};
    
    //set up base effect
    self.effect = [[GLKBaseEffect alloc] init];
    
    //set up buffers
    [self setUpBuffer];
    
    //draw frame
    [self drawFrame];
}

- (void)dealloc
{
    [self tearDownBuffer];
    [EAGLContext setCurrentContext:nil];
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
