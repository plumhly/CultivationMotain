//
//  JoinGameViewController.m
//  Socket_Client
//
//  Created by sigma-td on 2017/3/15.
//  Copyright © 2017年 libo. All rights reserved.
//

#import "JoinGameViewController.h"
#import "GCDAsyncSocket.h"

#warning Remember that Bonjour is not responsible for creating the connection. Bonjour only provides us with the information necessary to establish a connection.

static NSString *cellId = @"cell";
@interface JoinGameViewController ()<GCDAsyncSocketDelegate, NSNetServiceBrowserDelegate, NSNetServiceDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;
@property (nonatomic, strong) NSMutableArray *services;
@property (nonatomic, strong) NSNetServiceBrowser *serviceBrowser;


@end

@implementation JoinGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self startBrowsing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
}

- (void)cancel:(id)sender {
    [self stopBrowsing];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)startBrowsing {
    if (_services.count > 0) {
        [_services removeAllObjects];
    } else {
        _services = [NSMutableArray array];
    }
    self.serviceBrowser = [[NSNetServiceBrowser alloc]init];
    self.serviceBrowser.delegate = self;
    [self.serviceBrowser searchForServicesOfType:@"_fourinarow._tcp." inDomain:@"local."];
}

- (void)stopBrowsing {
    if (self.serviceBrowser) {
        [self.serviceBrowser stop];
        self.serviceBrowser.delegate = nil;
        self.serviceBrowser = nil;
    }
}

- (BOOL)connectWithService:(NSNetService *)service {
    BOOL isConnect = NO;
    NSArray *address = [[service addresses] mutableCopy];
    if (!_socket.isConnected) {
        self.socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        while (!isConnect || address.count) {
            NSData *data = address.firstObject;
            NSError *error = nil;
            if ([self.socket connectToAddress:data error:&error]) {
                isConnect = YES;
            } else {
                NSLog(@"Unable to connect to Adress with error: %@ , userInfo: %@", error, error.userInfo);
            }
            
        }
    } else {
        isConnect = [self.socket isConnected];
    }
    return  isConnect;
}

#pragma mark - NSNetServiceBrowserDelegate

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing {
    [_services addObject:service];
    if (!moreComing) {
        
        [_services sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        //update tableview
        [self.tableView reloadData];
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing {
    [_services removeObject:service];
    if (!moreComing) {
        [self.tableView reloadData];
    }
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)browser {
    [self startBrowsing];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didNotSearch:(NSDictionary<NSString *,NSNumber *> *)errorDict {
    [self startBrowsing];
}

#pragma mark - NSNetServiceDelegate

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary<NSString *,NSNumber *> *)errorDict {
    sender.delegate = nil;
}

- (void)netServiceDidResolveAddress:(NSNetService *)sender {
    //connet the service
    if ([self connectWithService:sender]) {
        NSLog(@"Did Connect with Service: domain(%@) type(%@) name(%@) port(%i)", [sender domain], [sender type], [sender name], (int)[sender port]);
    } else {
        NSLog(@"Unable to Connect with Service: domain(%@) type(%@) name(%@) port(%i)", [sender domain], [sender type], [sender name], (int)[sender port]);
    }
}

#pragma mark - GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"Socket Did connect to host %@, Port: %hu", host, port);
    [sock readDataToLength:sizeof(uint64_t) withTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    sock.delegate = nil;
    self.socket = nil; //socket = nil;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.services.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.services.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    // Configure the cell...
    if (indexPath.row < _services.count) {
        NSNetService *service = _services[indexPath.row];
        cell.textLabel.text = service.name;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNetService *service = _services[indexPath.row];
    service.delegate = self;
    [service resolveWithTimeout:30.0];
}
 

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
