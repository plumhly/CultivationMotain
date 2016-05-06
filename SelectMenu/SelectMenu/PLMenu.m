//
//  PLMenu.m
//  SelectMenu
//
//  Created by plum on 16/5/6.
//  Copyright © 2016年 plum. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#import "PLMenu.h"
@interface PLMenu ()

@property (nonatomic, strong) NSArray *allItemName;

@end

@implementation PLMenu


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
}

- (instancetype)initMenuWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        CGFloat width = 167;
        NSInteger count = array.count % 2 ? array.count /2 : (array.count + 1)/2;
        self.backgroundColor = [UIColor clearColor];
        _allItemName = array;
        CGFloat hight = count * 28 + (count + 1) * 12;
        self.frame = CGRectMake(SCREEN_WIDTH * 0.5, 64, width, hight);
        UIImage *image = [UIImage imageNamed:@"展开背景"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(hight/2, 0, hight/2 - 10, 0) resizingMode:UIImageResizingModeStretch];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = self.bounds;
        [self addSubview:imageView];
        
        
    }
    return self;
}

- (void)showMemuFromButton:(id)sender {
    
}

- (void)createSubButtonWithArray:(NSArray *)array {
    
}
@end
