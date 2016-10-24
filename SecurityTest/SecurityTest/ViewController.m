//
//  ViewController.m
//  SecurityTest
//
//  Created by plum on 2016/10/19.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self encodeDataUseBase_64];
    [self encryptionDataUsing_MD5];
    [self encryptionDataUsing_SHA1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*base64其实不是安全领域下的加密解密算法。虽然有时候经常看到所谓的base64加密解密。其实base64只能算是一个编码算法，对数据内容进行编码来适合传输。虽然base64编码过后原文也变成不能看到的字符格式，但是这种方式很初级，很简单。*/
//base64
- (void)encodeDataUseBase_64 {
    NSString *pwd = @"libo";
    NSData *data = [[NSData alloc]initWithBase64EncodedString:pwd options:0];
    NSString *getPwd = [[NSString alloc]initWithData:[data base64EncodedDataWithOptions:0] encoding:NSUTF8StringEncoding];
    NSLog(@"");
}

- (void)encryptionDataUsing_MD5 {
    NSString *pwd = @"libo";
   const char *cstr = [pwd UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, strlen(cstr), digest);
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i=0 ; i < CC_MD5_DIGEST_LENGTH; i++) {
        [string appendFormat:@"%02x",digest[i]];
    }
    NSLog(@"");
}


- (void)encryptionDataUsing_SHA1 {
    
    NSString *pwd = @"libo";
    /*
    const char *cstr = [pwd UTF8String];
     */
    const char *cs = [pwd cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cs length:pwd.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
//    CC_SHA1(cstr, strlen(cstr), digest);
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i=0 ; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [string appendFormat:@"%02x",digest[i]];
    }
    NSLog(@"");
}

@end
