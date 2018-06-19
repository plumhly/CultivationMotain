//
//  RWTSearchResultsItemViewModel.h
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/19.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWTFlickrPhoto;
@protocol RWTViewModelServices;

@interface RWTSearchResultsItemViewModel : NSObject

- (instancetype)initWithPhoto:(RWTFlickrPhoto *)photo service:(id<RWTViewModelServices>)services;

@property (nonatomic, assign) BOOL isVisible;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSNumber *favorites;
@property (nonatomic, strong) NSNumber *comments;


@end
