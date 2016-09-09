//
//  ViewController.m
//  CoreImageFun
//
//  Created by plum on 16/9/2.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>
#import <OpenGLES/EAGL.h>
#import <ImageIO/ImageIO.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self findEyes];
    
    
    
//    self setsour
    
}

- (void)findEyes {
    CIContext *context = [CIContext contextWithOptions:nil];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"我" ofType:@"png"];
    CIImage *image = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:path]];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray *array = [detector featuresInImage:image options:@{CIDetectorImageOrientation:@1}];
    CIFaceFeature *face = array.firstObject;
    CGPoint letfEyePositon = face.leftEyePosition;
    CGPoint rightEyePositon = face.rightEyePosition;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(letfEyePositon.x, 101 - letfEyePositon.y, 10, 10)];
    view.backgroundColor = [UIColor redColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我"]];
    [self.view addSubview:imageView];
    
    [imageView addSubview:view];
    
}

- (void)beginLearn {
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"狗儿" ofType:@"png"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    //    UIImage *aimage = [UIImage imageNamed:@"狗儿.png"];//内部使用的cgimage实现
    CIImage *image = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:path]];
    CIFilter *filter = [CIFilter filterWithName:@"CIHueAdjust"];
    //    CIFilter *filter = [CIFilter filterWithName:@"" withInputParameters:@{kCIInputImageKey : image, kCIInputAngleKey : @3.14f}];
    //    [filter setDefaults];
    [CIFilter filterNamesInCategory:@""];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@3.14f forKey:kCIInputAngleKey];
    CIImage *outPutImage1 = [filter valueForKey:kCIOutputImageKey];
    
    //gloomFilter
    CIFilter *gloom = [CIFilter filterWithName:@"CIGloom" withInputParameters:@{kCIInputImageKey : outPutImage1, kCIInputIntensityKey : @0.75f, kCIInputRadiusKey : @25}];
    CIImage *outPutImage2 = [gloom valueForKey:kCIOutputImageKey];
    
    //bumpDistortionFilter
    CIFilter *bumpDistortion = [CIFilter filterWithName:@"CIBumpDistortion" withInputParameters:@{kCIInputCenterKey : [CIVector vectorWithCGPoint:CGPointMake(190, 300)], kCIInputRadiusKey : @200, kCIInputScaleKey : @2, kCIInputImageKey : outPutImage2}];
    
    
    CIImage *outPutImage = [bumpDistortion valueForKey:kCIOutputImageKey];
    
    CGRect rect = outPutImage.extent;
    CGImageRef imageRef = [context createCGImage:outPutImage fromRect:rect];
    
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    _imageView.image = resultImage;
    NSLog(@"");
    
    //real time
    EAGLContext *eaglContext = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    CIContext *ciContext = [CIContext contextWithEAGLContext:eaglContext];
    
    NSDictionary *option = @{kCIContextWorkingColorSpace : [NSNull null]};
    CIContext *ciContext1 = [CIContext contextWithEAGLContext:eaglContext options:option];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
