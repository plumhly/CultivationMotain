//
//  OtherViewController.m
//  Web_Ex
//
//  Created by plum on 2019/2/21.
//  Copyright © 2019 Tima. All rights reserved.
//

#import "OtherViewController.h"
#import <WebKit/WebKit.h>

@interface OtherViewController () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *wkWeb;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebViewConfiguration *webConfigure = [[WKWebViewConfiguration alloc] init];
    WKPreferences *preference = [[WKPreferences alloc] init];
    preference.minimumFontSize = 20;
    webConfigure.preferences = preference;
    WKUserContentController *userContentController = [WKUserContentController new];
    webConfigure.userContentController = userContentController;
    
    [userContentController addScriptMessageHandler:self name:@"test"];
//    NSString *script = @"function userScript() { window.webkit.messageHandlers.test.postMessage('我填写我的') }";
//    NSString *script = [NSString stringWithFormat:@"function userScript() { window.webkit.messageHandlers.test.postMessage('%@') }", @"我填写的"];
    NSString *script = [NSString stringWithFormat:@"function userScript() { return \"%@\" }", @"我填写的"];
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:script injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    [userContentController addUserScript:userScript];
    _wkWeb = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webConfigure];
    _wkWeb.navigationDelegate = self;
    _wkWeb.UIDelegate = self;
    [self.view addSubview:self.wkWeb];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wkPlum" ofType:@"html"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.wkWeb loadData:data MIMEType:@"text/html" characterEncodingName:@"utf-8" baseURL:[NSBundle mainBundle].bundleURL];
    NSLog(@"");
}

- (void)viewWillDisappear:(BOOL)animated {
    [_wkWeb.configuration.userContentController removeScriptMessageHandlerForName:@"test"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%@", message);
    completionHandler();
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@", message.body);
}

@end
