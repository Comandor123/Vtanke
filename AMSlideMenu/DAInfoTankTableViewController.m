//
//  DAInfoTankTableViewController.m
//  VTanke
//
//  Created by Егор on 9/5/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAInfoTankTableViewController.h"
#import "VKNetworkingVK.h"
#import "DAModelInfoTank.h"
#import "DAPhotoInfoTankTableViewCell.h"
#import "DAInfoTankTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface DAInfoTankTableViewController ()

@property (nonatomic, readwrite, strong) MNMPullToRefreshManager *pullToRefreshManager;
@property(nonatomic, strong) VKNetworkingVK *networking;
@property (strong, nonatomic) UIColor *myColorBlack;
@property (strong, nonatomic) UIColor *myColorBlue;
@property (strong, nonatomic) UIColor *myColorRed;
@property (strong, nonatomic) UIColor *myColorWhite;
@property (strong, nonatomic) UIColor *myColorBrown;
@property(weak, nonatomic) DAModelInfoTank *userModel;
@end

@implementation DAInfoTankTableViewController
@synthesize pullToRefreshManager = pullToRefreshManager_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.networking = [VKNetworkingVK sharedInstance];
    pullToRefreshManager_ = [[MNMPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f
                                                                                   tableView:self.tableView
                                                                                  withClient:self];
    
    
    [self.networking getInfoTankID:self.networking.tankID onSuccess:^(DAModelInfoTank *user)
    {
    self.userModel = user;
   
    [self.tableView reloadData];
    } onFailure:^(NSError *error)
    {
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Aux view methods
- (void)loadTable {
    
    [self.tableView reloadData];
    
    [pullToRefreshManager_ tableViewReloadFinishedAnimated:YES];
}

#pragma mark - MNMBottomPullToRefreshManagerClient
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [pullToRefreshManager_ tableViewScrolled];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [pullToRefreshManager_ tableViewReleased];
}
- (void)pullToRefreshTriggered:(MNMPullToRefreshManager *)manager {
    
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
}




#pragma - mark  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if (section == 0) {
        return 37;
    }
    
    return 2;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifierImage = @"CellImage";
    static NSString *CellIdentifier = @"Cell";
    
    if (indexPath.section == 0)
    {
        
        if (indexPath.row == 0) {
            DAPhotoInfoTankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierImage];
            if (cell == nil) {
                cell = [[DAPhotoInfoTankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:CellIdentifier] ;
            }
            
            
            NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.userModel.allResultDictionary objectForKey:@"image"]]];
            
            __weak DAPhotoInfoTankTableViewCell* weakCell = cell;
            
            cell.imageView.image = nil;
            
            [cell.imageTank
             setImageWithURLRequest:request
             placeholderImage:nil
             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                 weakCell.imageView.image = image;
                 [weakCell layoutSubviews];
             }
             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                 
             }];

            return cell;

        }
       
        DAInfoTankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[DAInfoTankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier] ;
        }
        NSString *currentKeyallKeys = [self.userModel.allResultAllKeys objectAtIndex:indexPath.row];
        if ([[self.userModel.allResultDictionary objectForKey:currentKeyallKeys] isKindOfClass:[NSString class]])
        {
            cell.znachenieLabel.text = [self.userModel.allResultDictionary objectForKey:currentKeyallKeys];
            cell.parametrLabel.text = [self.userModel.section1 objectForKey:currentKeyallKeys];
            
        }
        if (![self.userModel.allResultDictionary objectForKey:currentKeyallKeys])
        {
            cell.znachenieLabel.text = @"";
            
        }
        if ([[self.userModel.allResultDictionary objectForKey:currentKeyallKeys] isKindOfClass:[NSNumber class]])
        {
            cell.znachenieLabel.text = [[self.userModel.allResultDictionary objectForKey:currentKeyallKeys] stringValue];
            cell.parametrLabel.text = [self.userModel.section1 objectForKey:currentKeyallKeys];
        }
        return cell;
    }
    if (indexPath.section == 1)
    {
        DAInfoTankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[DAInfoTankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:CellIdentifier] ;
        }
        
        NSString *currentKeyallKeys = [self.userModel.chassisResultArrayAllKeys objectAtIndex:indexPath.row];
        if ([[[self.userModel.chassisResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSString class]])
        {
            cell.znachenieLabel.text = [[self.userModel.chassisResultArray objectAtIndex:0]objectForKey:currentKeyallKeys];
            cell.parametrLabel.text = [self.userModel.section2 objectForKey:currentKeyallKeys];
            
        }
        if (![[self.userModel.chassisResultArray objectAtIndex:0]objectForKey:currentKeyallKeys])
        {
            cell.znachenieLabel.text = @"";
            
        }
        if ([[[self.userModel.chassisResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSNumber class]])
        {
           cell.znachenieLabel.text = [[[self.userModel.chassisResultArray objectAtIndex:0]objectForKey:currentKeyallKeys]stringValue];
            cell.parametrLabel.text = [self.userModel.section2 objectForKey:currentKeyallKeys];
        }
        return cell;
    }
    if (indexPath.section == 2)
    {
        DAInfoTankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[DAInfoTankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:CellIdentifier] ;
        }
        
        NSString *currentKeyallKeys = [self.userModel.crewResultArrayAllKeys objectAtIndex:indexPath.row];
        if ([[[self.userModel.crewResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSString class]])
        {
            cell.znachenieLabel.text = [[self.userModel.crewResultArray objectAtIndex:0]objectForKey:currentKeyallKeys];
            cell.parametrLabel.text = [self.userModel.section3 objectForKey:currentKeyallKeys];
            
        }
        if (![[self.userModel.crewResultArray objectAtIndex:0]objectForKey:currentKeyallKeys])
        {
            cell.znachenieLabel.text = @"";
            
        }
        if ([[[self.userModel.crewResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSNumber class]])
        {
               cell.znachenieLabel.text = [[[self.userModel.crewResultArray objectAtIndex:0]objectForKey:currentKeyallKeys]stringValue];
            cell.parametrLabel.text = [self.userModel.section3 objectForKey:currentKeyallKeys];
        }
        return cell;
    }
    if (indexPath.section == 3)
    {
        DAInfoTankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[DAInfoTankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:CellIdentifier] ;
        }
        
        NSString *currentKeyallKeys = [self.userModel.enginesResultArrayAllKEys objectAtIndex:indexPath.row];
        if ([[[self.userModel.enginesResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSString class]])
        {
            cell.znachenieLabel.text = [[self.userModel.enginesResultArray objectAtIndex:0]objectForKey:currentKeyallKeys];
            cell.parametrLabel.text = [self.userModel.section4 objectForKey:currentKeyallKeys];
            
        }
        if (![[self.userModel.enginesResultArray objectAtIndex:0]objectForKey:currentKeyallKeys])
        {
            cell.znachenieLabel.text = @"";
            
        }
        if ([[[self.userModel.enginesResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSNumber class]])
        {
   cell.znachenieLabel.text = [[[self.userModel.enginesResultArray objectAtIndex:0]objectForKey:currentKeyallKeys]stringValue];
            cell.parametrLabel.text = [self.userModel.section4 objectForKey:currentKeyallKeys];
        }
        return cell;
    }
    if (indexPath.section == 4)
    {
        DAInfoTankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[DAInfoTankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:CellIdentifier] ;
        }
        
        NSString *currentKeyallKeys = [self.userModel.gunsResultArrayAllKeys objectAtIndex:indexPath.row];
        if ([[[self.userModel.gunsResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSString class]])
        {
            cell.znachenieLabel.text = [[self.userModel.gunsResultArray objectAtIndex:0]objectForKey:currentKeyallKeys];
            cell.parametrLabel.text = [self.userModel.section5 objectForKey:currentKeyallKeys];
            
        }
        if (![[self.userModel.gunsResultArray objectAtIndex:0]objectForKey:currentKeyallKeys])
        {
            cell.znachenieLabel.text = @"";
            
        }
        if ([[[self.userModel.gunsResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSNumber class]])
        {
 cell.znachenieLabel.text = [[[self.userModel.gunsResultArray objectAtIndex:0]objectForKey:currentKeyallKeys]stringValue];
            cell.parametrLabel.text = [self.userModel.section5 objectForKey:currentKeyallKeys];
        }
        return cell;
    }
    if (indexPath.section == 5)
    {
        DAInfoTankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[DAInfoTankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:CellIdentifier] ;
        }
        
        NSString *currentKeyallKeys = [self.userModel.radiosResultArrayAllKeys objectAtIndex:indexPath.row];
        if ([[[self.userModel.radiosResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSString class]])
        {
            cell.znachenieLabel.text = [[self.userModel.radiosResultArray objectAtIndex:0]objectForKey:currentKeyallKeys];
            cell.parametrLabel.text = [self.userModel.section6 objectForKey:currentKeyallKeys];
            
        }
        if (![[self.userModel.radiosResultArray objectAtIndex:0]objectForKey:currentKeyallKeys])
        {
            cell.znachenieLabel.text = @"";
            
        }
        if ([[[self.userModel.radiosResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSNumber class]])
        {
           cell.znachenieLabel.text = [[[self.userModel.radiosResultArray objectAtIndex:0]objectForKey:currentKeyallKeys]stringValue];
            cell.parametrLabel.text = [self.userModel.section6 objectForKey:currentKeyallKeys];
        }
        return cell;
    }
    if (indexPath.section == 6)
    {
        DAInfoTankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[DAInfoTankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:CellIdentifier] ;
        }
        
        NSString *currentKeyallKeys = [self.userModel.turretsResultArrayAllKeys objectAtIndex:indexPath.row];
        if ([[[self.userModel.turretsResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSString class]])
        {
            cell.znachenieLabel.text = [[self.userModel.turretsResultArray objectAtIndex:0]objectForKey:currentKeyallKeys];
            cell.parametrLabel.text = [self.userModel.section7 objectForKey:currentKeyallKeys];
            
        }
        if (![[self.userModel.turretsResultArray objectAtIndex:0]objectForKey:currentKeyallKeys])
        {
            cell.znachenieLabel.text = @"";
            
        }
        if ([[[self.userModel.turretsResultArray objectAtIndex:0]objectForKey:currentKeyallKeys] isKindOfClass:[NSNumber class]])
        {  cell.znachenieLabel.text = [[[self.userModel.turretsResultArray objectAtIndex:0]objectForKey:currentKeyallKeys]stringValue];
            cell.parametrLabel.text = [self.userModel.section7 objectForKey:currentKeyallKeys];
        }
        return cell;
    }
    return nil;
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
                         
                         cell.backgroundColor = self.myColorBrown;
                         
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              
                                              cell.backgroundColor = [UIColor darkGrayColor];
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
    if (section == 0) {
        string = @"Общая информацция";
    }
    if (section == 1) {
        string = @"Информация об устанавливаемых шасси";
    }if (section == 2) {
        string = @"Информация об экипаже";
    }if (section == 3) {
        string = @"Информация об устанавливаемых двигателях";
    }if (section == 4) {
        string = @"Информация об устанавливаемых орудиях";
    }if (section == 5) {
        string = @"Информация об устанавливаемых радиостанциях";
    }if (section == 6) {
        string = @"Информация об устанавливаемых башнях";
    }
    headerTextLabel.text = string;
    [headerView addSubview:headerTextLabel];
    
    return headerView;
}

#pragma mark - UITableViewDelegate
@end
