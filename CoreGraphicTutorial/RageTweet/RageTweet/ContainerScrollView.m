//
//  ContainerScrollView.m
//  RageTweet
//
//  Created by Brian Douglas Moakley on 3/1/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "ContainerScrollView.h"

@implementation ContainerScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// If this view is being touched, then it will return its child scroll view.  This allows for you to create a scroll view
// that is both wide as the device and tall while still preserving the smaller pagination.  

-(UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView * child = [super hitTest:point withEvent:event];
    if (child == self) {
        return self.scrollView;
    }
    return child;
}

// This property is overriden so that the child scroll view is added to the view tree.

-(void) setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    [self addSubview:scrollView];
}


@end
