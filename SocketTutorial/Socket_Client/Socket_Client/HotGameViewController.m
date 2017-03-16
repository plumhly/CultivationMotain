//
//  HotGameViewController.m
//  Socket_Client
//
//  Created by libo on 2017/3/14.
//  Copyright © 2017年 libo. All rights reserved.
//

#import "HotGameViewController.h"
#import "GCDAsyncSocket.h"
#import <CFNetwork/CFNetwork.h>
#import "Packet.h"

@interface HotGameViewController ()<GCDAsyncSocketDelegate, NSNetServiceDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;
@property (nonatomic, strong) NSNetService *netService;

@end


@implementation HotGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
    [self startBroadcast];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
}

- (void)startBroadcast {
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    if ([_socket acceptOnPort:0 error:&error]) {
        _netService = [[NSNetService alloc]initWithDomain:@"local." type:@"_fourinarow._tcp." name:@"" port:_socket.localPort];
        _netService.delegate = self;
        [_netService publish];
    } else {
        NSLog(@"Unable to create socket Error: %@", error);
    }
}

- (void)cancel:(id)sender {
    //TODO
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendPocket:(Packet *)pocket {
    NSMutableData *data = [NSMutableData new];
    NSKeyedArchiver *archier = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archier encodeObject:pocket forKey:@"packet"];
    [archier finishEncoding];
    
    NSMutableData *buffer = [NSMutableData new];
    uint64_t length = data.length;
    [buffer appendBytes:&length length:sizeof(uint64_t)];
    [buffer appendBytes:[data bytes] length:length];
    
    [self.socket writeData:buffer withTimeout:-1 tag:0];
}

#pragma mark - NSNetServiceDelegate 

- (void)netServiceDidPublish:(NSNetService *)sender {
    NSLog(@"Bonjour service publish: domain: %@\n type: %@\n name: %@ \n port: %li",sender.domain, sender.type, sender.name, (long)sender.port);
}

- (void)netService:(NSNetService *)sender didNotPublish:(NSDictionary<NSString *,NSNumber *> *)errorDict {
    NSLog(@"Not service publish: domain: %@\n type: %@\n name: %@ \n Error: %@",sender.domain, sender.type, sender.name, errorDict);
}

#pragma mark - GCDAsyncSocketDelegate

/*
  Because we only allow one connection at a time in our application, we discard the old (listening) socket and store a reference to the new socket in the socket property.
 */
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    NSLog(@"Accept new socket from: domain (%@) port (%hu)", newSocket.localHost, newSocket.localPort);
    _socket = newSocket;
    [_socket readDataToLength:sizeof(uint64_t) withTimeout:-1 tag:0];
    
    //create pocket
    NSString *me = @"Hello developer";
    Packet *poc = [[Packet alloc]initWithData:me type:0 action:0];
    [self sendPocket:poc];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (_socket == sock) {
        self.socket.delegate = nil;
        self.socket = nil;
    }
}



@end
