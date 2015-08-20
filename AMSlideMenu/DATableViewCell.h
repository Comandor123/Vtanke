//
//  DATableViewCell.h
//  AMSlideMenu
//
//  Created by Егор on 8/22/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DATableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Family;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
