//
//  BrandingFactory.h
//  TouchPainter
//
//  Created by plum on 2016/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

/**************************************/
/*****          抽象工厂           *****/
/*************************************/
#import <UIKit/UIKit.h>

@interface BrandingFactory : NSObject


+ (BrandingFactory *)factory;

//这些都是产品,多个产品的组合
- (UIView *)brandedView;
- (UIButton *)brandedMainButton;
- (UIToolbar *)brandedToolbar;

@end
