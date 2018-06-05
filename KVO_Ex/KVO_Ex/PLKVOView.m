//
//  PLKVOView.m
//  KVO_Ex
//
//  Created by plum on 2018/3/16.
//  Copyright © 2018年 plum. All rights reserved.
//

#import "PLKVOView.h"

@interface PLKVOView()

@property (nonatomic, strong) UILabel *label;

@end

@implementation PLKVOView


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _label.backgroundColor = [UIColor lightGrayColor];
        _label.text = @"default";
        [self addSubview:_label];
    }
    return self;
}

- (void)setContent:(NSString *)val {
    _label.text = val;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    NSString *newVal = change[NSKeyValueChangeNewKey];
    _label.text = newVal;
}

@end
