//
//  Vertex.m
//  TouchPainter
//
//  Created by plum on 2016/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex
@dynamic color, size;

- (instancetype)initWithLocation:(CGPoint)location {
    if (self = [super init]) {
        self.location = location;
    }
    return self;
}

//默认属性什么也不做

- (void)setColor:(UIColor *)color {
    
}

- (UIColor *)color {
    return nil;
}

- (void)setSize:(CGFloat)size {
    
}

- (CGFloat)size {
    return 0.0;
}


//Mark操作什么也不做

- (void)addMark:(id<Mark>)mark {
    
}

- (void)removeMark:(id<Mark>)mark {
    
}

- (void)childMarkAtIndex:(NSUInteger)index {
    
}

- (id<Mark>)lastChild {
    return nil;
}

- (NSUInteger)count {
    return 0;
}

- (NSEnumerator *)enumeratorOfSize {
    return nil;
}


#pragma mark -
#pragma mark NSCopying Method

- (id)copyWithZone:(NSZone *)zone {
    Vertex *vertexCopy = [[[self class] allocWithZone:zone] initWithLocation:_location];
    return vertexCopy;
}

@end
