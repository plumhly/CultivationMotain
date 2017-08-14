//
//  LocalizeHelper.h
//  test
//
//  Created by plum on 2017/8/14.
//  Copyright © 2017年 plum. All rights reserved.
//

#import <Foundation/Foundation.h>


#define LocalizedString(key) [[LocalizeHelper sharedInstance] localizedStringForKey:key]

#define LocalizationSetLanguage(language) [[LocalizeHelper sharedInstance] setNewLanguage:language]

@interface LocalizeHelper : NSObject

+ (instancetype)sharedInstance;

- (NSString *)localizedStringForKey:(NSString *)key;

- (void)setNewLanguage:(NSString *)language;

@end
