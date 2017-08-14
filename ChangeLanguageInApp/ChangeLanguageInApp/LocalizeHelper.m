//
//  LocalizeHelper.m
//  test
//
//  Created by plum on 2017/8/14.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "LocalizeHelper.h"


static LocalizeHelper *_helper = nil;
static NSBundle *myBoundle = nil;

@implementation LocalizeHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _helper = [LocalizeHelper new];
        myBoundle = [NSBundle mainBundle];
    });
    return _helper;
}

- (NSString *)localizedStringForKey:(NSString *)key {
    return [myBoundle localizedStringForKey:key value:@"" table:nil];
}

- (void)setNewLanguage:(NSString *)language {
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    if (path) {
        myBoundle = [NSBundle bundleWithPath:path];
    }
    
    if (!myBoundle) {
        myBoundle = [NSBundle mainBundle];
    }
}




@end
