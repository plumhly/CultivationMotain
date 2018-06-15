//
//  Created by Colin Eberhardt on 23/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

@import UIKit;

@class RWTSearchResultsViewModel;

@interface RWTSearchResultsViewController : UIViewController

- (instancetype)initWithViewModel:(RWTSearchResultsViewModel *)viewModel;

- (void)setParallax:(CGFloat)value;

@end
