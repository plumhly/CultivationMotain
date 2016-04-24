//
//  ViewController.m
//  RageTweet
//
//  Created by Brian Douglas Moakley on 2/22/13.
//  Copyright (c) 2013 Razeware, LLC. All rights reserved.
//

#import <Social/Social.h>
#import "ViewController.h"
#import "SkyView.h"
#import "ContainerScrollView.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet ContainerScrollView * containerScrollView;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) NSArray * ragePhotos;
@property (nonatomic, strong) NSArray * tweets;
@property (nonatomic, weak) IBOutlet SkyView * skyView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // This is the data ... should really be in a model object.
    
    self.ragePhotos = @[[UIImage imageNamed:@"happy.png"],
                        [UIImage imageNamed:@"content.png"],
                        [UIImage imageNamed:@"no-amused.png"],
                        [UIImage imageNamed:@"irked.png"],
                        [UIImage imageNamed:@"raging.png"]];
    
    self.tweets = @[@"The world is my oyster - raw, wriggling, and danglng from my mouth.",
                    @"Get down with your bad self!",
                    @"Hmm ... Not good, not bad.  Not happy.  Not sad.",
                    @"Core breach imminent - stand back before I go thermonuclear",
                    @"FFFFFFFUUUUUUUUU!!!!1!!!"];
    
    
    NSInteger totalPhotos = self.ragePhotos.count;
    NSInteger gapDistance  = 300;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;

    // These values are hard coded to account for the different iPhone screen sizes.
    // In an an ideal world, the should be dynamically generated.
    
    // The values determine the internal scrollview size which in turn, determines the
    // amount of horizonal pagination.
    
    if (screenSize.height > 480) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(185, -55, 300, 201)];
    } else {
        gapDistance = 240;
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(155, -35, 240, 201)];
    }

    self.scrollView.pagingEnabled = YES;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    // This bit creates the rage face buttons and adds them to the scroll view.
    
    for (NSInteger counter = 0; counter < totalPhotos; counter++) {
        NSInteger gap = counter * gapDistance;
        UIImage * image = self.ragePhotos[counter];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.height / 2 - imageView.frame.size.height / 2 + gap , self.scrollView.frame.size.width / 2 - imageView.frame.size.width / 2, imageView.frame.size.width, imageView.frame.size.height)];
        button.tag = counter;
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
    }
    self.scrollView.contentSize = CGSizeMake(1510, 100);
    self.containerScrollView.scrollView = self.scrollView;
    
}

-(void) sendMessage: (UIButton *) sender
{
    // This opens us the tweet view controller so users can tweet.  See Learning Twitter on www.raywenderlich.com for more info.
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController * tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:self.tweets[sender.tag]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        // If Twitter isn't accessible, then output a funny message instead.  
        
        NSString * message = nil;
        if (sender.tag < 3) {
            message = @"Please open your nearest window and whisper sweet nothings to the first passerby.";
        } else if (sender.tag == 3) {
            message = @"Please turn to the mirror and pick your nose.";
        } else {
            message = @"Please open your nearest window and rage away.";
        }
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Twitter Unavailable" message:@"Please turn to your nearest mirror and rage away" delegate:nil cancelButtonTitle:@"Thanks!" otherButtonTitles:nil];
        [alertView show];
    }
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageNum = (int) (scrollView.contentOffset.x / scrollView.frame.size.width);
    self.skyView.rageLevel = pageNum;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
