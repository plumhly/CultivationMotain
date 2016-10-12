//
//  ViewController.m
//  CoreDataTest
//
//  Created by plum on 16/10/12.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "DeviceDetailViewController.h"

#import "AppDelegate.h"

@interface DeviceDetailViewController ()


@end

@implementation DeviceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.deviceInfo) {
        self.nameTextField.text = [self.deviceInfo valueForKey:@"name"];
        self.versionTextField.text = [self.deviceInfo valueForKey:@"version"];
        self.company.text = [self.deviceInfo valueForKey:@"company"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *contex = delegate.persistentContainer.viewContext;
    return contex;
}



- (IBAction)cacel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    if (self.deviceInfo) {
        [self.deviceInfo setValue:self.nameTextField.text forKey:@"name"];
        [self.deviceInfo setValue:self.versionTextField.text forKey:@"version"];
        [self.deviceInfo setValue:self.company.text forKey:@"company"];
    } else {
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
        [newDevice setValue:self.nameTextField.text forKey:@"name"];
        [newDevice setValue:self.versionTextField.text forKey:@"version"];
        [newDevice setValue:self.company.text forKey:@"company"];
    }
    if (context.hasChanges) {
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"save error");
        };
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
