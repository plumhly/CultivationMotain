//
//  LBSelector.m
//  LBSelector
//
//  Created by plum on 16/6/1.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "LBSelector.h"
#import <Masonry.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface LBSelector()

@property (nonatomic, copy)NSArray *array;
@property (strong, nonatomic) UIView *extendView;
@property (strong, nonatomic) UIView *coverView;
@property (strong, nonatomic) UITapGestureRecognizer *gesture;

@end

@implementation LBSelector


- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor redColor];
        [_coverView addGestureRecognizer:self.gesture];
    }
    return _coverView;
}

- (UIView *)extendView {
    if (!_extendView) {
        _extendView = [[UIView alloc]init];
        _extendView.backgroundColor = [UIColor yellowColor];
        [_extendView addGestureRecognizer:self.gesture];
    }
    return _extendView;
}

- (UITapGestureRecognizer *)gesture {
    if (!_gesture) {
        _gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideExtendView)];
        _gesture.numberOfTouchesRequired = 1;
        _gesture.numberOfTapsRequired = 1;
    }
    return _gesture;
}

- (void)updateConstraints {
    [_coverView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.extendView.mas_bottom);
        make.leading.trailing.equalTo(self);
        make.bottom.mas_equalTo(self.superview.mas_bottom);
    }];
    [super updateConstraints];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
}

- (void)createSelectorWithArray:(NSArray *)array {
    if (array) {
        _array = array;
         __weak typeof(self) weakSelf = self;
        CGFloat lineWidth = 0.5;
        NSInteger count = array.count;
        CGFloat width = (SCREEN_WIDTH - (count - 1) * lineWidth) /count;
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *key = [obj allKeys];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor grayColor];
            [button setTitle:key.firstObject forState:UIControlStateNormal];
            button.tag = idx + 10;
            [button addTarget:weakSelf action:@selector(showSubSelector:) forControlEvents:UIControlEventTouchUpInside];
            [weakSelf addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.offset(width);
                make.leading.offset(width*idx + idx * lineWidth);
                make.top.bottom.equalTo(weakSelf);
            }];
            
            UIView *line = [[UIView alloc]init];
            [weakSelf addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(weakSelf);
                make.leading.mas_equalTo(button.mas_trailing);
                make.width.offset(lineWidth);
            }];
            
        }];
    }
}

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        [self createSelectorWithArray:array];
    }
    return self;
}

- (void)showSubSelector:(UIButton *)button {
    for (UIButton *button in _extendView.subviews) {
        [button removeFromSuperview];
    }
    NSUInteger index = button.tag % 10;
    CGFloat width = (SCREEN_WIDTH - 45) / 4.0;
    CGFloat height = 28;
    CGFloat buttonInterSpace = 9;
    CGFloat vSpaceToExtendView = 10;
    __block UIButton *refrenceButton1;//横向
    __block UIButton *refrenceButton2;//纵向
    
    __weak typeof(self) weakSelf = self;
    if (index < _array.count) {
       NSDictionary *dic = _array[index];
        NSArray *allValues = [dic allValues].firstObject;
        [allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:allValues[idx] forState:UIControlStateNormal];
            [button addTarget: weakSelf action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [weakSelf.extendView addSubview:button];
            [button mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(width, height));
                if (refrenceButton1) {
                    make.leading.equalTo(refrenceButton1.mas_trailing).offset(buttonInterSpace);
                    make.centerY.equalTo(refrenceButton1);
                } else {
                    make.leading.equalTo(weakSelf.extendView).offset(buttonInterSpace);
                }
                refrenceButton1 = button;
                
                //最后一个button，重置
                if ((idx + 1) % 4 == 0) {
                    refrenceButton1 = nil;
                    make.trailing.equalTo(weakSelf.extendView.mas_trailing).offset(-buttonInterSpace);
                }
                if (idx % 4 == 0) {
                    if (refrenceButton2) {
                        make.top.mas_equalTo(refrenceButton2.mas_bottom).offset(buttonInterSpace);
                    } else {
                        make.top.mas_equalTo(weakSelf.extendView.mas_top).offset(vSpaceToExtendView);
                    }
                    refrenceButton2 = button;
                }
                if (idx == allValues.count - 1) {
                    make.bottom.offset(-vSpaceToExtendView);
                }
            }];
        }];
        [self.superview addSubview:weakSelf.extendView];
        [weakSelf.extendView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_bottom);
            make.leading.trailing.equalTo(weakSelf);
        }];
        [self.superview addSubview:weakSelf.coverView];
        [self updateConstraints];
    }
}


- (void)buttonSelected:(UIButton *)button {
    if (self.subButtonClicked) {
        _subButtonClicked(button.currentTitle);
    }
    [self hideExtendView];
}

- (void)hideExtendView {
    [_extendView removeFromSuperview];
    [_coverView removeFromSuperview];
}
@end
