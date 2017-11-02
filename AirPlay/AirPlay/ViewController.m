//
//  ViewController.m
//  AirPlay
//
//  Created by plum on 2017/8/11.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *baseUrl = [NSURL URLWithString:@"http://example.com/v1/"];
    
    /*http://example.com/v1/foo*/
    NSURL *url1 = [NSURL URLWithString:@"foo" relativeToURL:baseUrl];
    
    /*http://example.com/v1/foo?bar=baz*/
    NSURL *url2 = [NSURL URLWithString:@"foo?bar=baz" relativeToURL:baseUrl];
    
    /*http://example.com/v1/foo/*/
    NSURL *url3 = [NSURL URLWithString:@"foo/" relativeToURL:baseUrl];
    
    /*http://example.com/foo*/
    NSURL *url4 = [NSURL URLWithString:@"/foo" relativeToURL:baseUrl];
    
    /*http://example.com/foo/*/
    NSURL *url5 = [NSURL URLWithString:@"/foo/" relativeToURL:baseUrl];
    
    /*http://example.com/v1/foo*/
    NSURL *url6 = [NSURL URLWithString:@"http://example2.com" relativeToURL:baseUrl];
    
    NSURLRequest *reqyest = [NSURLRequest requestWithURL:url2];
    
    NSLog(@"");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
