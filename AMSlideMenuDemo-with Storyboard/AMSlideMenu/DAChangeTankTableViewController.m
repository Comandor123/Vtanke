//
//  DAChangeTankTableViewController.m
//  VTanke
//
//  Created by Егор on 9/18/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAChangeTankTableViewController.h"
#import "VKNetworkingVK.h"

@interface DAChangeTankTableViewController ()
@property(weak, nonatomic) VKNetworkingVK *networking;
@property (strong, nonatomic) UIColor *myColorBlack;
@property (strong, nonatomic) UIColor *myColorBlue;
@property (strong, nonatomic) UIColor *myColorRed;
@property (strong, nonatomic) UIColor *myColorWhite;
@property (strong, nonatomic) UIColor *myColorBrown;
@end

@implementation DAChangeTankTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
    }
    return self;
}

- (void) loadView {
    
    [super loadView];
    self.myColorBlack = [UIColor colorWithRed:15.f / 255.f green:14.f / 255.f blue:15.f / 255.f alpha:1.0];
    self.myColorBlue = [UIColor colorWithRed:31.f / 255.f green:51.f / 255.f blue:82.f / 255.f alpha:1.0];
    self.myColorRed = [UIColor colorWithRed:220.f / 255.f green:54.f / 255.f blue:16.f / 255.f alpha:1.0];
    self.myColorBrown = [UIColor colorWithRed:217.f / 255.f green:203.f / 255.f blue:158.f / 255.f alpha:1.0];
    self.myColorWhite = [UIColor whiteColor];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.networking = [VKNetworkingVK sharedInstance];
    self.pickerVIew.delegate = self;
    self.pickerVIew.dataSource =self;
    [self.networking.country removeAllObjects];
    [self.networking.type removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark -   UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.section == 0) {


        UITableViewCell *cellCountry = [self.countryCell objectAtIndex:indexPath.row];

        if (cellCountry.editing == NO ) {
            [[self.countryCell objectAtIndex:indexPath.row] setEditing:YES animated:YES];
            if (indexPath.row == 0)
            {            [self.networking.country addObject:@"usa"];
                
            }
            if (indexPath.row == 1)
            {[self.networking.country addObject:@"germany"];
            }
            
            if (indexPath.row == 2)
            {
                [self.networking.country addObject:@"france"];
            }
            if (indexPath.row == 3)
            {[self.networking.country addObject:@"ussr"];
            }
            if (indexPath.row == 4)
            {[self.networking.country addObject:@"japan"];
            }
            if (indexPath.row == 5)
            {[self.networking.country addObject:@"china"];
            }
            if (indexPath.row == 6)
            {[self.networking.country addObject:@"gb"];
            }
            if (indexPath.row == 7)
            {[self.networking.country addObject:@"none"];
            }
            return;
        }
        if (cellCountry.editing == YES) {
            [[self.countryCell objectAtIndex:indexPath.row] setEditing:NO animated:YES];
            if (indexPath.row == 0)
            {            [self.networking.country removeObject:@"usa"];
                
            }
            if (indexPath.row == 1)
            {[self.networking.country removeObject:@"germany"];
            }
            
            if (indexPath.row == 2)
            {[self.networking.country removeObject:@"france"];
            }
            if (indexPath.row == 3)
            {[self.networking.country removeObject:@"ussr"];
            }
            if (indexPath.row == 4)
            {[self.networking.country removeObject:@"japan"];
            }
            if (indexPath.row == 5)
            {[self.networking.country removeObject:@"china"];
            }
            if (indexPath.row == 6)
            {[self.networking.country removeObject:@"gb"];
            }
            if (indexPath.row == 7)
            {[self.networking.country removeObject:@"none"];
            }
            return;
        }
    }
    if (indexPath.section == 2) {
      

        UITableViewCell *cellType = [self.typeCell objectAtIndex:indexPath.row];

        if (cellType.editing == NO ) {
            [[self.typeCell objectAtIndex:indexPath.row] setEditing:YES animated:YES];
            if (indexPath.row == 0)
            {
                [self.networking.type addObject:@"mediumTank"];
            }
            if (indexPath.row == 1)
            {
                [self.networking.type addObject:@"heavyTank"];
                
            }
            
            if (indexPath.row == 2)
            {
                [self.networking.type addObject:@"lightTank"];
                
            }
            if (indexPath.row == 3)
            {            [self.networking.type addObject:@"SPG"];
                
            }
            if (indexPath.row == 4)
            {            [self.networking.type addObject:@"AT-SPG"];
                
            }  if (indexPath.row == 5)
            {            [self.networking.type addObject:@"none"];
                
            }
            return;
        }
        if (cellType.editing == YES) {
            [[self.typeCell objectAtIndex:indexPath.row] setEditing:NO animated:YES];
            if (indexPath.row == 0)
            {
                [self.networking.type removeObject:@"mediumTank"];
            }
            if (indexPath.row == 1)
            {
                [self.networking.type removeObject:@"heavyTank"];
                
            }
            
            if (indexPath.row == 2)
            {
                [self.networking.type removeObject:@"lightTank"];
                
            }
            if (indexPath.row == 3)
            {            [self.networking.type removeObject:@"SPG"];
                
            }
            if (indexPath.row == 4)
            {            [self.networking.type removeObject:@"AT-SPG"];
                
            }  if (indexPath.row == 5)
            {            [self.networking.type removeObject:@"none"];
                
            }
            return;
        }
    }
    
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.frame = CGRectMake(0 - CGRectGetWidth(cell.frame), CGRectGetMinY(cell.frame),
                            CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         cell.frame = CGRectMake(0, CGRectGetMinY(cell.frame),
                                                 CGRectGetWidth(cell.frame),
                                                 CGRectGetHeight(cell.frame));
                         
                         
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                          
                                          }];
                     }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                  CGRectGetWidth([tableView rectForHeaderInSection:section]),
                                                                  CGRectGetHeight([tableView rectForHeaderInSection:section]))];
    headerView.backgroundColor = self.myColorRed;
    
    UILabel *headerTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,
                                                                         CGRectGetWidth([tableView rectForHeaderInSection:section]),
                                                                         CGRectGetHeight([tableView rectForHeaderInSection:section]))];
    headerTextLabel.textColor = self.myColorWhite;
    NSString *string = nil;
    switch (section) {
        case 0:
            string = [NSString stringWithFormat:@"Выберите страну"];//6
            break;
        case 1:
            string =  [NSString stringWithFormat:@"Выберите уровень"];//3
            break;
        case 2:
            string =  [NSString stringWithFormat:@"Выберите тип"];//16
            break;
    }
            headerTextLabel.text = string;
            [headerView addSubview:headerTextLabel];
    return headerView;
}



#pragma mark -   UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 11;
}



#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *string = nil;
    if (row == 0) {
        string = @"1";
    }if (row == 1) {
        string = @"2";
    }if (row == 2) {
        string = @"3";
    }if (row == 3) {
        string = @"4";
    }if (row == 4) {
        string = @"5";
    }if (row == 5) {
        string = @"6";
    }if (row == 6) {
        string = @"7";
    }if (row == 7) {
        string = @"8";
    }if (row == 8) {
        string = @"9";
    }if (row == 9) {
        string = @"10";
    }if (row == 10) {
        string = @"Не использовать";
    }
    return string;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (row == 0) {
        self.networking.level = 1;    }if (row == 1) {
            self.networking.level = 2;    }if (row == 2) {
                self.networking.level = 3;    }if (row == 3) {
                    self.networking.level = 4;    }if (row == 4) {
                        self.networking.level = 5;    }if (row == 5) {
                            self.networking.level = 6;    }if (row == 6) {
                                self.networking.level = 7;    }if (row == 7) {
                                    self.networking.level = 8;    }if (row == 8) {
                                        self.networking.level = 9;    }if (row == 9) {
                                            self.networking.level = 10;    }if (row == 10) {
                                                self.networking.level =0;    }
}


@end
