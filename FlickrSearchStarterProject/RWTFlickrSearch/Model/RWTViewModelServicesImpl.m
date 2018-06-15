//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/15.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServicesImpl.h"
#import "RWTFlickrSearchImpl.h"
#import "RWTSearchResultsViewController.h"
#import "RWTSearchResultsViewModel.h"

@interface RWTViewModelServicesImpl()
@property (nonatomic, strong) RWTFlickrSearchImpl *searchService;
@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation RWTViewModelServicesImpl

- (instancetype)init
{
    self = [super init];
    if (self) {
        _searchService = [RWTFlickrSearchImpl new];
    }
    return self;
}



- (instancetype)initWithNavigationController:(UINavigationController *)navigaionController {
    self = [self init];
    _navigationController = navigaionController;
    return self;
}


#pragma mark - RWTViewModelServices
- (id<RWTFlickrSearch>)getFlickrSearchService {
    return _searchService;
}

- (void)pushViewModel:(id)viewModel {
    id viewController;
    if ([viewModel isKindOfClass:RWTSearchResultsViewModel.class]) {
        viewController = [[RWTSearchResultsViewController alloc] initWithViewModel:viewModel];
    } else {
        NSLog(@"an unknown ViewModel was pushed!");
    }
    [self.navigationController pushViewController:viewController animated:YES];
}



@end
