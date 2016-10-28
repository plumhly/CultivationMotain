//
//  PaletteViewController.m
//  TouchPainter
//
//  Created by libo on 16/10/28.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "PaletteViewController.h"
#import "SetStrokeColorCommandDelegate.h"
#import "SetStrokeColorCommand.h"
#import "CommandSlider.h"

@interface PaletteViewController ()<SetStrokeColorCommandDelegate>


@property (strong, nonatomic) IBOutlet UISlider *redSlider;

@property (strong, nonatomic) IBOutlet UISlider *greenSlider;

@property (strong, nonatomic) IBOutlet UISlider *blueSlider;

@end

@implementation PaletteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark SetStrokeColorCommandDelegate

-(void)command:(SetStrokeColorCommand *)command didFinishUpdateColorWithColor:(UIColor *)color {
    
}

- (void)command:(SetStrokeColorCommand *)command didRequestColorComponentsForRed:(float *)red green:(float *)green blue:(float *)blue {
    *red = [_redSlider value];
    *green = [_greenSlider value];
    *blue = [_blueSlider value];
}


- (IBAction)onCommandSliderValueChanged:(CommandSlider *)sender {
    [sender.command execute];
}


@end
