//
//  BridgeViewController.m
//  Web_Ex
//
//  Created by plum on 2019/2/21.
//  Copyright © 2019 Tima. All rights reserved.
//

#import "BridgeViewController.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface BridgeViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation BridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bridge" ofType:@"html"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:[NSBundle mainBundle].bundleURL];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
    [_bridge registerHandler:@"js call oc" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@", data);
        responseCallback(@"----hello----");
    }];
    
}


- (IBAction)ocCallJs:(id)sender {
    [_bridge callHandler:@"oc call js"];
    [_bridge callHandler:@"oc call js" data:@"hi, js" responseCallback:^(id responseData) {
        NSLog(@"%@", responseData);
    }];
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
