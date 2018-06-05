//
//  PLKVOModel.h
//  KVO_Ex
//
//  Created by plum on 2018/3/16.
//  Copyright © 2018年 plum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

@interface PLKVOModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSArray *fruits;

- (void)addFruit:(NSString *)name;


@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) NSArray *empoyees;
@property (nonatomic, assign) NSInteger totalSalary;

@property (nonatomic, strong) NSMutableArray *goods;


@end
