//
//  RWTFlickrPhoto.h
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/15.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrPhoto : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *identifier;

@end
