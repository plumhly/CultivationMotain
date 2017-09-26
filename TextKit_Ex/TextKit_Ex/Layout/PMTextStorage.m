//
//  PMTextStorage.m
//  TextKit_Ex
//
//  Created by plum on 2017/9/26.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "PMTextStorage.h"

@implementation PMTextStorage  {
    NSMutableAttributedString *_imp;
}

- (instancetype)init {
    if (self = [super init]) {
        _imp = [NSMutableAttributedString new];
    }
    return self;
}

- (NSString *)string {
    return _imp.string;
}

- (NSDictionary<NSAttributedStringKey,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    return [_imp attributesAtIndex:location effectiveRange:range];
}

- (void)setAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range {
    [_imp setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    
    [_imp replaceCharactersInRange:range withString:str];
    
    static NSDataDetector *linkDetector;
    linkDetector = linkDetector ?: [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink  error:nil];
    
    NSRange textRange = [self.string paragraphRangeForRange:NSMakeRange(range.location, str.length)];
    [self removeAttribute:NSLinkAttributeName range:textRange];
    [self removeAttribute:NSUnderlineStyleAttributeName range:textRange];
    [self removeAttribute:NSBackgroundColorDocumentAttribute range:textRange];
    
    
    [linkDetector enumerateMatchesInString:self.string options:NSMatchingReportProgress range:textRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [self addAttribute:NSLinkAttributeName value:result.URL range:result.range];
        [self addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:result.range];
        [self addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:result.range];
    }];
    
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:str.length - range.length];
}


@end
