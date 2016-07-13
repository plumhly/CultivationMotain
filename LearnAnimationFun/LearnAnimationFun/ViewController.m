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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CALayer *subLayer = [CALayer layer];
//    subLayer.frame = CGRectMake(0, 0, 240, 130);
//    subLayer.backgroundColor = [UIColor redColor].CGColor;
//    [self.layerView.layer addSublayer:subLayer];
    
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    self.layerView.layer.contents = (__bridge id)image.CGImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
