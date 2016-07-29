//
//  PlumThread.h
//  MultiThreadFun
//
//  Created by plum on 16/7/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlumThread : NSThread

@property (strong, nonatomic, readonly) NSString *authorName;

@end
