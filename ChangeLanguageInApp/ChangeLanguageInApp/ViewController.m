//
//  ViewController.m
//  test
//
//  Created by plum on 2017/8/14.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "ViewController.h"
#import "LocalizeHelper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LocalizationSetLanguage(@"zh-Hans");
    self.lable.text = LocalizedString(@"plum");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cick:(id)sender {
    LocalizationSetLanguage(@"en");
    self.lable.text = LocalizedString(@"plum");
}


@end
