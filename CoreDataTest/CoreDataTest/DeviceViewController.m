//
//  DeviceViewController.m
//  CoreDataTest
//
//  Created by plum on 16/10/12.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "DeviceViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "DeviceDetailViewController.h"

@interface DeviceViewController ()

@property (nonatomic, strong) NSMutableArray *devices;

@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.devices = [NSMutableArray array];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSManagedObjectContext *contex = [self managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Device"];
    NSError *error;
    NSAsynchronousFetchResult *result = (NSAsynchronousFetchResult *)[contex executeRequest:request error:&error];
    NSArray *array = result.finalResult;
    if (!error) {
        _devices = [array mutableCopy];
    }
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    [self.tableView reloadData];
}


- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *contex = delegate.persistentContainer.viewContext;
    return contex;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.devices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSManagedObject *object = self.devices[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",[object valueForKey:@"name"],[object valueForKey:@"version"]];
    cell.detailTextLabel.text = [object valueForKey:@"company"];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObject *object = self.devices[indexPath.row];
        [context deleteObject:object];
        if (context.hasChanges) {
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"数据保存失败");
            }
        }
        [self.devices removeObject:object];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"select"]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *cell = (UITableViewCell *)sender;
            NSIndexPath *path = [self.tableView indexPathForCell:cell];
            DeviceDetailViewController *vc = segue.destinationViewController;
            vc.deviceInfo = self.devices[path.row];
        }
        
    }
}


@end
