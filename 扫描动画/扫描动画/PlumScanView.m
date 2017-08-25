//
//  PlumView.m
//  Test
//
//  Created by plum on 2017/8/25.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "PlumScanView.h"

@interface PlumScanView ()

@property (nonatomic, strong) UIImageView *scanLineImageView;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) BOOL directionUp;





@end

@implementation PlumScanView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImage *image = [UIImage imageNamed:@"image_clzd_1_press"];
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, image.size.width, image.size.height);
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image_clzd_1_press"]];
        
        _scanLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_clzd_smx"]];
        _scanLineImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scanLineImageView];
        
        //居中
        CGRect scanLineFrame = _scanLineImageView.frame;
        scanLineFrame.origin.x = (image.size.width - scanLineFrame.size.width) / 2.0;
        _scanLineImageView.frame = scanLineFrame;
        
        _currentColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image_clzd_1_normal"]];
        
        [NSTimer scheduledTimerWithTimeInterval:0.03
                                                      target:self
                                       selector:@selector(animateWave:)
                                                    userInfo:nil
                                                     repeats:YES];
    }
    return self;
}

+ (instancetype)scanView {
    return [[self alloc] initWithFrame:CGRectMake(150, 200, 0, 0)];
}

- (void)animateWave:(NSTimer *)timer
{
    if (_isEnd) {
        [timer invalidate];
    } else {
        if ( _waveHeight < 0 ) {
            _directionUp = YES;
        } else if ( _waveHeight > self.frame.size.height ) {
            _directionUp = NO;
        }
        CGRect frame = _scanLineImageView.frame;
        frame.origin.y = _waveHeight - 5;
        _scanLineImageView.frame = frame;
        
        if (_directionUp) {
            _waveHeight ++;
        } else {
            _waveHeight --;
        }
        [self setNeedsDisplay];
    }

}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _currentColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, _waveHeight, rect.size.width, rect.size.height - _waveHeight));
}

- (void)dealloc {
    NSLog(@"PlumScanView dealloc");
}

@end
