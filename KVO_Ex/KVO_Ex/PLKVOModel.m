//
//  PLKVOModel.m
//  KVO_Ex
//
//  Created by plum on 2018/3/16.
//  Copyright © 2018年 plum. All rights reserved.
//

#import "PLKVOModel.h"

@implementation PLKVOModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _fruits = [NSArray array];
        _firstName = @"bo";
        _lastName = @"li";
        _goods = [NSMutableArray new];
        //array
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0 ; i < 10; i++) {
            Employee *employe = [Employee new];
            employe.salary = i;
            [employe addObserver:self forKeyPath:@"salary" options:NSKeyValueObservingOptionNew context:nil];
            [array addObject:employe];
        }
        _empoyees = [array copy];
    }
    return self;
}

+ (BOOL)automaticallyNotifiesObserversOfFruits {
    return NO;
}


//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
//    return YES;
//}

- (void)addFruit:(NSString *)name {
//    NSIndexSet *index = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, 1)];
//    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:index forKey:@"fruits"];
    NSMutableArray *array = [_fruits mutableCopy];
    [array addObject:name];
    _fruits = array;
//    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:index forKey:@"fruits"];
}

//affecting
+ (NSSet<NSString *> *)keyPathsForValuesAffectingFullName {
    return [NSSet setWithObjects:@"firstName", @"lastName", nil];
}

//+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@-%@", _firstName, _lastName];
}

//To-Many Relationships
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self setTotalSalary:[[self valueForKeyPath:@"empoyees.@sum.salary"] integerValue]];
}



@end
