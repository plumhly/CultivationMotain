
//
//  Plum.m
//  KVC_Ex
//
//  Created by plum on 2018/3/21.
//  Copyright © 2018年 plum. All rights reserved.
//

#import "Plum.h"

@interface Plum() {
    NSArray *_array;
//    NSString *_name;
    
    NSMutableArray *_likes;
}



@end

@implementation Plum

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = @[@"libo", @"plum"];
//        _name = @"mit";
        _likes = [_array mutableCopy];
    }
    return self;
}


//1,2
- (NSUInteger)countOfName {
    NSLog(@"countOfName");
    return _array.count;
}

//array
// 1-1-1
//- (id)objectInNameAtIndex:(NSUInteger)index {
//    NSLog(@"objectInNameAtIndex");
//    return _array[index];
//}

//1-2-1
//- (NSArray *)nameAtIndexes:(NSIndexSet *)indexes {
//    NSLog(@"nameAtIndexes");
//    return [_array objectsAtIndexes:indexes];
//}


//nssset
- (NSEnumerator *)enumeratorOfName {
     NSLog(@"enumeratorOfName");
    return [_array objectEnumerator];
}

- (NSString *)memberOfName:(NSString *)object {
    NSLog(@"memberOfName");
    return @"plum";
}

- (id)valueForUndefinedKey:(NSString *)key {
    return @"Undefined";
}

//mutableArray

//- (void)setName:(NSString *)name {
//    _name = name;
//    NSLog(@"");
//}


+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

@end
