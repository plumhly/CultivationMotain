//
//  main.m
//  GCDAssist
//
//  Created by libo on 16/10/3.
//  Copyright © 2016年 libo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteBook.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
         int A;
        volatile int B;
        A = B + 1;
        B = 0;
        NSLog(@"");
        [[NoteBook new ] demo1];
        
        NSString *apple = @"apple";
        NSString *  __strong *t = &apple;
        NSLog(@"\n apple=%p \n &apple=%p \n t=%p \n *t=%p \n &t=%p",apple, &apple,t,*t,&t);
        
        int a = 2;
        int *p = &a;
        int **d = &p;
        NSLog(@"");
    }
    return 0;
    NSURLCache *c = [NSURLCache sharedURLCache];
    
   
}
