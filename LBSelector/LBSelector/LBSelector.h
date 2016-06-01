//
//  LBSelector.h
//  LBSelector
//
//  Created by plum on 16/6/1.
//  Copyright © 2016年 plum. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClick) (NSString *title);

@interface LBSelector : UIView
@property (copy, nonatomic) buttonClick subButtonClicked;


- (instancetype)initWithArray:(NSArray *)array;
@end
