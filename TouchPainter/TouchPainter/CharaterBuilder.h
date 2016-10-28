//
//  CharatorBuilder.h
//  TouchPainter
//
//  Created by libo on 16/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Character;

@interface CharaterBuilder : NSObject
{
    @protected
    Character *_charactor;
}

@property (strong, nonatomic) Character *charactor;


- (CharaterBuilder *)buildNewCharactor;
- (CharaterBuilder *)buildStrength:(float)value;
- (CharaterBuilder *)buildStamina:(float)value;
- (CharaterBuilder *)buildIntelligence:(float)value;
- (CharaterBuilder *)buildAgility:(float)value;
- (CharaterBuilder *)buildAggressiveness:(float)value;

@end
