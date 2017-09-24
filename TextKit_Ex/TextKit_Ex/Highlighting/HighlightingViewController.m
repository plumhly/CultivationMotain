//
//  HighlightingViewController.m
//  TextKit_Ex
//
//  Created by Plum on 2017/9/23.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "HighlightingViewController.h"
#import "PLTextStore.h"

@interface HighlightingViewController (){
    PLTextStore *_store;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCS;

@end

@implementation HighlightingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _store = [[PLTextStore alloc] init];
    
    [_store addLayoutManager:_textView.layoutManager];
    [_store replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"iText" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - Keyboard status

- (void)keyboardWillShowOrHide:(NSNotification *)notification
{
    CGFloat newInset;
    if ([notification.name isEqualToString: UIKeyboardWillShowNotification])
        newInset = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    else
        newInset = 20;
    
    [self.bottomCS setConstant: newInset];
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
