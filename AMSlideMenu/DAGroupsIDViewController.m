//
//  DAGroupsIDViewController.m
//  AMSlideMenu
//
//  Created by Егор on 8/22/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAGroupsIDViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DAUserVK.h"
#import "SVProgressHUD.h"

@interface DAGroupsIDViewController ()
@property(weak, nonatomic) DAServerManager *networkingVK;
@property(nonatomic, weak) DAUserVK *userVK;
@property (nonatomic, readwrite, strong) MNMPullToRefreshManager *pullToRefreshManager;
@property (strong, nonatomic) UIColor *myColorBlack;
@property (strong, nonatomic) UIColor *myColorBlue;
@property (strong, nonatomic) UIColor *myColorRed;
@property (strong, nonatomic) UIColor *myColorWhite;
@property (strong, nonatomic) UIColor *myColorBrown;


@end

@implementation DAGroupsIDViewController
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
    self.networkingVK = [DAServerManager sharedManager];

    pullToRefreshManager_ = [[MNMPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f
                                                                                   tableView:self.tableView
                                                                                  withClient:self];
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.networkingVK udloadAllInfoFriendsOnSuccess:^(DAUserVK *user) {
            [self.tableView reloadData];
            self.userVK = user;
            // NSLog(@"%@", [self.userVK arrayName]);
        [SVProgressHUD dismiss];
        
        } onFailure:^(NSError *error) {
            
        }];
        
        
    });
    
    
 
  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  //  NSLog(@"%lu",(unsigned long)[self.networkingVK.arrayName count]);
    return  [self.networkingVK.arrayName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    
    
    
    
    
    NSString *stringName = [self.networkingVK.arrayName objectAtIndex:indexPath.row];
    NSString *stringFamily = [self.networkingVK.arrayFamily objectAtIndex:indexPath.row];
    NSString *stringPhoto = [self.networkingVK.arrayPhoto objectAtIndex:indexPath.row];
    NSString *string = [stringName stringByAppendingString:@" "];
    NSString*stringTwo = [string stringByAppendingString:stringFamily];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",stringTwo];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:stringPhoto]];
//    
//    UIImageView *imageView = [[UIImageView alloc] init];
//    
//    [imageView setImageWithURL:[NSURL URLWithString:stringPhoto]];
//    UIImage *image = [UIImage alloc]
//    cell.imageView.image = ;

    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:stringPhoto]];
    
    __weak UITableViewCell* weakCell = cell;
    
    cell.imageView.image = nil;

    [cell.imageView
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

#pragma mark - TableView Delegate

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
  

    headerTextLabel.text = @"online";
    [headerView addSubview:headerTextLabel];
    
    return headerView;
}

#pragma mark -
#pragma mark Aux view methods

/*
 * Loads the table and restores the PTR view to its initial state
 */
- (void)loadTable {
    [self viewDidLoad];
    [self.tableView reloadData];
    
    [pullToRefreshManager_ tableViewReloadFinishedAnimated:YES];
}

#pragma mark -
#pragma mark MNMBottomPullToRefreshManagerClient

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshManagerClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewScrolled]
 *
 * Tells the delegate when the user scrolls the content view within the receiver.
 *
 * @param scrollView: The scroll-view object in which the scrolling occurred.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [pullToRefreshManager_ tableViewScrolled];
}

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewReleased]
 *
 * Tells the delegate when dragging ended in the scroll view.
 *
 * @param scrollView: The scroll-view object that finished scrolling the content view.
 * @param decelerate: YES if the scrolling movement will continue, but decelerate, after a touch-up gesture during a dragging operation.
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [pullToRefreshManager_ tableViewReleased];
}

/**
 * Tells client that refresh has been triggered
 * After reloading is completed must call [MNMPullToRefreshManager tableViewReloadFinishedAnimated:]
 *
 * @param manager PTR manager
 */
- (void)pullToRefreshTriggered:(MNMPullToRefreshManager *)manager {
    
    
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
}

@end
