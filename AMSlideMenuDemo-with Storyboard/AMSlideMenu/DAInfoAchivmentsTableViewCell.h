//
//  DAInfoAchivmentsTableViewCell.h
//  VTanke
//
//  Created by Егор on 9/8/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAInfoAchivmentsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageAchiment;
@property (weak, nonatomic) IBOutlet UILabel *nameSectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameAchivmentsLAbel;
@property (weak, nonatomic) IBOutlet UILabel *countAchivments;
@property (weak, nonatomic) IBOutlet UILabel *discriptionAchivments;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
- (IBAction)actionSharing:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorSharing;
@property (weak, nonatomic) IBOutlet UIButton *actionSharing;

@end
