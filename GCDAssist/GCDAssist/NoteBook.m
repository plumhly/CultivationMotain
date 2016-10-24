//
//  NoteBook.m
//  GCDAssist
//
//  Created by libo on 16/10/3.
//  Copyright © 2016年 libo. All rights reserved.
//

#import "NoteBook.h"

@interface NoteBook ()

- (void)good1;

@end

@interface NoteBook ()

- (void)good2;
@end

@implementation NoteBook

- (void)note {
//    NSString *apple = @"apple";
//    NSString  __autoreleasing *org = apple;
//    int pp = 0;
//    NSString **t = &org;
//
    /*
    dispatch_function_t
    typedef void (*dispatch_function_t)(void *_Nullable);
     */
    
    union test {
        int i;
        char c;
    } *p;
    p->i = 1;
    NSLog(@"%c",p->c);
}

//demo1

- (void) demo1
{
    NSLog(@"Strong local passed by autoreleasing reference");
    NSString *local = @"apple";
    NSLog(@"local: addr %p, contains %p - %@", &local, local, local);
    [self indirectWrapper:&local];
    NSLog(@"local: addr %p, contains %p - %@", &local, local, local);
}

- (void) indirect:(NSString **)byRef                  // __autoreleasing inferred
{
    *byRef = @"banana";
}

- (void) indirectWrapper:(NSString **)byRef           // __autoreleasing inferred
{
    NSLog(@"indirect: passed reference %p, contains %p - %@", byRef, *byRef, *byRef);
    [self indirect:byRef];
    NSLog(@"indirect: returned");
    
    
}


//demo2

- (void) strongIndirect:(NSString * __strong *)byRef
{
    *byRef = @"plum";
}

- (void) strongIndirectWrapper:(NSString * __strong *)byRef
{
    NSLog(@"strongIndirect: passed reference %p, contains %p - %@", byRef, *byRef, *byRef);
    [self strongIndirect:byRef];
    NSLog(@"strongIndirect: returned");
}

+ (NSString *)newHelloWorldString {
    return [[NSString alloc] initWithCString:"HelloWorld" encoding:NSUTF8StringEncoding];
}

+ (NSString *)helloWorldString {
    return [[NSString alloc] initWithCString:"HelloWorld" encoding:NSUTF8StringEncoding];
}


@end
