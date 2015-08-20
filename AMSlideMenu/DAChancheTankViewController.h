//
//  DAChancheTankViewController.h
//  VTanke
//
//  Created by Егор on 9/4/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAChancheTankViewController : UIViewController
- (IBAction)spisokControll:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *secmentCounry;
@property (weak, nonatomic) IBOutlet UISegmentedControl *secmentCounryTwo;



@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentLevel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentTypeOne;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentTypeOTwo;


- (IBAction)valueChangedCountrySegment:(id)sender;
- (IBAction)valueChangedType:(id)sender;


@end
