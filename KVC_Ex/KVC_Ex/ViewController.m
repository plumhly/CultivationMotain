//
//  ViewController.m
//  KVC_Ex
//
//  Created by plum on 2018/3/21.
//  Copyright © 2018年 plum. All rights reserved.
//

#import "ViewController.h"
#import "Department.h"
#import "Employee.h"
#import "Plum.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIWebView
    NSURLRequest
    Plum *plum = [Plum new];
//    id value = [plum valueForKey:@"name"];
//    id vs = [value member:@"libo"];
    id undef = [plum valueForKey:@"name"];
//    NSKeyValueSlowMutableArray/NSKeyValueMutableArray
    NSMutableArray *valeus = [plum mutableArrayValueForKey:@"array"];
//    valeus = @[];
    [valeus addObject:@"d"];
    NSLog(@"");
    
    [plum mutableArrayValueForKey:@""];
  
}

- (void)ex_1 {
    NSMutableArray *names = [NSMutableArray array];
    for (int j = 0; j < 3; j++) {
        NSString *name = [NSString stringWithFormat:@"name_%i",j];
        [names addObject:name];
    }
    
    Employee *em = [Employee new];
    em.names = [names copy];
    
    Department *depart = [Department new];
    depart.employee = em;
    
    NSMutableArray *ages = [NSMutableArray array];
    NSMutableArray *ages1 = [NSMutableArray array];
    for (int j = 0; j < 3; j++) {
        NSInteger age = 20 + j;
        Employee *ep = [Employee new];
        ep.age = age;
        [ages addObject:ep];
    }
    
    for (int j = 0; j < 3; j++) {
        NSInteger age = 200 + j;
        Employee *ep = [Employee new];
        ep.age = age;
        [ages1 addObject:ep];
    }
    
    depart.allEmployees = [ages copy];
    
    
    NSArray *total = @[ages, ages1];
    
    [depart setValuesForKeysWithDictionary:@{@"name": @"libo", @"count": [NSNumber numberWithInt:10]}];
    
    NSNumber *numer = [depart.allEmployees valueForKeyPath:@"@distinctUnionOfObjects.age"];
    
    NSArray *tto = [total valueForKeyPath:@"@distinctUnionOfArrays.age"];
    //    NSArray *d = [depart valueForKeyPath:@"employee.names"];
    
    NSMutableArray *muta = [em mutableArrayValueForKey:@"names"];
    NSString *newname = @"plum";
    NSError *error = nil;
    BOOL is = [depart validateValue:&newname forKey:@"name" error:&error];
    NSDictionary *dic = [em dictionaryWithValuesForKeys:@[@"names"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
