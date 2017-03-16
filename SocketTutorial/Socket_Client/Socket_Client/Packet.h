//
//  Packet.h
//  Socket_Client
//
//  Created by sigma-td on 2017/3/16.
//  Copyright © 2017年 libo. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const PocketKeyData;
extern NSString *const PocketKeyType;
extern NSString *const PocketKeyAction;

typedef NS_ENUM(NSInteger, PacketType) {
    PacketTypeUnknown = -1,
};

typedef NS_ENUM(NSUInteger, PocketAction) {
    PocketActionUnknown = -1,
};



@interface Packet : NSObject <NSCoding>

@property (nonatomic, strong) id data;
@property (nonatomic, assign) PacketType type;
@property (nonatomic, assign) PocketAction action;

- (instancetype)initWithData:(id)data type:(PocketAction)type action:(PocketAction)action;


@end
