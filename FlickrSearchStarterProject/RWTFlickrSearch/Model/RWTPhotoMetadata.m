//
//  RWTPhotoMetadata.m
//  RWTFlickrSearch
//
//  Created by plum on 2018/6/19.
//  Copyright © 2018年 Colin Eberhardt. All rights reserved.
//

#import "RWTPhotoMetadata.h"

@implementation RWTPhotoMetadata

- (NSString *)description {
    return [NSString stringWithFormat:@"metadata: comments=%lU, faves=%lU",
            self.comments, self.favorites];
}

@end
