//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/15.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTViewModelServices.h"
#import "RWTFlickrSearch.h"
#import "RWTSearchResultsViewModel.h"

@interface RWTFlickrSearchViewModel()
@property (nonatomic, weak) id <RWTViewModelServices> services;

@end

@implementation RWTFlickrSearchViewModel

- (instancetype)init {
    if (self = [super init]) {
        _title = @"Flickr Search";
//        _searchText = @"search text";
        RACSignal *validate = [[RACObserve(self,searchText) map:^id(id value) {
            return @([value length] > 3);
        }]distinctUntilChanged] ;
        [validate subscribeNext:^(id x) {
             NSLog(@"search text is valid %@", x);
        } error:^(NSError *error) {
            NSLog(@"error");
        } completed:^{
            NSLog(@"completed");
        }];
        
        self.executeSearch = [[RACCommand alloc] initWithEnabled:validate signalBlock:^RACSignal *(id input) {
            return [self executeSearchSignal];
        }];
    }
    return self;
}

- (instancetype)initWithServices:(id<RWTViewModelServices>)service {
    self = [self init];
    self.services = service;
    return self;
}

- (RACSignal *)executeSearchSignal {
    return [[[self.services getFlickrSearchService] flickrSearchSignal:self.searchText]
            doNext:^(id x) {
                RWTSearchResultsViewModel *resultsViewModel = [[RWTSearchResultsViewModel alloc] initWithSearchResults:x services:self.services];
                [self.services pushViewModel:resultsViewModel];
            }];
}

@end
