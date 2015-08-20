//
//  DAChancheTankViewController.m
//  VTanke
//
//  Created by Егор on 9/4/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAChancheTankViewController.h"
#import "VKNetworkingVK.h"
@interface DAChancheTankViewController ()
@property(weak, nonatomic) VKNetworkingVK *networking;
@end

@implementation DAChancheTankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networking = [VKNetworkingVK sharedInstance];
    [self.secmentCounryTwo setEnabled:YES];
    [self.secmentCounry setEnabled:YES];
    [self.segmentTypeOTwo setEnabled:YES];
    [self.segmentTypeOne setEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)spisokControll:(id)sender
{
    if ([[self.segmentTypeOne titleForSegmentAtIndex:self.segmentTypeOne.selectedSegmentIndex] isEqualToString:@"none"]) {
        [self.segmentTypeOne setEnabled:NO];
    }
    
    if ([[self.segmentTypeOTwo titleForSegmentAtIndex:self.segmentTypeOTwo.selectedSegmentIndex] isEqualToString:@"none"]) {
        [self.segmentTypeOTwo setEnabled:NO];
    }
    
    if ([[self.secmentCounry titleForSegmentAtIndex:self.secmentCounry.selectedSegmentIndex] isEqualToString:@"none"]) {
        [self.secmentCounry setEnabled:NO];
    }
    if ([[self.secmentCounryTwo titleForSegmentAtIndex:self.secmentCounryTwo.selectedSegmentIndex] isEqualToString:@"none"]) {
        [self.secmentCounryTwo setEnabled:NO];
    }
    
    if ([[self.segmentLevel titleForSegmentAtIndex:self.segmentLevel.selectedSegmentIndex] isEqualToString:@"-"]) {
        [self.segmentLevel setEnabled:NO];
    }
    
    
    if (self.segmentTypeOTwo.isEnabled == NO)
    {
          self.networking.type = [self.segmentTypeOne titleForSegmentAtIndex:self.segmentTypeOne.selectedSegmentIndex];
    }
    if (self.segmentTypeOne.isEnabled == NO)
    {
        self.networking.type = [self.segmentTypeOTwo titleForSegmentAtIndex:self.segmentTypeOTwo.selectedSegmentIndex];
    }
    
    if (self.secmentCounry.isEnabled == NO)
    {
        self.networking.country = [self.secmentCounryTwo titleForSegmentAtIndex:self.secmentCounryTwo.selectedSegmentIndex];
    }
    if (self.secmentCounryTwo.isEnabled == NO)
    {
        self.networking.country = [self.secmentCounry titleForSegmentAtIndex:self.secmentCounry.selectedSegmentIndex];
    }
    
    if (self.segmentLevel.isEnabled == YES) {
    self.networking.level = [[self.segmentLevel titleForSegmentAtIndex:self.secmentCounry.selectedSegmentIndex] integerValue];
    }
}

- (IBAction)valueChangedCountrySegment:(id)sender {
    if (sender == self.secmentCounry) {
        [self.secmentCounryTwo setEnabled:NO];
    }
    if (sender == self.secmentCounryTwo) {
        [self.secmentCounry setEnabled:NO];
    }
    if ([[self.secmentCounry titleForSegmentAtIndex:self.secmentCounry.selectedSegmentIndex] isEqualToString:@"none"]) {
        [self.secmentCounryTwo setEnabled:YES];
    }
    if ([[self.secmentCounryTwo titleForSegmentAtIndex:self.secmentCounryTwo.selectedSegmentIndex] isEqualToString:@"none"]) {
        [self.secmentCounry setEnabled:YES];
    }
}

- (IBAction)valueChangedType:(id)sender
{
    if (sender == self.segmentTypeOne) {
        [self.segmentTypeOTwo setEnabled:NO];
    }
    if (sender == self.segmentTypeOTwo) {
        [self.segmentTypeOne setEnabled:NO];
    }
    
    if ([[self.segmentTypeOne titleForSegmentAtIndex:self.segmentTypeOne.selectedSegmentIndex] isEqualToString:@"none"]) {
        [self.segmentTypeOTwo setEnabled:YES];
    }
    
    if ([[self.segmentTypeOTwo titleForSegmentAtIndex:self.segmentTypeOTwo.selectedSegmentIndex] isEqualToString:@"none"]) {
        [self.segmentTypeOne setEnabled:YES];
    }
}
@end
