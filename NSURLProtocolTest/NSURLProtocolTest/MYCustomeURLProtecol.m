//
//  MYCustomeURLProtecol.m
//  NSURLProtocolTest
//
//  Created by libo on 16/10/16.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "MYCustomeURLProtecol.h"

@implementation MYCustomeURLProtecol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([request.URL.scheme caseInsensitiveCompare:@"myapp"] == NSOrderedSame) {
        return YES;
    }
    return NO;
}



+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSLog(@"%@", self.request.URL);
    NSURLResponse *respones = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:@"image/jpeg" expectedContentLength:-1 textEncodingName:nil];
    NSString *stringPath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile:stringPath];
    [self.client URLProtocol:self didReceiveResponse:respones cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading {
    
}

@end
