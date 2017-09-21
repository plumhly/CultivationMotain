//
//  MyView.m
//  CoreText_Ex
//
//  Created by plum on 2017/9/20.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "MyView.h"
#import <CoreText/CoreText.h>

@implementation MyView

/* Round1
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Flip the context coordinates, in iOS only.
    CGContextTranslateCTM(context, 0, self.frame.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    // Set the text matrix.
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    // Create a path which bounds the area where you will be drawing text.
    // The path need not be rectangular.
    CGMutablePathRef path = CGPathCreateMutable();
    
    // In this simple example, initialize a rectangular path.
    CGRect bounds = CGRectMake(10.0, 10.0, 200.0, 200.0);
    CGPathAddRect(path, NULL, bounds);
    
    // Initialize a string.
    CFStringRef stringText = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
    
    // Create a mutable attributed string with a max length of 0.
    // The max length is a hint as to how much internal storage to reserve.
    // 0 means no hint.
    CFMutableAttributedStringRef attribure = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    
    // Copy the textString into the newly created attrString
    CFAttributedStringReplaceString(attribure, CFRangeMake(0, 0), stringText);
    
    // Create a color that will be added as an attribute to the attrString.
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat componets[] = {1.0, 0, 0, 1.0};
    CGColorRef redColor = CGColorCreate(colorspace, componets);
    CGColorSpaceRelease(colorspace);
    
    // Set the color of the first 12 chars to red.
    CFAttributedStringSetAttribute(attribure, CFRangeMake(0, 12), kCTForegroundColorAttributeName, redColor);
    
    // Create the framesetter with the attributed string.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attribure);
    CFRelease(attribure);
    
    // Create a frame.
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    
    // Draw the specified frame in the given context.
    CTFrameDraw(frame, context);
    
    //release
    CFRelease(path);
    CFRelease(framesetter);
    CFRelease(frame);
    CFRelease(stringText);
}
 */

/*
 //Simple Text Label
//Round2
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, self.frame.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //create font descriptor
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:@"Courier",(NSString *)kCTFontFamilyNameAttribute, @"Bold", (NSString *)kCTFontStyleNameAttribute, [NSNumber numberWithInteger:17], (NSString *)kCTFontSizeAttribute, nil];
    CTFontDescriptorRef descriptor = CTFontDescriptorCreateWithAttributes((CFDictionaryRef)attribute);
    
    //create font
    CTFontRef font = CTFontCreateWithFontDescriptor(descriptor, 0.0, NULL);
    CFRelease(descriptor);
    
    // Initialize a string.
    CFStringRef stringText = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
    
    CFStringRef keys[] = { kCTFontAttributeName };
    CFTypeRef values[] = { font };
    
    CFDictionaryRef attributes = CFDictionaryCreate(kCFAllocatorDefault, (const void **)&keys, (const void **)&values, sizeof(keys)/ sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    
    CFAttributedStringRef attributeString = CFAttributedStringCreate(kCFAllocatorDefault, stringText, attributes);
    
    CFRelease(stringText);
    CFRelease(attributes);
    
    //create line
    CTLineRef line = CTLineCreateWithAttributedString(attributeString);
    
    // Set text position and draw the line into the graphics context
    CGContextSetTextPosition(context, 10, 300);
    CTLineDraw(line, context);
    CFRelease(line);

}
 */

/*
//Columnar Layout
//Round 3
- (CFArrayRef)createColumnsWithColumnCount:(int)columnCount {
    int column;
    CGRect *columnRects = (CGRect *)calloc(columnCount, sizeof(*columnRects));//calloc() 在内存中动态地分配 num 个长度为 size 的连续空间，并将每一个字节都初始化为 0。所以它的结果是分配了 num*size 个字节长度的内存空间，并且每个字节的值都是0。
    
    // Set the first column to cover the entire view.
    columnRects[0] = self.bounds;
    
    // Divide the columns equally across the frame's width.
    CGFloat columnWidth = CGRectGetWidth(self.bounds) / columnCount;
    
    for(column = 0;column < columnCount - 1; column++) {
        CGRectDivide(columnRects[column], &columnRects[column], &columnRects[column + 1], columnWidth, CGRectMinXEdge);
    }
    
    for(column = 0;column < columnCount; column++) {
        columnRects[column] = CGRectInset(columnRects[column], 8, 15);
    }
    
    CFMutableArrayRef paths = CFArrayCreateMutable(kCFAllocatorDefault, columnCount, &kCFTypeArrayCallBacks);
    
    for(column = 0;column < columnCount; column++) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, columnRects[column]);
        CFArrayInsertValueAtIndex(paths, column, path);
        CFRelease(path);
    }
    free(columnRects);
    
    return paths;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, CGRectGetHeight(self.bounds));
    CGContextScaleCTM(context, 1, -1);
    
    // Set the text matrix.
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:@"CGContextRef context = UIGraphicsGetCurrentContext();CG;attributes:@{NSForegroundColorAttributeName:[UIColor redColor]attributes:@{NSForegroundColorAttributeName:[UIColor redColor]attributes:@{NSForegroundColorAttributeName:[UIColor redColor]attributes:@{NSForegroundColorAttributeName:[UIColor redColor]attributes:@{NSForegroundColorAttributeName:[UIColor redColor]attributes:@{NSForegroundColorAttributeName:[UIColor redColor]attributes:@{NSForegroundColorAttributeName:[UIColor redColor]attributes:@{NSForegroundColorAttributeName:[UIColor redColor]attributes:@{NSForegroundColorAttributeName:[UIColor redColor]attributes:@{NSForegroundColorAttributeName:[UIColor redColor]attributes:@{NSForegroundColorAttributeName:[UIColor redColor]" attributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attribute);
    
    // Call createColumnsWithColumnCount function to create an array of
    // three paths (columns).
    CFArrayRef paths = [self createColumnsWithColumnCount:3];
    CFIndex index = CFArrayGetCount(paths);
    CFIndex startIndex = 0;
    int column;
    for (column = 0; column < index; column++) {
        CGPathRef path = CFArrayGetValueAtIndex(paths, column);
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(startIndex, 0), path, NULL);
        CTFrameDraw(frame, context);
        
        CFRange range = CTFrameGetVisibleStringRange(frame);
        startIndex += range.length;
        CFRelease(frame);
    }
    CFRelease(paths);
    CFRelease(frameSetter);
}
 */

//Manual Line Breaking
//Round 4
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, CGRectGetHeight(self.bounds));
    CGContextScaleCTM(context, 1, -1);
    NSString *text = @"CGContextRefcontextUIGrap = hicsGetCurrentContext();CG:attributes:@{NSForegroundColorAttributeName:[UIColor redColor]attributes:@{NSForegroundColor";
    double width = 300;
    CGPoint textPosition = CGPointMake(0, 200);
    
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString: text attributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    
    // Create a typesetter using the attributed string.
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString((CFAttributedStringRef)attribute);
    
    // Find a break for line from the beginning of the string to the given width.
    CFIndex index = 0;
    CFIndex count = CTTypesetterSuggestLineBreak(typesetter, index, width);
    
    // Use the returned character count (to the break) to create the line.
    CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(index, count));
    
    // Get the offset needed to center the line.
    float flush = 0;
    double penOffset = CTLineGetPenOffsetForFlush(line, flush, width);
    
    // Move the given text drawing position by the calculated offset and draw the line.
    CGContextSetTextPosition(context, textPosition.x + penOffset, textPosition.y);
    CTLineDraw(line, context);
    
    index += count;
    
    CFRelease(typesetter);
    CFRelease(line);
    
}

@end
