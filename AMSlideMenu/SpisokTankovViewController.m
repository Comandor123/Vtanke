//
//  SpisokTankovViewController.m
//  VTanke
//
//  Created by Егор on 9/3/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "SpisokTankovViewController.h"
#import "VKNetworkingVK.h"
#import "DASpisokTankovModel.h"
#import "SVProgressHUD.h"

@interface SpisokTankovViewController ()
@property(nonatomic, strong) DASpisokTankovModel *tank;
@property(nonatomic, strong) NSArray *arrayLevel;
@property(nonatomic, strong) NSArray *arrayCountry;
@property(nonatomic, strong) NSMutableArray*arrayNames;

@property(nonatomic, strong) VKNetworkingVK *networking;

@property (nonatomic, readwrite, strong) MNMPullToRefreshManager *pullToRefreshManager;
@property (strong, nonatomic) UIColor *myColorBlack;
@property (strong, nonatomic) UIColor *myColorBlue;
@property (strong, nonatomic) UIColor *myColorRed;
@property (strong, nonatomic) UIColor *myColorWhite;
@property (strong, nonatomic) UIColor *myColorBrown;



@end

@implementation SpisokTankovViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.networking = [VKNetworkingVK sharedInstance];
    pullToRefreshManager_ = [[MNMPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f
                                                                                   tableView:self.tableView
                                                                                  withClient:self];
    self.arrayNames = [NSMutableArray array];
    self.arrayLevel = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    self.arrayCountry = @[@"ussr", @"usa", @"germany",@"france",@"china",@"japan",@"gb"];
    VKNetworkingVK *networking = [VKNetworkingVK sharedInstance];
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [networking getSpisokTankovOnSuccess:^(DASpisokTankovModel *user) {
            self.tank = user;
            /*
             if ([self.tank.arraySortName count] > 0){
             
             [self.tableView beginUpdates];
             UITableViewRowAnimation animation = UITableViewRowAnimationFade;
             
             animation = [self.tank.arraySortName count] % 2 ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight;
             
             
             NSIndexPath* newIndexPath = [NSIndexPath indexPathForItem:[self.tank.arraySortName count] - 1 inSection:0];
             
             [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:animation];
             [self.tableView endUpdates];
             
             }
             */
            [self.tableView reloadData];
                [SVProgressHUD dismiss];
            
        } onFailure:^(NSError *error) {
            
        }];
       
    });
    }

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
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
#pragma mark - Aux view methods
- (void)loadTable {
    
    [self.tableView reloadData];
    
    [pullToRefreshManager_ tableViewReloadFinishedAnimated:YES];
}
#pragma mark -  UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tank.arraySortName count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = [self.tank.arraySortName objectAtIndex:indexPath.row];
    
    
    
    return cell;
}
#pragma mark -  UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString* stringCell = [self.tank.arraySortName objectAtIndex:indexPath.row];
    
        for (int i = 0;i <= [self.tank.arrayName count] - 1 ; i++)
        {
        if ([[self.tank.arrayName objectAtIndex:i] isEqualToString:stringCell])
        {
            self.networking.tankID = [self.tank.arrayTankID objectAtIndex:i];
        }
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         
                         
                         cell.backgroundColor = self.myColorBrown;
                         
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              
                                              cell.backgroundColor = [UIColor darkGrayColor];
                                          }];
                     }];
    
}
@end
