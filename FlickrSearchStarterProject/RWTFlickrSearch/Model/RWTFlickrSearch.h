//
//  RWTFlickrSearch.h
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/15.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class RWTFlickrSearch;

@protocol RWTFlickrSearch <NSObject>

- (RACSignal *)flickrSearchSignal:(NSString *)searchString;

@end

