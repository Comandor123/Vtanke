//
//  DAChangeTankTableViewController.h
//  VTanke
//
//  Created by Егор on 9/18/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAChangeTankTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerVIew;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *countryCell;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *typeCell;

@end
