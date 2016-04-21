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
#import "CustomFooter.h"

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
    UIImageView * background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_bg.jpg"]];
    self.tableView.backgroundView = background;
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
    
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * backgroundCell = [[CustomCellBackground alloc] init];
        cell.backgroundView = backgroundCell;
    }
    
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * selectedBackgroundCell = [[CustomCellBackground alloc] init];
        selectedBackgroundCell.selected = YES;
        cell.selectedBackgroundView = selectedBackgroundCell;
    }
    
    NSString * entry;
    
    if (indexPath.section == 0) {
        entry = self.thingsToLearn[indexPath.row];
        ((CustomCellBackground *) cell.backgroundView).lastCell = indexPath.row == self.thingsToLearn.count - 1;
        ((CustomCellBackground *)cell.selectedBackgroundView).lastCell = indexPath.row == self.thingsToLearn.count - 1;
    } else {
        entry = self.thingsLearned[indexPath.row];
        ((CustomCellBackground *)cell.backgroundView).lastCell = indexPath.row == self.thingsLearned.count - 1;
        ((CustomCellBackground *)cell.selectedBackgroundView).lastCell = indexPath.row == self.thingsLearned.count - 1;
    }
    
    cell.textLabel.text = entry;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
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


-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[CustomFooter alloc] init];
}
@end
