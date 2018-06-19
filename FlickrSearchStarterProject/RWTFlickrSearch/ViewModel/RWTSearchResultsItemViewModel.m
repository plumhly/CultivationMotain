//
//  RWTSearchResultsItemViewModel.m
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/19.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsItemViewModel.h"
#import "RWTFlickrPhoto.h"
#import "RWTViewModelServices.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTSearchResultsItemViewModel()
@property (nonatomic, weak) id<RWTViewModelServices> services;
@property (nonatomic, strong) RWTFlickrPhoto *photo;

@end

@implementation RWTSearchResultsItemViewModel

- (instancetype)initWithPhoto:(RWTFlickrPhoto *)photo service:(id<RWTViewModelServices>)services {
    if (self = [super init]) {
        _title = photo.title;
        _url = photo.url;
        _services = services;
        _photo = photo;
//        [self initialize];
    }
    return self;
}


//-  (void)initialize {
//    racs
//}


@end
