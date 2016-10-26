//
//  CanvasViewController.m
//  TouchPainter
//
//  Created by plum on 2016/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "CanvasViewController.h"
#import "CanvasViewGenerator.h"
#import "CanvasView.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCanvasView];
}

- (void)loadCanvasView {
    [_canvasView removeFromSuperview];
    _canvasView = [CanvasViewGenerator canvasViewWithFrame:self.view.bounds];
    [self.view addSubview:_canvasView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
