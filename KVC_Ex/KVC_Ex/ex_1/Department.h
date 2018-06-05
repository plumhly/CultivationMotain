//
//  Department.h
//  KVC_Ex
//
//  Created by plum on 2018/3/21.
//  Copyright © 2018年 plum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

@interface Department : NSObject

@property (nonatomic, strong) NSArray<Employee *> *allEmployees;

@property (nonatomic, strong) Employee *employee;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *name;


@end
