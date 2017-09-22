//
//  ConfigueViewController.m
//  TextKit_Ex
//
//  Created by plum on 2017/9/22.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "ConfigueViewController.h"

@interface ConfigueViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIView *otherView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;



@end

@implementation ConfigueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSTextStorage *storage = _textView.textStorage;
    
    NSLayoutManager *shareLayoutManager = [NSLayoutManager new];
    [storage addLayoutManager:shareLayoutManager];
    
    NSTextContainer *otherContainer = [NSTextContainer new];
    [shareLayoutManager addTextContainer:otherContainer];
    
    UITextView *otherTextView = [[UITextView alloc] initWithFrame:self.otherView.bounds textContainer:otherContainer];
    otherTextView.backgroundColor = [UIColor grayColor];
    otherTextView.scrollEnabled = NO;
    [_otherView addSubview:otherTextView];
    
    NSTextContainer *thirdContainer = [NSTextContainer new];
    [shareLayoutManager addTextContainer:thirdContainer];
    
    UITextView *thirdTextView = [[UITextView alloc] initWithFrame:self.thirdView.bounds textContainer:thirdContainer];
    thirdTextView.backgroundColor = [UIColor cyanColor];
    [_thirdView addSubview:thirdTextView];
    
    
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
