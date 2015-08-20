//
//  DAStatisticsViewController.m
//  AMSlideMenu
//
//  Created by Егор on 8/23/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//
#import "DAStatisticsViewController.h"
#import "DAUserWargaming.h"
#import "VKNetworkingVK.h"
#import "SVProgressHUD.h"

@interface DAStatisticsViewController ()
@property(nonatomic, strong) VKNetworkingVK *networking;
@property(nonatomic, weak) DAUserWargaming *userModel;
@property (nonatomic, readwrite, strong) MNMPullToRefreshManager *pullToRefreshManager;
@property (strong, nonatomic) UIColor *myColorBlack;
@property (strong, nonatomic) UIColor *myColorBlue;
@property (strong, nonatomic) UIColor *myColorRed;
@property (strong, nonatomic) UIColor *myColorWhite;
@property (strong, nonatomic) UIColor *myColorBrown;

@end
@implementation DAStatisticsViewController
@synthesize pullToRefreshManager = pullToRefreshManager_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

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
    [self downloadInfoUser:self.networking.userID];
    pullToRefreshManager_ = [[MNMPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f
                                                                                   tableView:self.tableView
                                                                                  withClient:self];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
-(void) downloadInfoUser:(NSString*) userID
{
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.networking getUserWithIds:userID onSuccess:^(DAUserWargaming *user)
         {
             self.userModel = user;
             dispatch_async(dispatch_get_main_queue(), ^{
                 [SVProgressHUD dismiss];
             });
         } onFailure:^(NSError *error)
         {
             NSLog(@"%@", error);
             
         }];
    });

}
#pragma mark - Aux view methods
- (void)loadTable {
    
    [self.tableView reloadData];
    
    [pullToRefreshManager_ tableViewReloadFinishedAnimated:YES];
}
#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }if (section == 1) {
        return 3;
    }if (section == 2) {
        return 16;
    }
    return 16;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                      reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        NSString *currentKeyallKeys = [self.userModel.allKeys objectAtIndex:indexPath.row];
        if ([currentKeyallKeys isEqualToString:@"private"]) {
            [self.userModel.allKeys removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }
        if ([currentKeyallKeys isEqualToString:@"achievements"]) {
            [self.userModel.allKeys removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }
        if ([currentKeyallKeys isEqualToString:@"statistics"]) {
            [self.userModel.allKeys removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }
        
        
        
        if ([[self.userModel.response objectForKey:currentKeyallKeys] isKindOfClass:[NSString class]])
        {
            cell.detailTextLabel.text = [self.userModel.response objectForKey:currentKeyallKeys];
            cell.textLabel.text = [self.userModel.section1 objectForKey:currentKeyallKeys];
            
        }
        if (![self.userModel.response objectForKey:currentKeyallKeys])
        {
            cell.detailTextLabel.text = @"NULL";

        }
        if ([[self.userModel.response objectForKey:currentKeyallKeys] isKindOfClass:[NSNumber class]])
        {
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];

            NSDate *date = nil;
            [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
            if ([[self.userModel.response objectForKey:currentKeyallKeys] intValue] > 1000000000) {
               date =  [NSDate dateWithTimeIntervalSince1970:[[self.userModel.response objectForKey:currentKeyallKeys] doubleValue]];
                 cell.detailTextLabel.text = [dateFormatter stringFromDate:date];
                cell.textLabel.text = [self.userModel.section1 objectForKey:currentKeyallKeys];

                return cell;
                
            }
            cell.detailTextLabel.text = [[self.userModel.response objectForKey:currentKeyallKeys] stringValue];

            cell.textLabel.text = [self.userModel.section1 objectForKey:currentKeyallKeys];

         
        }
    }
    if (indexPath.section == 1){
        NSString *currentKeyallKeysStat = [self.userModel.allKeysStat objectAtIndex:indexPath.row];


            if ([[self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStat] isKindOfClass:[NSString class]])
            {
                cell.detailTextLabel.text = [self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStat];
                cell.textLabel.text = [self.userModel.section2 objectForKey:currentKeyallKeysStat];

            }
            if (![self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStat])
            {
                cell.detailTextLabel.text = @"NULL";
            }
            if ([[self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStat] isKindOfClass:[NSNumber class]])
            {
                cell.detailTextLabel.text = [[self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStat] stringValue];
             cell.textLabel.text = [self.userModel.section2 objectForKey:currentKeyallKeysStat];
            }
    }
    if (indexPath.section == 2){
        NSString *currentKeyallKeysAll = [self.userModel.allKeysAll objectAtIndex:indexPath.row];

        if ([[self.userModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAll] isKindOfClass:[NSString class]])
        {
            cell.detailTextLabel.text = [self.userModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAll];
          cell.textLabel.text = [self.userModel.section3 objectForKey:currentKeyallKeysAll];
        }
        if (![self.userModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAll])
        {
            cell.detailTextLabel.text = @"NULL";

        }
        if ([[self.userModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAll] isKindOfClass:[NSNumber class]])
        {
            cell.detailTextLabel.text = [[self.userModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAll] stringValue];
            cell.textLabel.text = [self.userModel.section3 objectForKey:currentKeyallKeysAll];

        }
    }
    if (indexPath.section == 3){
        NSString *currentKeyallKeysClan = [self.userModel.allKeysClan objectAtIndex:indexPath.row];

    if ([[self.userModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan] isKindOfClass:[NSString class]])
        
            {
                cell.detailTextLabel.text = [self.userModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan];
                cell.textLabel.text = [self.userModel.section4 objectForKey:currentKeyallKeysClan];

            }
            if (![self.userModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan])
            {
                cell.detailTextLabel.text = @"NULL";
            }
            if ([[self.userModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan] isKindOfClass:[NSNumber class]])
            {
                cell.detailTextLabel.text = [[self.userModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan] stringValue];
                cell.textLabel.text = [self.userModel.section4 objectForKey:currentKeyallKeysClan];

            }
    }
    if (indexPath.section == 4){
        NSString *currentKeyallKeysHistory = [self.userModel.allKeysHistory objectAtIndex:indexPath.row];

                if ([[self.userModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistory] isKindOfClass:[NSString class]])
                {
                    cell.detailTextLabel.text = [self.userModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistory];
                    cell.textLabel.text = [self.userModel.section5 objectForKey:currentKeyallKeysHistory];

                    return cell;
                }
                if (![self.userModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistory])
                {
                    cell.detailTextLabel.text = @"NULL";
                }
                if ([[self.userModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistory] isKindOfClass:[NSNumber class]])
                {
                    cell.detailTextLabel.text = [[self.userModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistory] stringValue];
                    cell.textLabel.text = [self.userModel.section5 objectForKey:currentKeyallKeysHistory];

                    return cell;
                }
            }
    if (indexPath.section == 5){
        NSString *currentKeyallKeysCompany = [self.userModel.allKeysCompany objectAtIndex:indexPath.row];

                if ([[self.userModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompany] isKindOfClass:[NSString class]])
                {
                    cell.detailTextLabel.text = [self.userModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompany];
                    cell.textLabel.text = [self.userModel.section6 objectForKey:currentKeyallKeysCompany];

                    return cell;
                }
                if (![self.userModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompany])
                {
                    cell.detailTextLabel.text = @"NULL";
                }
                if ([[self.userModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompany] isKindOfClass:[NSNumber class]])
                {
                    cell.detailTextLabel.text = [[self.userModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompany] stringValue];
                    cell.textLabel.text = [self.userModel.section6 objectForKey:currentKeyallKeysCompany];

                    return cell;
                    
                }
            }
    if ([cell.detailTextLabel.text isEqualToString:@"NULL"]) {
        [self.tableView reloadData];
    }
    return  cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *string = nil;
    switch (section) {
        case 0:
            string = [NSString stringWithFormat:@"Общая статистика"];//6
            break;
        case 1:
            string =  [NSString stringWithFormat:@"Статистика игрока"];//3
            break;
        case 2:
            string =  [NSString stringWithFormat:@"Вся статистика"];//16
            break;
        case 3:
            string =  [NSString stringWithFormat:@"Статистика клановых боёв"];//16
            break;
        case 4:
            string =  [NSString stringWithFormat:@"Статистика исторических боев"];//16
            break;
        case 5:
            string =  [NSString stringWithFormat:@"Статистика ротных боев"];//16
            break;
    }
    return string;
}


#pragma mark - UITableViewDelegate

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
    switch (section) {
        case 0:
            string = [NSString stringWithFormat:@"Общая статистика"];//6
            break;
        case 1:
            string =  [NSString stringWithFormat:@"Статистика игрока"];//3
            break;
        case 2:
            string =  [NSString stringWithFormat:@"Вся статистика"];//16
            break;
        case 3:
            string =  [NSString stringWithFormat:@"Статистика клановых боёв"];//16
            break;
        case 4:
            string =  [NSString stringWithFormat:@"Статистика исторических боев"];//16
            break;
        case 5:
            string =  [NSString stringWithFormat:@"Статистика ротных боев"];//16
            break;
    }
    headerTextLabel.text = string;
    [headerView addSubview:headerTextLabel];
    
    return headerView;
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
@end
