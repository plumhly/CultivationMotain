//
//  ViewController.m
//  KVO_Ex
//
//  Created by plum on 2018/2/28.
//  Copyright © 2018年 plum. All rights reserved.
//

#import "ViewController.h"
#import "PLKVOView.h"
#import "PLKVOModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PLKVOView *kvoView;
@property (nonatomic, strong) PLKVOModel *model;
@end

void *ChangeNameContenxt = &ChangeNameContenxt;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSKeyValueObserving
    // Do any additional setup after loading the view, typically from a nib.
    _model = [PLKVOModel new];
    _model.name = @"libo";
    
    [_model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:@"plum"];
    
    _model.name = @"PLUM";
    

    
    //one-to-many
    [_model addObserver:self forKeyPath:@"fruits" options:NSKeyValueObservingOptionNew context:nil];
    
    //affecting
    
    [_model addObserver:self forKeyPath:@"fullName" options:NSKeyValueObservingOptionNew context:nil];
    
    //to-many
    [_model addObserver:self forKeyPath:@"totalSalary" options:NSKeyValueObservingOptionNew context:nil];
    
    [_model.goods addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"]) {
        
    }
    
    //or
    
    if (context == ChangeNameContenxt) {
        
    }
    NSLog(@"");
}

- (IBAction)click:(id)sender {
//    [_model addFruit:@"apple"];
    
    //affecting
//    _model.firstName = @"plum";
    
    //to-many
//    Employee *em = _model.empoyees.firstObject;
//    em.salary = 10;
    
    //goods
    [_model.goods addObject:@"Objective-c"];//not working
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
