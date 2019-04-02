//
//  ViewController.m
//  Web_Ex
//
//  Created by plum on 2019/2/20.
//  Copyright © 2019 Tima. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface ViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"plum" ofType:@"html"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:[NSBundle mainBundle].bundleURL];
    
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // Native -> Js
    /*1*/
//    NSString *d = [webView stringByEvaluatingJavaScriptFromString:@"getName()"];
    
    NSString *func = @"function age() { return 21 } ; age();";
    [webView stringByEvaluatingJavaScriptFromString:func];
    NSString *d = [webView stringByEvaluatingJavaScriptFromString:func];
    NSLog(@"%@", d);
    
    /*2*/
//    JSValue *jsVal = [context evaluateScript:@"getName()"];
//    NSLog(@"%@", jsVal.toString);
    
    /*3*/
//    JSValue *value = [context objectForKeyedSubscript:@"makeAltert"];
//    JSValue *value = context[@"makeAltert"];
//    [value callWithArguments:@[@"hi"]];

    // js -> Native
//    context[@"plum"] = ^(NSString *name) {
//        NSLog(@"%@", name);
//    };
}


@end
