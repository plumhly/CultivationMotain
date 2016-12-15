//
//  NSConnectionTestTrust.m
//  HTTPS_Test
//
//  Created by libo on 2016/12/1.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "NSConnectionTestTrust.h"
#import <Security/Security.h>

@interface NSConnectionTestTrust ()<NSURLConnectionDelegate>

@property (strong, nonatomic) NSURLConnection *connection;

@property (strong, nonatomic) NSArray *data;

@end

@implementation NSConnectionTestTrust

#pragma mark - 1 本地没有证书
#pragma mark -

- (void)loadData {
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    //获取trust object
    SecTrustRef trustRef = challenge.protectionSpace.serverTrust;
    SecTrustResultType result;
    
    /* ---------------------2-------------------------
     //注意：这里将之前导入的证书设置成下面验证的Trust Object的anchor certificat
     SecTrustSetAnchorCertificates(trustRef, (__bridge CFArrayRef)self.data);
     
     */
    
    
    //SecTrustEvaluate对trust进行验证
    OSStatus status = SecTrustEvaluate(trustRef, &result);
    if (status == errSecSuccess && (result == kSecTrustResultProceed | result == kSecTrustResultUnspecified)) {
        
        //3)验证成功，生成NSURLCredential凭证cred，告知challenge的sender使用这个凭证来继续连接
        NSURLCredential *cred = [NSURLCredential credentialForTrust:trustRef];
        [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
    } else {
        //5)验证失败，取消这次验证流程
        [challenge.sender cancelAuthenticationChallenge:challenge];
    }
    
    NSLog(@"");
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

#pragma mark - 2本地有证书
#pragma mark -

- (void)loadDataWithHaveCredential {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"" ofType:@"cer"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    SecCertificateRef certificate = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)data);
    self.data = @[CFBridgingRelease(certificate)];
    
}



@end
