//
//  ChasingGame.h
//  TouchPainter
//
//  Created by libo on 16/10/27.
//  Copyright © 2016年 plum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Character;
@class CharaterBuilder;
@interface ChasingGame : NSObject

- (Character *)createPlayer:(CharaterBuilder *)builder;
- (Character *)createEnemy:(CharaterBuilder *)builder;

@end
