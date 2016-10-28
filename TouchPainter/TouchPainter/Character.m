//
//  Character.m
//  TouchPainter
//
//  Created by libo on 16/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "Character.h"

@implementation Character

- (instancetype)init
{
    self = [super init];
    if (self) {
        _protection = 1.0;
        _power = 1.0;
        _strenth = 1.0;
        _stamina = 1.0;
        _intelligence = 1.0;
        _agility = 1.0;
        _aggressiveness = 1.0;
    }
    return self;
}

@end
