//
//  MRCClass.m
//  GCDAssist
//
//  Created by plum on 2016/10/18.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "MRCClass.h"

@implementation MRCClass

+ (id)test {
    NSObject *t = [NSObject new];
//    [t release];
    NSUInteger count = [t retainCount];
   
    
    NSLog(@"");
    return [t autorelease];
}

+ (void)test2 {
    NSObject *t = [self test];
    NSUInteger count = [t retainCount];
    NSLog(@"");
}
@end
