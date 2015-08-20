//
//  SeachTableViewController.m
//  AMSlideMenu
//
//  Created by Егор on 8/25/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "SeachTableViewController.h"
#import "VKNetworkingVK.h"
#import "DASearchUser.h"
#import "DASravnenieTableViewController.h"
@interface SeachTableViewController ()
@property(nonatomic, strong) VKNetworkingVK *networking;
@property(weak, nonatomic) DASearchUser *seachUser;
@property(nonatomic, strong) NSString *seachString;


@property (strong, nonatomic) UIColor *myColorBlack;
@property (strong, nonatomic) UIColor *myColorBlue;
@property (strong, nonatomic) UIColor *myColorRed;
@property (strong, nonatomic) UIColor *myColorWhite;
@property (strong, nonatomic) UIColor *myColorBrown;
@end

@implementation SeachTableViewController

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
    self.networking = [VKNetworkingVK sharedInstance];
    self.seachString = [NSString string];
    self.myColorBlack = [UIColor colorWithRed:15.f / 255.f green:14.f / 255.f blue:15.f / 255.f alpha:1.0];
    self.myColorBlue = [UIColor colorWithRed:31.f / 255.f green:51.f / 255.f blue:82.f / 255.f alpha:1.0];
    self.myColorRed = [UIColor colorWithRed:220.f / 255.f green:54.f / 255.f blue:16.f / 255.f alpha:1.0];
    self.myColorBrown = [UIColor colorWithRed:217.f / 255.f green:203.f / 255.f blue:158.f / 255.f alpha:1.0];
    self.myColorWhite = [UIColor whiteColor];
    
    
 
}
-(void) downloadSeachUser:(NSString*) nickname{
    [self.networking getSeachUserFromNickname:nickname onSuccess:^(DASearchUser *user) {

        self.seachUser = user;
        
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error) {
           NSLog(@"%@", error);
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.seachUser.nickname count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    
    cell.textLabel.text = [self.seachUser.nickname objectAtIndex:indexPath.row];
    
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
                         
                         cell.backgroundColor = self.myColorBrown;
                         
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              
                                              cell.backgroundColor = [UIColor darkGrayColor];
                                          }];
                     }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    self.networking.nickApponents = [self.seachUser.nickname objectAtIndex:indexPath.row];
    self.networking.idApponents = [self.seachUser.account_id objectAtIndex:indexPath.row];
    
[tableView deselectRowAtIndexPath:indexPath animated:YES];
 
   DASravnenieTableViewController*vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"DASravnenieTableViewController"];
   [self.navigationController pushViewController:vc animated:YES];
}






#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //self.sectionsArray = [self generateSectionsFromArray:self.namesArray withFilter:searchText];
    //[self.tableView reloadData];
    if ([searchText length] >= 3) {
        self.seachString = searchText;
        [self downloadSeachUser:self.seachString];
    }
  
}

@end
