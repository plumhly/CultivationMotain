//
//  PLTextStore.m
//  TextKit_Ex
//
//  Created by Plum on 2017/9/23.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "PLTextStore.h"


@implementation PLTextStore {
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
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:str.length - range.length];
}

- (void)processEditing {
    static NSRegularExpression *iExpression;
    iExpression = iExpression ?: [[NSRegularExpression alloc] initWithPattern:@"i[\\p{Alphabetic}&&\\p{Uppercase}][\\p{Alphabetic}]+" options:0 error:nil];
    
    NSRange range = [self.string paragraphRangeForRange:self.editedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:range];
    
    [iExpression enumerateMatchesInString:self.string options:0 range:range usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:result.range];
    }];
    [super processEditing];
}

@end
