//
//  Stroke.m
//  TouchPainter
//
//  Created by plum on 2016/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "Stroke.h"

@interface Stroke ()

@property (nonatomic, strong) NSMutableArray<id <Mark>> *children;

@end

@implementation Stroke

@dynamic location;

- (instancetype)init {
    if (self = [super init]) {
        _children = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}

- (void)setLocation:(CGPoint)location {
    
}

- (CGPoint)location {
    if (_children.count > 0) {
        return [_children.lastObject location];
    }
    return CGPointZero;
}

- (void)addMark:(id<Mark>)mark {
    [_children addObject:mark];
}

- (void)removeMark:(id<Mark>)mark {
    // 如果mark在这一层，将其移除并返回，否则让每个子节点去找它
    if ([_children containsObject:mark]) {
        [_children removeObject:mark];
    } else {
        [_children makeObjectsPerformSelector:@selector(removeMark:) withObject:mark];
    }
    
}

- (id<Mark>)childMarkAtIndex:(NSUInteger)index {
    if (index < _children.count) {
        return _children[index];
    }
    return nil;
}

- (id<Mark>)lastChild {
    return _children.lastObject;
}

- (NSUInteger)count {
    return _children.count;
}

#pragma mark -
#pragma mark NSCopying delegate

- (id)copyWithZone:(NSZone *)zone {
    Stroke *strokeCopy = [[[self class] allocWithZone:zone] init];
    
    [strokeCopy setColor:[UIColor colorWithCGColor:[_color CGColor]]];
    strokeCopy.size = _size;
    for (id <Mark> obj in _children) {
        id <Mark> childCopy = [obj copy];
        [strokeCopy addMark:childCopy];
    }
    return strokeCopy;
}


@end
