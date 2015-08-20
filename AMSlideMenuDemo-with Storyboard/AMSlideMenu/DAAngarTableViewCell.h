//
//  DAAngarTableViewCell.h
//  VTanke
//
//  Created by Егор on 9/19/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAAngarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameTank;
@property (weak, nonatomic) IBOutlet UILabel *battlesTank;
@property (weak, nonatomic) IBOutlet UIImageView *imageTank;
@property (weak, nonatomic) IBOutlet UILabel *winsTank;

@end
