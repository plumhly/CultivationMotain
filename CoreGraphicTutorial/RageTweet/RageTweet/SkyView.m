//
//  SkyView.m
//  RageTweet
//
//  Created by Brian Douglas Moakley on 2/22/13.
//  Copyright (c) 2013 Razeware. All rights reserved.
//

#import "SkyView.h"

#define HAPPY 0
#define SOMEWHAT_HAPPY 1
#define NEUTRAL 2
#define TICKED_OFF 3
#define RAGING 4
#define degreesToRadians(x) (M_PI * x / 180.0)

@implementation SkyView

-(void) setRageLevel:(NSInteger)rageLevel
{
    _rageLevel = rageLevel;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     
     // draw sky
     // draw mountains
     // draw grass
     // draw flowers
      [self drawSkyInRect:rect inContext:context withColorSpace:colorSpace];
     [self drawMountainsInRect:rect inContext:context withColorSpace:colorSpace];
     [self drawGrassInRect:rect inContext:context withColorSpace:colorSpace];
     CGColorSpaceRelease(colorSpace);
     
     CGMutablePathRef flowerPetal = CGPathCreateMutable();
    CGAffineTransform transform = CGAffineTransformMakeRotation(degreesToRadians(45));
     CGRect arect = CGRectMake(110, 0, 50, 100);
     CGPathAddEllipseInRect(flowerPetal, &transform, arect);
     CGContextAddPath(context, flowerPetal);
     CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
     CGContextStrokePath(context);
 }

-(void) drawSkyInRect: (CGRect) rect inContext: (CGContextRef) context withColorSpace: (CGColorSpaceRef) colorSpace {
    UIColor * baseColor = [UIColor colorWithRed:148.0/255.0 green:158.0/255.0 blue:183.0/255.0 alpha:1.0];
    UIColor * middleStop = [UIColor colorWithRed:127.0/255.0 green:138.0/255.0 blue:166.0/255.0 alpha:1.0];
    UIColor * farStop = [UIColor colorWithRed:96.0/255.0 green:111.0/255.0 blue:144.0/255.0 alpha:1.0];
//    CGContextSaveGState(context);
    NSArray *colors = @[(__bridge id)baseColor.CGColor,(__bridge id)middleStop.CGColor,(__bridge id)farStop.CGColor];
    CGFloat location[] = {0, 0.1,0.25};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge  CFArrayRef)colors, location);
    CGPoint startPoint = CGPointMake(rect.size.height / 2, 0);
    CGPoint endPoint = CGPointMake(rect.size.height / 2, rect.size.width);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
//    CGContextRestoreGState(context);
}
 
-(void) drawMountainsInRect: (CGRect) rect inContext: (CGContextRef) context withColorSpace: (CGColorSpaceRef) colorSpace {
    
    UIColor * darkColor = [UIColor colorWithRed:1.0/255.0 green:93.0/255.0 blue:67.0/255.0 alpha:1];
    UIColor * lightColor = [UIColor colorWithRed:63.0/255.0 green:109.0/255.0 blue:79.0/255.0 alpha:1];
    
    NSArray * mountainColors = @[(__bridge id)darkColor.CGColor, (__bridge id)lightColor.CGColor];
    CGFloat mountainLocations[] = { .1, .2 };
    CGGradientRef mountainGrad = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) mountainColors, mountainLocations);
    CGPoint mountainStart = CGPointMake(rect.size.height / 2, 100);
    CGPoint mountainEnd = CGPointMake(rect.size.height / 2, rect.size.width);
    
    CGContextSaveGState(context);
    
    CGMutablePathRef backgroundMountains = CGPathCreateMutable();
    CGPathMoveToPoint(backgroundMountains, nil, -5, 157);
    CGPathAddQuadCurveToPoint(backgroundMountains, nil, 30, 129, 77, 157);
    CGPathAddCurveToPoint(backgroundMountains, nil, 190, 210, 200, 70, 303, 125); // Old Code
    CGPathAddQuadCurveToPoint(backgroundMountains, nil, 340, 150, 350, 150);
    CGPathAddQuadCurveToPoint(backgroundMountains, nil, 380, 155, 410, 145);
    CGPathAddCurveToPoint(backgroundMountains, nil, 500, 100, 540, 190, 580, 165);
    CGPathAddLineToPoint(backgroundMountains, nil, 580, rect.size.width);
    CGPathAddLineToPoint(backgroundMountains, nil, -5, rect.size.width);
    CGPathCloseSubpath(backgroundMountains);
    
    CGContextAddPath(context, backgroundMountains);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, mountainGrad, mountainStart, mountainEnd, 0);
    CGContextSetLineWidth(context, 4);
    
    CGContextAddPath(context, backgroundMountains);
    CGContextSetStrokeColorWithColor(context,[UIColor blackColor].CGColor);
    CGContextStrokePath(context);
    // More Coming
    
    
    // Foreground Mountains
    CGMutablePathRef foregroundMountains = CGPathCreateMutable();
    CGPathMoveToPoint(foregroundMountains, nil, -5, 190);
    CGPathAddCurveToPoint(foregroundMountains, nil, 160, 250, 200, 140, 303, 190);
    CGPathAddCurveToPoint(foregroundMountains, nil, 430, 250, 550, 170, 590, 210);
    CGPathAddLineToPoint(foregroundMountains, nil, 590, 230);
    CGPathAddCurveToPoint(foregroundMountains, nil, 300, 260, 140, 215, 0, 225);
    CGPathCloseSubpath(foregroundMountains);
    
    // Foreground Mountain drawing
    CGContextAddPath(context, foregroundMountains);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, darkColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 170, 590, 90));
    
    // Foreground Mountain stroking
    CGContextAddPath(context, foregroundMountains);
    CGContextSetStrokeColorWithColor(context,[UIColor blackColor].CGColor);
    CGContextStrokePath(context);
    
    // Cleanup Code
    CGPathRelease(foregroundMountains);
    CGContextRestoreGState(context);
    CGGradientRelease(mountainGrad);
    CGPathRelease(backgroundMountains);
}


