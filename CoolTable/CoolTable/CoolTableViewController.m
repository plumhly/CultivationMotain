//
//  CoolTableViewController.m
//  CoolTable
//
//  Created by plum on 16/4/18.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "CoolTableViewController.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"

@interface CoolTableViewController ()

@property (copy) NSMutableArray *thingsToLearn;
@property (copy) NSMutableArray *thingsLearned;
@end

@implementation CoolTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Core Graphics 101";
    self.thingsToLearn = [@[@"Drawing Rects", @"Drawing Gradients", @"Drawing Arcs"] mutableCopy];
    self.thingsLearned = [@[@"Table Views", @"UIKit", @"Objective-C"] mutableCopy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.thingsToLearn.count;
    } else {
        return self.thingsLearned.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString * entry;
    
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        cell.backgroundView = [[CustomCellBackground alloc] init];
    }
    
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    }
    if (indexPath.section == 0) {
        entry = self.thingsToLearn[indexPath.row];
    } else {
        entry = self.thingsLearned[indexPath.row];
    }
    cell.textLabel.text = entry;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Things We'll Learn";
    } else {
        return @"Things Already Covered";
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CustomHeader * header = [[CustomHeader alloc] init];
    header.titleLabel.text = [self tableView: tableView titleForHeaderInSection:section];
    // START NEW
    if (section == 1) {
        header.lightColor = [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:216.0/255.0 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:72.0/255.0 green:22.0/255.0 blue:137.0/255.0 alpha:1.0];
    }
    // END NEW
    return header;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

@end
