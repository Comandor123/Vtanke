//
//  SravnenieTableViewCell.h
//  AMSlideMenu
//
//  Created by Егор on 8/26/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SravnenieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myNickLabel;
@property (weak, nonatomic) IBOutlet UILabel *aponentNickLabel;
@property (weak, nonatomic) IBOutlet UILabel *parametr;
@property (weak, nonatomic) IBOutlet UILabel *myValue;
@property (weak, nonatomic) IBOutlet UILabel *aponentValue;

@end
