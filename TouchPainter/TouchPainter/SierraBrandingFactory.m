//
//  SierraBrandingFactory.m
//  TouchPainter
//
//  Created by plum on 2016/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "SierraBrandingFactory.h"
#import "SierraView.h"
#import "SierraToolbar.h"
#import "SierraMainButton.h"

@implementation SierraBrandingFactory

- (UIView *)brandedView {
    return [SierraView new];
}

- (UIToolbar *)brandedToolbar {
    return [SierraToolbar new];
}

- (UIButton *)brandedMainButton {
    return [SierraMainButton new];
}

@end
