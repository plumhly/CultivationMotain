//
//  RWTFlickrSearchViewModel.h
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/15.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand;
@protocol RWTViewModelServices;

@interface RWTFlickrSearchViewModel : NSObject

@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) RACCommand *executeSearch;


- (instancetype)initWithServices:(id<RWTViewModelServices>)service;
@end
