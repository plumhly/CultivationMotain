//
//  RWTViewModelServices.h
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/15.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RWTFlickrSearch;

@protocol RWTViewModelServices <NSObject>

- (id<RWTFlickrSearch>) getFlickrSearchService;
- (void)pushViewModel:(id)viewModel;
@end
