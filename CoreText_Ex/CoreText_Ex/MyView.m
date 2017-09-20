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

@end