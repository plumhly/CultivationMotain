//
//  LayoutViewController.m
//  TextKit_Ex
//
//  Created by plum on 2017/9/26.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "LayoutViewController.h"
#import "PMTextStorage.h"
#import "PLLayoutManager.h"

@interface LayoutViewController ()<NSLayoutManagerDelegate>

@property (nonatomic, strong) PMTextStorage *textStorage;

@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textStorage = [PMTextStorage new];
    
    PLLayoutManager *manager = [PLLayoutManager new];
    [_textStorage addLayoutManager:manager];
    
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeZero];
    [manager addTextContainer:container];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectInset(self.view.bounds, 5, 20) textContainer:container];
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    manager.delegate = self;
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    textView.translatesAutoresizingMaskIntoConstraints = YES;
    [self.view addSubview:textView];
    [_textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"layout" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect {
    return glyphIndex / 100.0;
}

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager paragraphSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect {
    return 10;
}

//是否换行处在url当中
- (BOOL)layoutManager:(NSLayoutManager *)layoutManager shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex {
    NSRange range;
    NSURL *url = [_textStorage attribute:NSLinkAttributeName atIndex:charIndex effectiveRange:&range];
    if (url && range.location < charIndex && range.length >= charIndex) {
        return NO;
    }
    return YES;
}

@end
