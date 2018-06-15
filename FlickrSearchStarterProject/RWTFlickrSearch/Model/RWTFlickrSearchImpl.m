//
//  RWTFlickrSearchImpl.m
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/15.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchImpl.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTFlickrSearchResults.h"
#import "RWTFlickrPhoto.h"
#import <objectiveflickr/ObjectiveFlickr.h>
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>

@interface RWTFlickrSearchImpl()<OFFlickrAPIRequestDelegate>

@property (nonatomic, strong) NSMutableSet *requests;
@property (nonatomic, strong) OFFlickrAPIContext *flickrContext;

@end

@implementation RWTFlickrSearchImpl


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *APIkey = @"9453ea17a607edf64eea7c2f775ce0ef";
        NSString *shareSecret = @"81b9367445df4040";
        _flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:APIkey sharedSecret:shareSecret];
        _requests = [NSMutableSet set];
    }
    return self;
}

- (RACSignal *)flickrSearchSignal:(NSString *)searchString {
    return [self signalFromAPIMethod:@"flickr.photos.search" arguments:@{@"text": searchString, @"sort": @"interestingness-desc"} transform:^id(NSDictionary *response) {
        RWTFlickrSearchResults *results = [RWTFlickrSearchResults new];
        results.searchString = searchString;
        results.totalResults = [[response valueForKeyPath:@"photos.total"] integerValue];
        
        NSArray *photos = [response valueForKeyPath:@"photos.photo"];
        results.photos = [photos linq_select:^id(NSDictionary *json) {
            RWTFlickrPhoto *photo = [RWTFlickrPhoto new];
            photo.title = json[@"title"];
            photo.identifier = json[@"id"];
            photo.url = [self.flickrContext photoSourceURLFromDictionary:json size:OFFlickrSmallSize];
            return photo;
        }];
        return results;
    }];
}

- (RACSignal *)signalFromAPIMethod:(NSString *)method arguments:(NSDictionary *)args transform:(id(^)(NSDictionary *response))block {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        OFFlickrAPIRequest *flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:self.flickrContext];
        flickrRequest.delegate = self;
        [self.requests addObject:flickrRequest];
        RACSignal *successSignal = [self rac_signalForSelector:@selector(flickrAPIRequest:didCompleteWithResponse:) fromProtocol:@protocol(OFFlickrAPIRequestDelegate)];
        [[[successSignal
           map:^id(RACTuple *value) {
               return value.second;
           }]
          map:block]
         subscribeNext:^(id x) {
             [subscriber sendNext:x];
             [subscriber sendCompleted];
         }];
        
        [flickrRequest callAPIMethodWithGET:method arguments:args];
        return [RACDisposable disposableWithBlock:^{
            [self.requests removeObject:flickrRequest];
        }];
    }];
}
@end
