//
//  RWTFlickrSearchResults.h
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/15.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrSearchResults : NSObject

@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign) NSUInteger totalResults;


@end
