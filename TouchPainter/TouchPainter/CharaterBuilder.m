//
//  CharatorBuilder.m
//  TouchPainter
//
//  Created by libo on 16/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "CharaterBuilder.h"
#import "Character.h"

@interface CharaterBuilder ()


@end

@implementation CharaterBuilder
@synthesize charactor = _charactor;

- (CharaterBuilder *)buildNewCharactor {
    _charactor = nil;
    _charactor = [Character new];
    return self;
}

- (CharaterBuilder *)buildStrength:(float)value {
    _charactor.strenth = value;
    return self;
}

- (CharaterBuilder *)buildStamina:(float)value {
    _charactor.stamina = value;
    return self;
}

- (CharaterBuilder *)buildIntelligence:(float)value {
    _charactor.intelligence = value;
    return self;
}

- (CharaterBuilder *)buildAgility:(float)value {
    _charactor.agility = value;
    return self;
}

- (CharaterBuilder *)buildAggressiveness:(float)value {
    _charactor.aggressiveness = value;
    return self;
}

@end
