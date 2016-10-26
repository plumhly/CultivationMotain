//
//  BrandingFactory.m
//  TouchPainter
//
//  Created by plum on 2016/10/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "BrandingFactory.h"
#import "AcmeBrandingFactory.h"
#import "SierraBrandingFactory.h"

@implementation BrandingFactory

+ (BrandingFactory *)factory {

#ifdef  USER_ACME
    return [[AcmeBrandingFactory alloc]init];
#elifdef USER_SIERRA
    return [[SierraBrandingFactory alloc]init];
#else
    return nil;
#endif
}

- (UIView *)brandedView {
    return nil;
}

- (UIButton *)brandedMainButton {
    return nil;
}

- (UIToolbar *)brandedToolbar {
    return nil;
}

@end
