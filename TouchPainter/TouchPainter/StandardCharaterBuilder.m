//
//  StandardCharaterBuilder.m
//  TouchPainter
//
//  Created by libo on 16/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "StandardCharaterBuilder.h"
#import "Character.h"

@implementation StandardCharaterBuilder


- (CharaterBuilder *)buildStrength:(float)value {
    _charactor.protection *= value;
    _charactor.power *= value;
    return [super buildStrength:value];
}

- (CharaterBuilder *)buildStamina:(float)value {
    _charactor.protection *= value;
    _charactor.power *= value;
    return [super buildStamina:value];
}

- (CharaterBuilder *)buildAgility:(float)value {
    _charactor.protection *= value;
    _charactor.power /= value;
    return [super buildAgility:value];
}

- (CharaterBuilder *)buildAggressiveness:(float)value {
    _charactor.protection /= value;
    _charactor.power *= value;
    return [super buildAggressiveness:value];
}

- (CharaterBuilder *)buildIntelligence:(float)value {
    _charactor.protection *= value;
    _charactor.power /= value;
    
    return [super buildIntelligence:value];
}

@end
