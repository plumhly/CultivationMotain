//
//  main.m
//  MacroTest
//
//  Created by libo on 16/9/25.
//  Copyright © 2016年 libo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Class2.h"

#define MY_MACRO(x)  {	/* line 1 */	/* line 2 */	/* line 3 */ }
#define Min(X,Y) ({typeof(X)_x = X; typeof(Y)_y = Y; _x < _y ? _x : _y;})
//#define Min(x,y) ((x) < (y) ? (x) : (y))


#define YOU @"ni"
//#undef YOU

#define STRINGINIT [[NSString alloc] init]

extern void foo(void);

//#define foo()

#define plum(x) NSStrin#x

#define xstr(s) str(s)
#define str(s) #s
//#define foo (foo + 4)
#define strange(file) fprintf (file, "%s %d",

#define foo  (2,7)
#define bar(x) lose(x)
#define lose(x) (1 + (x))
#define charx(x) @#x

#define MIN(A,B) ({((A) < (B) ? (A) : (B));})

int xx = 0;
int good(int x);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        if (/* DISABLES CODE */ (YES)) {
            MY_MACRO(2);
        } else {
            NSLog(@"");
        }
        int x = Min(2, 4);
        
        int y = Min(4, good(1));
        
//        NSString *go = [[plum(g) alloc]init];
        
        NSString *t = YOU;
        NSString *s = STRINGINIT;
        
        
//       char *ch = xstr(foo);/
//        char *ch2 = str(foo);
        
        
        [Class2 test];
        char *p = "9";
        //    strange(stderr) p, 35);
        fprintf (stderr, "%s %d",p, 35);
        int gg = (7,0,5);
//        int dd = lose(2,3);
        NSString *gdds = charx(s);
        
        float a = 1.0f;
        int ggd = MIN(a++, 1.5f);
        NSLog(@"");
    }
    
    
    
    return 0;
}
int good (int x) {
    return xx += x;
}
