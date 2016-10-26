//
//  AcmeBrandingFactory.m
//  TouchPainter
//
//  Created by plum on 2016/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "AcmeBrandingFactory.h"
#import "AcmeView.h"
#import "AcmeToolbar.h"
#import "AcmeMainButton.h"

@implementation AcmeBrandingFactory

- (UIView *)brandedView {
    return [AcmeView new];
}

- (UIToolbar *)brandedToolbar {
    return [AcmeToolbar new];
}

- (UIButton *)brandedMainButton {
    return [AcmeMainButton new];
}

@end