-(void) drawGrassInRect: (CGRect) rect inContext: (CGContextRef) context withColorSpace: (CGColorSpaceRef) colorSpace
{
    CGPoint grassStart = CGPointMake(rect.size.height / 2, 100);
    CGPoint grassEnd = CGPointMake(rect.size.height / 2, rect.size.width);
    
    CGContextSaveGState(context);
    CGMutablePathRef grass = CGPathCreateMutable();
    CGPathMoveToPoint(grass, nil, 590, 230);
    CGPathAddCurveToPoint(grass, nil, 300, 260, 140, 215, 0, 225);
    CGPathAddLineToPoint(grass, nil, 0, rect.size.width);
    CGPathAddLineToPoint(grass, nil, 590, rect.size.width);
    
    CGContextAddPath(context, grass);
    CGContextClip(context);
    
    UIColor * lightGreen = [UIColor colorWithRed:39.0/255.0 green:171.0/255.0 blue:95.0/255.0 alpha:1];
    UIColor * darkGreen = [UIColor colorWithRed:0.0/255.0 green:134.0/255.0 blue:61.0/255.0 alpha:1];
    
    NSArray * grassColors = @[ (__bridge id) lightGreen.CGColor, (__bridge id) darkGreen.CGColor];
    CGFloat grassLocations[] = { .3, .4};
    CGGradientRef grassGrad = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) grassColors, grassLocations);
    
    CGContextDrawLinearGradient(context, grassGrad, grassStart, grassEnd, 0);
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGPathRelease(grass);
    CGGradientRelease(grassGrad);
    CGContextRestoreGState(context);
}

-(void) drawPetalInRect: (CGRect) rect inDegrees: (NSInteger) degrees inContext: (CGContextRef) context
{
    CGContextSaveGState(context);
    CGMutablePathRef flowerPetal = CGPathCreateMutable();
    float midX = CGRectGetMidX(rect);
    float midY = CGRectGetMidY(rect);
    CGAffineTransform transfrom =
    CGAffineTransformConcat(
                            CGAffineTransformConcat(CGAffineTransformMakeTranslation(-midX, -midY),CGAffineTransformMakeRotation(degreesToRadians(degrees))),
                            CGAffineTransformMakeTranslation(midX, midY));
    
//    CGPathAddEllipseInRect(flowerPetal, &transfrom, rect);
//    CGContextAddPath(context, flowerPetal);
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//    CGContextStrokePath(context);
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextAddPath(context, flowerPetal);
//    CGContextFillPath(context);
    
    CGPathRelease(flowerPetal);
    CGContextRestoreGState(context);
}

-(void) drawFlowersInRect: (CGRect) rect inContext: (CGContextRef) context withColorSpace: (CGColorSpaceRef) colorSpace
{
    CGContextSaveGState(context);
    
    [self drawPetalInRect:CGRectMake(125, 230, 9, 14) inDegrees:0 inContext:context];
    [self drawPetalInRect:CGRectMake(115, 236, 10, 12) inDegrees:300 inContext:context];
    [self drawPetalInRect:CGRectMake(120, 246, 9, 14) inDegrees:5 inContext:context];
    [self drawPetalInRect:CGRectMake(128, 246, 9, 14) inDegrees:350 inContext:context];
    [self drawPetalInRect:CGRectMake(133, 236, 11, 14) inDegrees:80 inContext:context];
    
    CGMutablePathRef center = CGPathCreateMutable();
    CGRect ellipse = CGRectMake(126, 242, 6, 6);
    CGPathAddEllipseInRect(center, NULL, ellipse);
    
    UIColor * orangeColor = [UIColor colorWithRed:255/255.0 green:174/255.0 blue:49.0/255.0 alpha:1.0];
    
    CGContextAddPath(context, center);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, orangeColor.CGColor);
    CGContextAddPath(context, center);
    CGContextFillPath(context);
    CGContextMoveToPoint(context, 135, 249);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddQuadCurveToPoint(context, 145, 250, 133, 270);
    CGContextStrokePath(context);
    
    CGPathRelease(center);
    CGContextRestoreGState(context);
}
@end
