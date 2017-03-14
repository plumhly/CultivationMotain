//
//  ViewController.m
//  Socket_Client
//
//  Created by libo on 2017/3/14.
//  Copyright © 2017年 libo. All rights reserved.
//

#import "ViewController.h"
#import "HotGameViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hotAGame:(id)sender {
    HotGameViewController *game = [HotGameViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:game];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (IBAction)jonAGame:(id)sender {
    
}



@end
