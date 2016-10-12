//
//  ViewController.h
//  CoreDataTest
//
//  Created by plum on 16/10/12.
//  Copyright © 2016年 plum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DeviceDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *versionTextField;

@property (weak, nonatomic) IBOutlet UITextField *company;

@property (nonatomic, strong) NSManagedObject *deviceInfo;
@end

