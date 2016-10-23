//
//  ViewController.m
//  SecurityTest
//
//  Created by plum on 2016/10/19.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>
#import <Security/Security.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self encodeDataUseBase_64];
//    [self encryptionDataUsing_MD5];
    [self keychainTest];
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

- (void)keychainTest {
    
    // add
    NSMutableDictionary *keyItem = [NSMutableDictionary dictionary];
    
    NSString *username = @"libo";
    NSString *password = @"mitlibo";
    
    keyItem[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    keyItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleWhenUnlocked;
    keyItem[(__bridge id)kSecAttrAccount] = username;

    //return the encrypted data and store it in a CFDataRef object
    keyItem [(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    
    //return a dictionary, that is, a CFDictionaryRef.
    keyItem [(__bridge id)kSecReturnAttributes] = (__bridge id)kCFBooleanTrue;
    //是否已经存在
    
//    CFDataRef result = nil;
    CFDictionaryRef result = nil;
    
    //如果没有设置 kSecReturnAttributes  那么返回的是CFDataRef
//    OSStatus sts = SecItemCopyMatching((__bridge CFDictionaryRef) keyItem, (CFTypeRef *)&result);
    
    // 如果设置 kSecReturnAttributes
    OSStatus sts = SecItemCopyMatching((__bridge CFDictionaryRef) keyItem, (CFTypeRef *)&result);
    
    
    if (sts == noErr) {
        
        //1.updata
        /*
        NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
        attribute [(__bridge id)kSecValueData] = [password dataUsingEncoding:NSUTF8StringEncoding];
        OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)keyItem, (__bridge CFDictionaryRef)attribute);
         */
        
        //2.get password
        /*
//        NSData *passwordData = (__bridge_transfer NSData*)result;
        NSDictionary *dic = (__bridge_transfer NSDictionary*)result;
        NSData *passwordData = dic[(__bridge id)kSecValueData];
        NSString *pwd = [[NSString alloc]initWithData:passwordData encoding:NSUTF8StringEncoding];
         */
        
        //3.delete
        OSStatus status = SecItemDelete((__bridge CFDictionaryRef)keyItem);
        
        NSLog(@"");
        
    } else {
        keyItem [(__bridge id)kSecValueData] = [password dataUsingEncoding:NSUTF8StringEncoding];
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)keyItem, NULL);
        NSLog(@"%d",status);
    }
}

@end
