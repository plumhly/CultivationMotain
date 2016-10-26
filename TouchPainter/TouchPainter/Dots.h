//
//  Dots.h
//  TouchPainter
//
//  Created by plum on 2016/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"

@interface Dots : Vertex

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat size;


- (id)copyWithZone:(NSZone *)zone; 
@end
