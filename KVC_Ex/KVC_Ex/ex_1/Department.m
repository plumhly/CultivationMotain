//
//  Department.m
//  KVC_Ex
//
//  Created by plum on 2018/3/21.
//  Copyright © 2018年 plum. All rights reserved.
//

#import "Department.h"

@implementation Department

- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"setNilValueForKey");
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"forUndefinedKey");
}

@end
