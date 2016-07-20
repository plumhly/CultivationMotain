//
//  LayerLabel.m
//  LearnAnimationFun
//
//  Created by plum on 16/7/20.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "LayerLabel.h"

@interface LayerLabel ()

@property (nonatomic, strong) CATextLayer *textLayer;

@end

@implementation LayerLabel

+ (Class)layerClass {
    return [CATextLayer class];
}


- (CATextLayer *)textLayer {
    return (CATextLayer *)self.layer;
}

- (void)setUp {
    [self textLayer].alignmentMode = kCAAlignmentJustified;
     [self textLayer].wrapped = YES;
//    [self.layer display];
}

- (id)initWithFrame:(CGRect)frame
{
    //called when creating label programmatically
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    //called when creating label using Interface Builder
    [self setUp];
}

- (void)setText:(NSString *)text
{
    super.text = text;
    //set layer text
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor
{
    super.textColor = textColor;
    //set layer text color
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font
{
    super.font = font;
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

@end
