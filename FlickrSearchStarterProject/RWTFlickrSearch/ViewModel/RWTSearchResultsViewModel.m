//
//  RWTSearchResultsViewModel.m
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/15.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewModel.h"


@implementation RWTSearchResultsViewModel

- (instancetype)initWithSearchResults:(RWTFlickrSearchResults *)results services:(id<RWTViewModelServices>)servicesf {
    if (self = [super init]) {
        _title = results.searchString;
        _searchResults = results.photos;
    }
    return self;
}

@end
