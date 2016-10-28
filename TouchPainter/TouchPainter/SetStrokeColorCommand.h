//
//  SetStrokeColorCommand.h
//  TouchPainter
//
//  Created by libo on 16/10/28.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "Command.h"
#import "SetStrokeColorCommandDelegate.h"

@interface SetStrokeColorCommand : Command

@property (weak, nonatomic) id <SetStrokeColorCommandDelegate> delegate;


- (void)execute;
@end
