//
//  Class2.m
//  MacroTest
//
//  Created by libo on 16/9/26.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "Class2.h"
#import "Class1.h"

extern NSString *lum = @"";
@implementation Class2

+ (void)test {
    NSLog(@"%@",lum);
}

void foo(void) {
    NSLog(@"我答应了");
}
@end
