//
//  Packet.m
//  Socket_Client
//
//  Created by sigma-td on 2017/3/16.
//  Copyright © 2017年 libo. All rights reserved.
//

#import "Packet.h"

NSString *const PocketKeyData   = @"data";
NSString *const PocketKeyType   = @"type";
NSString *const PocketKeyAction = @"action";

@implementation Packet


- (instancetype)initWithData:(id)data type:(PocketAction)type action:(PocketAction)action {
    if (self = [super init]) {
        self.data = data;
        self.type = type;
        self.action = action;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder  {
    if (self = [super init]) {
        self.data = [aDecoder decodeObjectForKey:PocketKeyData];
        self.type = [aDecoder decodeIntegerForKey:PocketKeyType];
        self.action = [aDecoder decodeIntegerForKey:PocketKeyAction];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.data forKey:PocketKeyData];
    [aCoder encodeInteger:self.type forKey:PocketKeyType];
    [aCoder encodeInteger:self.type forKey:PocketKeyType];
}

@end
