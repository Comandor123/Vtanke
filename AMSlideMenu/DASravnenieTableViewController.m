//
//  DASravnenieTableViewController.m
//  AMSlideMenu
//
//  Created by Егор on 8/25/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DASravnenieTableViewController.h"
#import "DAUserWargaming.h"
#import "VKNetworkingVK.h"
#import "SravnenieTableViewCell.h"
@interface DASravnenieTableViewController ()
@property(nonatomic, strong) VKNetworkingVK *networking;
@property(nonatomic, weak) DAUserWargaming *userModel;


@property(nonatomic, strong) NSString *userID;
@property (nonatomic, readwrite, strong) MNMPullToRefreshManager *pullToRefreshManager;
@property (strong, nonatomic) UIColor *myColorBlack;
@property (strong, nonatomic) UIColor *myColorBlue;
@property (strong, nonatomic) UIColor *myColorRed;
@property (strong, nonatomic) UIColor *myColorWhite;
@property (strong, nonatomic) UIColor *myColorBrown;

@property(nonatomic, weak) DAUserWargaming *userAponentModel;


@end

@implementation DASravnenieTableViewController
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.networking = [VKNetworkingVK sharedInstance];
    [self downloadInfoUser:self.networking.userID];
    self.networking.countMy = 0;
    self.networking.countApp = 0;
    self.userID = [NSString stringWithString:self.networking.userID];
    pullToRefreshManager_ = [[MNMPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f
                                                                                   tableView:self.tableView
                                                                                  withClient:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) repeat{
    [self downloadInfoUser:self.networking.idApponents];

}
-(void) downloadInfoUser:(NSString*) userID{
    [self.networking getUserWithIds:userID onSuccess:^(DAUserWargaming *user)
     {
         if ([userID isEqualToString:self.userID]) {
             self.userModel = user;

         }
         if (![userID isEqualToString:self.networking.idApponents]){
         [self repeat];
         }

         if (![userID isEqualToString:self.userID]) {
             self.userAponentModel = user;
             [self.tableView reloadData];
         }
         
     } onFailure:^(NSError *error)
     {
         NSLog(@"%@", error);
         
     }];
    
    
}
#pragma mark - Aux view methods
- (void)loadTable {
    
    [self.tableView reloadData];
    
    [pullToRefreshManager_ tableViewReloadFinishedAnimated:YES];
}
#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }if (section == 1) {
        return 3;
    }if (section == 2) {
        return 16;
    }if (section == 6) {
        return 1;
    }
    return 16;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  

    static NSString *CellIdentifier = @"Cell";
    SravnenieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SravnenieTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
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
            cell.myValue.text = [self.userModel.response objectForKey:currentKeyallKeys];
            cell.parametr.text = [self.userModel.section1 objectForKey:currentKeyallKeys];
            
        }
        if (![self.userModel.response objectForKey:currentKeyallKeys])
        {
            cell.myValue.text = @"NULL";
            cell.aponentValue.text = @"NULL";
            
        }
        if ([[self.userModel.response objectForKey:currentKeyallKeys] isKindOfClass:[NSNumber class]])
        {
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *date = nil;
            [dateFormatter setDateFormat:@"dd MMMM yyyy"];
            if ([[self.userModel.response objectForKey:currentKeyallKeys] intValue] > 1000000000) {
                date =  [NSDate dateWithTimeIntervalSince1970:[[self.userModel.response objectForKey:currentKeyallKeys] doubleValue]];
                cell.myValue.text = [dateFormatter stringFromDate:date];
            
            }
            if ([[self.userModel.response objectForKey:currentKeyallKeys] intValue] <= 1000000000) {
                cell.myValue.text = [[self.userModel.response objectForKey:currentKeyallKeys] stringValue];
            }
            
            cell.parametr.text = [self.userModel.section1 objectForKey:currentKeyallKeys];
        }
    }
    if (indexPath.section == 1){
        NSString *currentKeyallKeysStat = [self.userModel.allKeysStat objectAtIndex:indexPath.row];
        
        
        if ([[self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStat] isKindOfClass:[NSString class]])
        {
            cell.myValue.text = [self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStat];
            cell.parametr.text = [self.userModel.section2 objectForKey:currentKeyallKeysStat];
            
        }
        if (![self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStat])
        {
            cell.myValue.text = @"NULL";
            
        }
        if ([[self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStat] isKindOfClass:[NSNumber class]])
        {
            cell.myValue.text = [[self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStat] stringValue];
            
            cell.parametr.text = [self.userModel.section2 objectForKey:currentKeyallKeysStat];
        }
    }
    if (indexPath.section == 2){
        NSString *currentKeyallKeysAll = [self.userModel.allKeysAll objectAtIndex:indexPath.row];
        
        if ([[self.userModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAll] isKindOfClass:[NSString class]])
        {
            cell.myValue.text = [self.userModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAll];
            cell.parametr.text = [self.userModel.section3 objectForKey:currentKeyallKeysAll];
            
        }
        if (![self.userModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAll])
        {
            cell.myValue.text = @"NULL";
            
            
        }
        if ([[self.userModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAll] isKindOfClass:[NSNumber class]])
        {
            cell.myValue.text = [[self.userModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAll] stringValue];
            cell.parametr.text = [self.userModel.section3 objectForKey:currentKeyallKeysAll];
            
            
        }
    }
    if (indexPath.section == 3){
        NSString *currentKeyallKeysClan = [self.userModel.allKeysClan objectAtIndex:indexPath.row];
        
        if ([[self.userModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan] isKindOfClass:[NSString class]])
            
        {
            cell.myValue.text = [self.userModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan];
            cell.parametr.text = [self.userModel.section4 objectForKey:currentKeyallKeysClan];
            cell.aponentValue.text = [self.userAponentModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan];
            
            
        }
        if (![self.userModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan])
        {
            cell.myValue.text = @"NULL";
            cell.aponentValue.text = @"NULL";
            
        }
        if ([[self.userModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan] isKindOfClass:[NSNumber class]])
        {
            cell.myValue.text = [[self.userModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan] stringValue];
            cell.parametr.text = [self.userModel.section4 objectForKey:currentKeyallKeysClan];
            cell.aponentValue.text = [[self.userAponentModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClan] stringValue];
            
        }
    }
    if (indexPath.section == 4){
        NSString *currentKeyallKeysHistory = [self.userModel.allKeysHistory objectAtIndex:indexPath.row];
        
        if ([[self.userModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistory] isKindOfClass:[NSString class]])
        {
            cell.myValue.text = [self.userModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistory];
            cell.parametr.text = [self.userModel.section5 objectForKey:currentKeyallKeysHistory];
            
            return cell;
        }
        if (![self.userModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistory])
        {
            cell.myValue.text = @"NULL";
            
        }
        if ([[self.userModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistory] isKindOfClass:[NSNumber class]])
        {
            cell.myValue.text = [[self.userModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistory] stringValue];
            cell.parametr.text = [self.userModel.section5 objectForKey:currentKeyallKeysHistory];
            
            return cell;
        }
    }
    if (indexPath.section == 5){
        NSString *currentKeyallKeysCompany = [self.userModel.allKeysCompany objectAtIndex:indexPath.row];
        
        if ([[self.userModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompany] isKindOfClass:[NSString class]])
        {
            cell.myValue.text = [self.userModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompany];
            cell.parametr.text = [self.userModel.section6 objectForKey:currentKeyallKeysCompany];
            
            return cell;
        }
        if (![self.userModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompany])
        {
            cell.myValue.text = @"NULL";
            
        }
        if ([[self.userModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompany] isKindOfClass:[NSNumber class]])
        {
            cell.myValue.text = [[self.userModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompany] stringValue];
            cell.parametr.text = [self.userModel.section6 objectForKey:currentKeyallKeysCompany];
        }
        
    }
    if ([cell.myValue.text isEqualToString:@"NULL"]) {
        [self.tableView reloadData];
    }
    if (self.userAponentModel) {
        if (indexPath.section == 0){
            NSString *currentKeyallKeysApp = [self.userAponentModel.allKeys objectAtIndex:indexPath.row];
            if ([currentKeyallKeysApp isEqualToString:@"private"]) {
                [self.userAponentModel.allKeys removeObjectAtIndex:indexPath.row];
                
                [self.tableView reloadData];
            }
            if ([currentKeyallKeysApp isEqualToString:@"achievements"]) {
                [self.userAponentModel.allKeys removeObjectAtIndex:indexPath.row];
                
                [self.tableView reloadData];
            }
            if ([currentKeyallKeysApp isEqualToString:@"statistics"]) {
                [self.userAponentModel.allKeys removeObjectAtIndex:indexPath.row];
                
                [self.tableView reloadData];
            }
            
            
            if ([[self.userAponentModel.response objectForKey:currentKeyallKeysApp] isKindOfClass:[NSString class]])
            {
                cell.myValue.text = [self.userAponentModel.response objectForKey:currentKeyallKeysApp];
                
            }
            if (![self.userAponentModel.response objectForKey:currentKeyallKeysApp])
            {
                cell.aponentValue.text = @"NULL";
                
            }
            if ([[self.userAponentModel.response objectForKey:currentKeyallKeysApp] isKindOfClass:[NSNumber class]])
            {
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                NSDate *date2 = nil;
                [dateFormatter setDateFormat:@"dd MMMM yyyy"];
                if ([[self.userAponentModel.response objectForKey:currentKeyallKeysApp] intValue] > 1000000000) {
                    date2 =  [NSDate dateWithTimeIntervalSince1970:[[self.userAponentModel.response objectForKey:currentKeyallKeysApp] doubleValue]];
                    cell.aponentValue.text = [dateFormatter stringFromDate:date2];
                    return cell;
                }
                cell.aponentValue.text = [[self.userModel.response objectForKey:currentKeyallKeysApp] stringValue];
            }
        }
        if (indexPath.section == 1){
            NSString *currentKeyallKeysStatApp = [self.userAponentModel.allKeysStat objectAtIndex:indexPath.row];
            
            
            if ([[self.userAponentModel.allKeysAlldict objectForKey:currentKeyallKeysStatApp] isKindOfClass:[NSString class]])
            {
                cell.aponentValue.text = [self.userAponentModel.allKeysAlldict objectForKey:currentKeyallKeysStatApp];
                
            }
            if (![self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStatApp])
            {
                cell.aponentValue.text = @"NULL";
                
            }
            if ([[self.userModel.allKeysAlldict objectForKey:currentKeyallKeysStatApp] isKindOfClass:[NSNumber class]])
            {
                cell.aponentValue.text = [[self.userAponentModel.allKeysAlldict objectForKey:currentKeyallKeysStatApp] stringValue];
            }
        }
        if (indexPath.section == 2){
            NSString *currentKeyallKeysAllApp = [self.userAponentModel.allKeysAll objectAtIndex:indexPath.row];
            
            if ([[self.userAponentModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAllApp] isKindOfClass:[NSString class]])
            {
                cell.aponentValue.text = [self.userAponentModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAllApp];
                
            }
            if (![self.userAponentModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAllApp])
            {
                cell.aponentValue.text = @"NULL";
                
                
            }
            if ([[self.userAponentModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAllApp] isKindOfClass:[NSNumber class]])
            {
                cell.aponentValue.text = [[self.userAponentModel.allKeysAlldictallKeysAll objectForKey:currentKeyallKeysAllApp] stringValue];
                
            }
        }
        if (indexPath.section == 3){
            NSString *currentKeyallKeysClanApp = [self.userAponentModel.allKeysClan objectAtIndex:indexPath.row];
            
            if ([[self.userAponentModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClanApp] isKindOfClass:[NSString class]])
                
            {
                cell.aponentValue.text = [self.userAponentModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClanApp];
                
                
            }
            if (![self.userAponentModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClanApp])
            {
                cell.aponentValue.text = @"NULL";
                
            }
            if ([[self.userAponentModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClanApp] isKindOfClass:[NSNumber class]])
            {
                cell.aponentValue.text = [[self.userAponentModel.allKeysAlldictallKeysClan objectForKey:currentKeyallKeysClanApp] stringValue];
                
            }
        }
        if (indexPath.section == 4){
            NSString *currentKeyallKeysHistoryApp = [self.userAponentModel.allKeysHistory objectAtIndex:indexPath.row];
            
            if ([[self.userAponentModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistoryApp] isKindOfClass:[NSString class]])
            {
                cell.aponentValue.text = [self.userAponentModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistoryApp];
                
                return cell;
            }
            if (![self.userAponentModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistoryApp])
            {
                cell.aponentValue.text = @"NULL";
                
            }
            if ([[self.userAponentModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistoryApp] isKindOfClass:[NSNumber class]])
            {
                cell.aponentValue.text = [[self.userAponentModel.allKeysAlldictallKeysHistory objectForKey:currentKeyallKeysHistoryApp] stringValue];
                
                return cell;
            }
        }
        if (indexPath.section == 5){
            NSString *currentKeyallKeysCompanyApp = [self.userAponentModel.allKeysCompany objectAtIndex:indexPath.row];
            
            if ([[self.userAponentModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompanyApp] isKindOfClass:[NSString class]])
            {
                cell.aponentValue.text = [self.userAponentModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompanyApp];
                
                return cell;
            }
            if (![self.userModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompanyApp])
            {
                cell.aponentValue.text = @"NULL";
                
            }
            
            if ([[self.userAponentModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompanyApp] isKindOfClass:[NSNumber class]])
            {
                cell.aponentValue.text = [[self.userAponentModel.allKeysAlldictallKeysCompany objectForKey:currentKeyallKeysCompanyApp] stringValue];
                return cell;
                
            }
        }
        if ([cell.aponentValue.text isEqualToString:@"NULL"]) {
            [self.tableView reloadData];}
        if ([cell.myValue.text intValue] > [cell.aponentValue.text intValue]) {
            cell.myValue.textColor = [UIColor greenColor];
            cell.aponentValue.textColor = [UIColor redColor];
            self.networking.countMy++;

        }if ([cell.myValue.text intValue] < [cell.aponentValue.text intValue]){
            cell.myValue.textColor = [UIColor redColor];
            cell.aponentValue.textColor = [UIColor greenColor];
            self.networking.countApp++;
        }if ([cell.myValue.text intValue] == [cell.aponentValue.text intValue]){
            cell.myValue.textColor = [UIColor yellowColor];
            cell.aponentValue.textColor = [UIColor yellowColor];
        }
    }
    
    
    

    if (indexPath.section == 6) {
        cell.parametr.text = [NSString stringWithFormat:@"Итого:"];
        NSNumber *nMy = [NSNumber numberWithInt:self.networking.countApp];
        NSNumber *nApp = [NSNumber numberWithInt:self.networking.countMy];

    
        cell.myValue.text = [nMy stringValue];
        cell.aponentValue.text =[nApp stringValue];
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
        case 6:
            string =  [NSString stringWithFormat:@"Результаты"];//16
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
