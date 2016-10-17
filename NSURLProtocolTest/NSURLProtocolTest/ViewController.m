//
//  ViewController.m
//  NSURLProtocolTest
//
//  Created by libo on 16/10/16.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "ViewController.h"
#import "MYCustomeURLProtecol.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [NSURLProtocol registerClass:[MYCustomeURLProtecol class]];
    NSString * localHtmlFilePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"html"];
    
    NSString * localHtmlFileURL = [NSString stringWithFormat:@"file://%@", localHtmlFilePath];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:localHtmlFileURL]]];
    NSString *html = [NSString stringWithContentsOfFile:localHtmlFilePath encoding:NSUTF8StringEncoding error:nil];
    
    [_webView loadHTMLString:html baseURL:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
