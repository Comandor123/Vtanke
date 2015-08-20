//
//  SeachTableViewController.h
//  AMSlideMenu
//
//  Created by Егор on 8/25/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeachTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;
-(void) downloadSeachUser:(NSString*) nickname;
@end
