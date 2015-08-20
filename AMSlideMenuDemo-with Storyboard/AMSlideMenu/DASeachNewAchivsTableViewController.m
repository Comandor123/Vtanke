//
//  DASeachNewAchivsTableViewController.m
//  VTanke
//
//  Created by Егор on 28.9.14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DASeachNewAchivsTableViewController.h"
#import "DAServerManager.h"
@interface DASeachNewAchivsTableViewController ()
@property (nonatomic, readwrite, strong) MNMPullToRefreshManager *pullToRefreshManager;
@property(nonatomic, strong) DAServerManager *networking;

@end

@implementation DASeachNewAchivsTableViewController
@synthesize pullToRefreshManager = pullToRefreshManager_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.networking  = [DAServerManager sharedManager];
    NSNumber *myID=  [NSNumber numberWithInt:[self.networking.accessToken.userID intValue]];

    [self.networking getFriends:myID onSuccess:^(id responseObject) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:responseObject];
        [array addObject:myID];
        
        for (NSNumber*currentID in responseObject) {
            [self.networking seachPostAchivmentsOnFriends:currentID onSuccess:^(id responseObject)
            {
            } onFailure:^(NSError *error) {
                
            }];
        }
     
        
    } onFailure:^(NSError *error) {
        
    }];
 
    
    
    pullToRefreshManager_ = [[MNMPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f
                                                                                   tableView:self.tableView
                                                                                  withClient:self];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Aux view methods
- (void)loadTable {
    
    [self.tableView reloadData];
    
    [pullToRefreshManager_ tableViewReloadFinishedAnimated:YES];
    
    
}
#pragma mark -  UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier] ;
    }
    
    
    
    
    return cell;
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
                                              
                                              cell.backgroundColor = [UIColor darkGrayColor];
                                          }];
                     }];
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
