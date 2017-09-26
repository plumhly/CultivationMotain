//
//  PLLayoutManager.m
//  TextKit_Ex
//
//  Created by plum on 2017/9/26.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "PLLayoutManager.h"

@implementation PLLayoutManager

- (void)drawUnderlineForGlyphRange:(NSRange)glyphRange underlineType:(NSUnderlineStyle)underlineVal baselineOffset:(CGFloat)baselineOffset lineFragmentRect:(CGRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(CGPoint)containerOrigin {
    //左边竖线
    CGFloat leftPosition = [self locationForGlyphAtIndex:glyphRange.location].x;
    
    //右边竖线
    CGFloat rightPosition;
    if (NSMaxRange(glyphRange) >= NSMaxRange(lineGlyphRange)) {//字形位置出现在下一行，也就是url在跨越两行
        rightPosition = [self lineFragmentRectForGlyphAtIndex:NSMaxRange(glyphRange) - 1 effectiveRange:NULL].size.width;
//        rightPosition = [self lineFragmentUsedRectForGlyphAtIndex:NSMaxRange(glyphRange) - 1 effectiveRange:NULL].size.width;
    } else {//不然就使用下一个字形
        rightPosition = [self locationForGlyphAtIndex:NSMaxRange(glyphRange)].x;
    }
    
    lineRect.origin.x += leftPosition;
    lineRect.size.width = rightPosition - leftPosition;
    
    lineRect.origin.x += containerOrigin.x;
    lineRect.origin.y += containerOrigin.y;
    
    lineRect = CGRectInset(lineRect, .5, .5);
    [[UIColor greenColor] set];
    [[UIBezierPath bezierPathWithRect:lineRect] stroke];
    
    
}

@end
