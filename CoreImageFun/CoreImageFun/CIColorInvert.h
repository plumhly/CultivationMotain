//
//  CIColorInvert.h
//  CoreImageFun
//
//  Created by plum on 16/9/12.
//  Copyright © 2016年 plum. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface CIColorInvert : CIFilter

@property (nonatomic, strong) CIImage *inputImage;

@end
