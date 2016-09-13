//
//  CIColorInvert.m
//  CoreImageFun
//
//  Created by plum on 16/9/12.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "CIColorInvert.h"

@implementation CIColorInvert

- (CIImage *)outputImage {
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMatrix" withInputParameters:@{
                                                                          kCIInputImageKey: _inputImage,
                                                                          @"inputRVector": [CIVector vectorWithX:-1 Y:0 Z:0],
                                                                          @"inputGVector": [CIVector vectorWithX:0 Y:-1 Z:0],
                                                                          @"inputBVector": [CIVector vectorWithX:0 Y:0 Z:-1],
                                                                          @"inputBiasVector": [CIVector vectorWithX:1 Y:1 Z:1]
                                                                          }];
    return filter.outputImage;
}

@end
