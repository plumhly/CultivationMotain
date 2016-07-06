//
//  RWViewController.m
//  RWReactivePlayground
//
//  Created by Colin Eberhardt on 18/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWViewController.h"
#import "RWDummySignInService.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;


@property (strong, nonatomic) RWDummySignInService *signInService;

@end

@implementation RWViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.signInService = [RWDummySignInService new];
  
  // handle text changes for both text fields
  
  // initially hide the failure message
//  self.signInFailureText.hidden = YES;
//    [[self.usernameTextField rac_textSignal] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//    RACSignal *signal = [self.usernameTextField rac_textSignal];
//    RACSignal *filterSignal = [signal filter:^BOOL(id value) {
//        NSString *text = value;
//        return text.length > 3;
//    }];
//    [filterSignal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//    [[[self.usernameTextField.rac_textSignal map:^id(NSString *text) {
//        return @(text.length);
//    }]
//     filter:^BOOL(NSNumber *length) {
//        return length.integerValue > 3;
//    }]
//    subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    RACSignal *validUsernameSignal = [self.usernameTextField.rac_textSignal map:^id(NSString *value) {
        return @([self isValidUsername:value]);
    }];
    
    RACSignal *validPassedWordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString *value) {
        return @([self isValidPassword:value]);
    }];
    
//    [[validPassedWordSignal map:^id(NSNumber *value) {
//        return [value boolValue] ? [UIColor clearColor] : [UIColor redColor];
//    }] subscribeNext:^(UIColor *x) {
//        self.passwordTextField.backgroundColor = x;
//    }] ;
    
    RAC(self.usernameTextField, backgroundColor) = [validUsernameSignal map:^id(NSNumber *value) {
        return [value boolValue] ? [UIColor clearColor] : [UIColor redColor];
    }];
    
    RAC(self.passwordTextField, backgroundColor) = [validPassedWordSignal map:^id(NSNumber *value) {
        return [value boolValue] ? [UIColor clearColor] : [UIColor redColor];
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validUsernameSignal, validPassedWordSignal] reduce:^id (NSNumber *userValid, NSNumber *passedWordValid){
        return @([userValid boolValue] && [passedWordValid boolValue]);
    }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber *x) {
        self.signInButton.enabled = [x boolValue];
    }];
    
    [[[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
          self.signInButton.enabled = NO;
          self.signInFailureText.hidden = YES;
      }]
      flattenMap:^RACStream *(id value) {
        return [self signInSignal];
    }]
    subscribeNext:^(NSNumber *success) {
        BOOL is = [success boolValue];
        self.signInFailureText.hidden = is;
        if (is) {
            [self performSegueWithIdentifier:@"signInSuccess" sender:self];
        }
        NSLog(@"%@",success);
    }];
}

- (BOOL)isValidUsername:(NSString *)username {
  return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
  return password.length > 3;
}

- (RACSignal *)signInSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.signInService signInWithUsername:self.usernameTextField.text password:self.passwordTextField.text complete:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
@end
