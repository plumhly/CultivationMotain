//
//  ChasingGame.m
//  TouchPainter
//
//  Created by libo on 16/10/27.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "ChasingGame.h"
#import "CharaterBuilder.h"
#import "Character.h"

@implementation ChasingGame

- (Character *)createPlayer:(CharaterBuilder *)builder {
    [[[[[[builder buildNewCharactor]
     buildStrength:50]
     buildStamina:25]
     buildIntelligence:75]
     buildAgility:65]
     buildAggressiveness:35];
    return builder.charactor;
}


- (Character *)createEnemy:(CharaterBuilder *)builder {
    [builder buildNewCharactor];
    [builder buildStrength:80];
    [builder buildAgility:25.0];
    [builder buildAggressiveness:95];
    [builder buildIntelligence:35];
    return builder.charactor;
}

@end
