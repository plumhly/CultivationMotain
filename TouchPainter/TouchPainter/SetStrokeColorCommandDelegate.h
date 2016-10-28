//
//  SetStrokeColorCommandDelegate.h
//  TouchPainter
//
//  Created by libo on 16/10/28.
//  Copyright © 2016年 plum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SetStrokeColorCommand;

@protocol SetStrokeColorCommandDelegate <NSObject>


- (void)command:(SetStrokeColorCommand *)command didRequestColorComponentsForRed:(float *)red green:(float *)green  blue:(float *)blue;

- (void)command:(SetStrokeColorCommand *)command didFinishUpdateColorWithColor:(UIColor *)color;

@end
