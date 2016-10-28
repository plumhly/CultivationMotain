//
//  CommandSlider.h
//  TouchPainter
//
//  Created by libo on 16/10/28.
//  Copyright © 2016年 plum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Command.h"

@interface CommandSlider : UISlider

@property (weak, nonatomic) IBOutlet Command *command;

@end
