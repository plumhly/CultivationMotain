//
//  Dots.m
//  TouchPainter
//
//  Created by plum on 2016/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "Dots.h"

@interface Dots ()
{
    @private
    UIColor *_color;
    CGFloat _size;
}
@end

@implementation Dots
@synthesize color = _color, size = _size;

#pragma mark -
#pragma mark NSCopying delegate

- (id)copyWithZone:(NSZone *)zone {
    Dots *dotCopy = [[[self class] allocWithZone:zone]initWithLocation:self.location];
    //注意复制颜色需要重新创建color对象，对于基本的数据类型不需要，CGPoint，CGFloat
    dotCopy.color = [UIColor colorWithCGColor:[_color CGColor]];
    dotCopy.size = _size;
    return dotCopy;
}

@end
