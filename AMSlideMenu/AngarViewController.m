//
//  AngarViewController.m
//  AMSlideMenu
//
//  Created by Егор on 8/25/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "AngarViewController.h"
#import "DAInfoAngarTank.h"
#import "UIImageView+AFNetworking.h"

#import "DAAngarTableViewCell.h"
@interface AngarViewController ()
@property(nonatomic, weak) VKNetworkingVK *network;
@property(weak, nonatomic) DAInfoAngarTank* user;
@property (nonatomic, readwrite, strong) MNMPullToRefreshManager *pullToRefreshManager;
@property (strong, nonatomic) UIColor *myColorBlack;
@property (strong, nonatomic) UIColor *myColorBlue;
@property (strong, nonatomic) UIColor *myColorRed;
@property (strong, nonatomic) UIColor *myColorWhite;
@property (strong, nonatomic) UIColor *myColorBrown;
@end

@implementation AngarViewController
@synthesize pullToRefreshManager = pullToRefreshManager_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    self.network = [VKNetworkingVK sharedInstance];
    NSLog(@"%@",self.network.userID );
    [self.network getAngarInforUserID:self.network.userID onSuccess:^(DAInfoAngarTank *user) {
        self.user = user;
        if ([self.user.arrayTankName count] > 0){

        [self.tableView beginUpdates];
        UITableViewRowAnimation animation = UITableViewRowAnimationFade;
        
            animation = [self.user.arrayTankName count] % 2 ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight;
            
        
            NSIndexPath* newIndexPath = [NSIndexPath indexPathForItem:[self.user.arrayTankName count] - 1 inSection:0];
            
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:animation];
        [self.tableView endUpdates];

        }
        
        /*
        if ([self.user.arrayTankName count] == [self.user.arrayTankID count])
        {
            [self.tableView reloadData];
        }
        */
    } onFailure:^(NSError *error) {
        
    }];
    pullToRefreshManager_ = [[MNMPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f
                                                                                   tableView:self.tableView
                                                                                  withClient:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

    headerTextLabel.text =[NSString stringWithFormat:@"Название                  Боев        Побед"];
    [headerView addSubview:headerTextLabel];
    
    return headerView;
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
#pragma  mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.user.arrayTankName count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
   DAAngarTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[DAAngarTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                      reuseIdentifier:CellIdentifier];
    }
    cell.nameTank.text = [self.user.arrayTankName objectAtIndex:indexPath.row];
    cell.winsTank.text = [[self.user.arrayCountWinsSort objectAtIndex:indexPath.row] stringValue];
    cell.battlesTank.text = [[self.user.arrayCountBattlesSort objectAtIndex:indexPath.row] stringValue];
    /*
    NSInteger countBattles = [[self.user.arrayCountBattlesSort objectAtIndex:indexPath.row] integerValue];
    NSInteger countWins = [[self.user.arrayCountWinsSort objectAtIndex:indexPath.row] integerValue];
    float onePercent = countBattles / 100;
    float percentWinsIneger = countWins / onePercent;
    NSNumber *percentWins = [NSNumber numberWithFloat:percentWinsIneger];
    cell.winsTank.text = [percentWins stringValue];
    */
    
    
    
    float countBattles = [[self.user.arrayCountBattlesSort objectAtIndex:indexPath.row] floatValue];
    float countWins = [[self.user.arrayCountWinsSort objectAtIndex:indexPath.row] floatValue];
    float percentWinsIneger = (countWins / countBattles) *100;
    int percentInt = percentWinsIneger;
    
    NSNumber *percentWins = [NSNumber numberWithInt:percentInt];
    cell.winsTank.text = [percentWins stringValue];
    if (percentInt <= 16) {
        cell.winsTank.textColor = [UIColor purpleColor];

    }if (percentInt <=32 && percentInt >16) {
        cell.winsTank.textColor = [UIColor grayColor];
        
    }
    if (percentInt <=48 && percentInt >32) {
        cell.winsTank.textColor = [UIColor greenColor];
    }if (percentInt <=48 && percentInt >32) {
        cell.winsTank.textColor = [UIColor brownColor];
        
    }if (percentInt <=72 && percentInt >48) {
        cell.winsTank.textColor = [UIColor orangeColor];
        
    }if (percentInt <=100 && percentInt >72) {
        cell.winsTank.textColor = [UIColor redColor];
        
    }
    
    
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.user.arrayImage objectAtIndex:indexPath.row]]];
    
    __weak DAAngarTableViewCell* weakCell = cell;
    
    cell.imageTank.image = nil;
    
    [cell.imageTank
     setImageWithURLRequest:request
     placeholderImage:nil
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
         
         
         weakCell.imageTank.image = image;
         [weakCell layoutSubviews];
     }
     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
         
     }];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"Название                       Боев        Побед"];
}
@end
