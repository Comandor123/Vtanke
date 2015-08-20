//
//  MainVC.m
//  AMSlideMenu
//
// The MIT License (MIT)
//
// Created by : arturdev
// Copyright (c) 2014 SocialObjects Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

#import "MainVC.h"
#import "UIColor+CreateMethods.h"
#import "DAServerManager.h"
#import "DAPostTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "TTWall.h"
#import "SVProgressHUD.h"
#define DELTA_LABEL 49
#define DELTA_SCALE 0.4f
#define CONTENT_WIDTH 300.f
@interface MainVC ()
@property (strong,nonatomic) TTGroup *group;
@property (strong,nonatomic) NSMutableArray *wallPostArray;
@property (assign,nonatomic) BOOL loadingData;
@property(weak, nonatomic) TTPostTableViewCell *postCell;
@property(weak, nonatomic) SVProgressHUD *HUD;

@property (nonatomic, readwrite, strong) MNMPullToRefreshManager *pullToRefreshManager;
@property (strong, nonatomic) UIColor *myColorBlack;
@property (strong, nonatomic) UIColor *myColorBlue;
@property (strong, nonatomic) UIColor *myColorRed;
@property (strong, nonatomic) UIColor *myColorWhite;
@property (strong, nonatomic) UIColor *myColorBrown;
@end
static NSInteger count = 10;

@implementation MainVC
@synthesize pullToRefreshManager = pullToRefreshManager_;
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
    self.loadingData = YES;
    self.wallPostArray = [[NSMutableArray alloc]init];
    pullToRefreshManager_ = [[MNMPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f
                                                                                   tableView:self.tableView
                                                                                  withClient:self];
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [[DAServerManager sharedManager]getGroupById:@"wotpricol" onSuccess:^(TTGroup *group) {
            self.group = group;
            self.navigationItem.title = group.nameGroup;
            
            [self getWallPostFromServer];
            
        } onFailure:^(NSError *error) {
            
        } ];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
    

    [super.currentActiveNVC.view  addSubview:self.tableView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
   // self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:0.500];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSBackgroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self preferredStatusBarStyle];
}

- (void)getWallPostFromServer{
    
    [[DAServerManager sharedManager]getWallPostWithGroupIds:self.group.groupsID
                                                      count:count
                                                     offset:[self.wallPostArray count]
                                                  onSuccess:^(NSArray *wallPost) {
                                                      
                                                      
                                                      if ([wallPost count] > 0) {
                                                          
                                                          [self.wallPostArray addObjectsFromArray:wallPost];
                                                          
                                                          NSMutableArray* newPaths = [NSMutableArray array];
                                                          for (int i = (int)[self.wallPostArray count] - (int)[wallPost count]; i < [self.wallPostArray count]; i++) {
                                                              [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                          }
                                                          
                                                          [self.tableView beginUpdates];
                                                          [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
                                                          [self.tableView endUpdates];
                                                          self.loadingData = NO;
                                                      }
                                                      
                                                  } onFailure:^(NSError *error) {
                                                      
                                                  }];
    
    [[DAServerManager sharedManager]getWallPostWithGroupIds:@"67270195"
                                                      count:count
                                                     offset:[self.wallPostArray count]
                                                  onSuccess:^(NSArray *wallPost) {
                                                      
                                                      
                                                      if ([wallPost count] > 0) {
                                                          
                                                          [self.wallPostArray addObjectsFromArray:wallPost];
                                                          
                                                          NSMutableArray* newPaths = [NSMutableArray array];
                                                          for (int i = (int)[self.wallPostArray count] - (int)[wallPost count]; i < [self.wallPostArray count]; i++) {
                                                              [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                          }
                                                          
                                                          [self.tableView beginUpdates];
                                                          [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
                                                          [self.tableView endUpdates];
                                                          self.loadingData = NO;
                                                      }
                                                      
                                                  } onFailure:^(NSError *error) {
                                                      
                                                  }];
    [[DAServerManager sharedManager]getWallPostWithGroupIds:@"69981970"
                                                      count:count
                                                     offset:[self.wallPostArray count]
                                                  onSuccess:^(NSArray *wallPost) {
                                                      
                                                      
                                                      if ([wallPost count] > 0) {
                                                          
                                                          [self.wallPostArray addObjectsFromArray:wallPost];
                                                          
                                                          NSMutableArray* newPaths = [NSMutableArray array];
                                                          for (int i = (int)[self.wallPostArray count] - (int)[wallPost count]; i < [self.wallPostArray count]; i++) {
                                                              [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                          }
                                                          
                                                          [self.tableView beginUpdates];
                                                          [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
                                                          [self.tableView endUpdates];
                                                          self.loadingData = NO;
                                                      }
                                                      
                                                  } onFailure:^(NSError *error) {
                                                      
                                                  }];

    [[DAServerManager sharedManager]getWallPostWithGroupIds:@"51047931"
                                                      count:count
                                                     offset:[self.wallPostArray count]
                                                  onSuccess:^(NSArray *wallPost) {
                                                      
                                                      
                                                      if ([wallPost count] > 0) {
                                                          
                                                          [self.wallPostArray addObjectsFromArray:wallPost];
                                                          
                                                          NSMutableArray* newPaths = [NSMutableArray array];
                                                          for (int i = (int)[self.wallPostArray count] - (int)[wallPost count]; i < [self.wallPostArray count]; i++) {
                                                              [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                          }
                                                          
                                                          [self.tableView beginUpdates];
                                                          [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
                                                          [self.tableView endUpdates];
                                                          self.loadingData = NO;
                                                      }
                                                      
                                                  } onFailure:^(NSError *error) {
                                                      
                                                  }];

    [[DAServerManager sharedManager]getWallPostWithGroupIds:@"30238065"
                                                      count:count
                                                     offset:[self.wallPostArray count]
                                                  onSuccess:^(NSArray *wallPost) {
                                                      
                                                      
                                                      if ([wallPost count] > 0) {
                                                          
                                                          [self.wallPostArray addObjectsFromArray:wallPost];
                                                          
                                                          NSMutableArray* newPaths = [NSMutableArray array];
                                                          for (int i = (int)[self.wallPostArray count] - (int)[wallPost count]; i < [self.wallPostArray count]; i++) {
                                                              [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                          }
                                                          
                                                          [self.tableView beginUpdates];
                                                          [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
                                                          [self.tableView endUpdates];
                                                          self.loadingData = NO;
                                                      }
                                                      
                                                  } onFailure:^(NSError *error) {
                                                      
                                                  }];
    /*

    [[DAServerManager sharedManager]getWallPostWithGroupIds:@"40155990"
                                                      count:count
                                                     offset:[self.wallPostArray count]
                                                  onSuccess:^(NSArray *wallPost) {
                                                      
                                                      
                                                      if ([wallPost count] > 0) {
                                                          
                                                          [self.wallPostArray addObjectsFromArray:wallPost];
                                                          
                                                          NSMutableArray* newPaths = [NSMutableArray array];
                                                          for (int i = (int)[self.wallPostArray count] - (int)[wallPost count]; i < [self.wallPostArray count]; i++) {
                                                              [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                          }
                                                          
                                                          [self.tableView beginUpdates];
                                                          [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
                                                          [self.tableView endUpdates];
                                                          self.loadingData = NO;
                                                      }
                                                      
                                                  } onFailure:^(NSError *error) {
                                                      
                                                  }];
     */
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        if (!self.loadingData)
        {
            self.loadingData = YES;
            [self getWallPostFromServer];
        }
    }
     [pullToRefreshManager_ tableViewScrolled];
}

- (NSString *) stringByStrippingHTML:(NSString *)string
{
    
    NSRange r;
    while ((r = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        
        string = [string stringByReplacingCharactersInRange:r withString:@""];
    }
    
    return string;
}

- (CGSize)newSizeFromImageHight:(NSInteger)hight width:(NSInteger)width {
    
    CGSize newSize = CGSizeZero;
    
    if (width > CONTENT_WIDTH) {
        newSize.width = CONTENT_WIDTH;
        newSize.height = CONTENT_WIDTH/width * hight;
    }
    
    return newSize;
}



- (void)updateWall {
    
    [[DAServerManager sharedManager]getWallPostWithGroupIds:self.group.groupsID
                                                      count:MAX(10, [self.wallPostArray count])
                                                     offset:0
                                                  onSuccess:^(NSArray *wallPost) {
                                                      
                                                      if ([wallPost count] > 0) {
                                                          [self.wallPostArray removeAllObjects];
                                                          [self.wallPostArray addObjectsFromArray:wallPost];
                                                          [self.tableView reloadData];
                                                          self.loadingData = NO;
                                                      }
                                                      
                                                  } onFailure:^(NSError *error) {
                                                      
                                                  }];
}


- (void)dealloc {
    NSLog(@"release");
}

#pragma mark - Overriden Methods

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier = @"";
    switch (indexPath.row) {
        case 0:
            identifier = @"firstRow";
            break;
        case 1:
            identifier = @"secondRow";
            break;
    }
    
    return identifier;
}


- (NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath
{
    NSString *identifier = @"";
    switch (indexPath.row) {
        case 0:
            identifier = @"firstRow";
            break;
        case 1:
            identifier = @"secondRow";
            break;
    }
    
    return identifier;
}


- (CGFloat)leftMenuWidth
{
    return 280;
}

- (CGFloat)rightMenuWidth
{
    return 280;
}

- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame = CGRectMake(0, 0, 25, 13);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"simpleMenuButton"] forState:UIControlStateNormal];
}

- (void)configureRightMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame = CGRectMake(0, 0, 25, 13);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"simpleMenuButton"] forState:UIControlStateNormal];
}

- (void) configureSlideLayer:(CALayer *)layer
{
    layer.shadowColor = [UIColor darkGrayColor].CGColor;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowRadius = 5;
    layer.masksToBounds = NO;
    layer.shadowPath =[UIBezierPath bezierPathWithRect:self.view.layer.bounds].CGPath;
}

- (AMPrimaryMenu)primaryMenu
{
    return AMPrimaryMenuLeft;
}


// Enabling Deepnes on left menu
- (BOOL)deepnessForLeftMenu
{
    return YES;
}

// Enabling Deepnes on left menu
- (BOOL)deepnessForRightMenu
{
    return YES;
}

// Enabling darkness while left menu is opening
- (CGFloat)maxDarknessWhileLeftMenu
{
    return 0.5;
}

// Enabling darkness while right menu is opening
- (CGFloat)maxDarknessWhileRightMenu
{
    return 0.5;
}

#pragma mark - UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.wallPostArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *postIdentifier = @"postcell";
    
    
    TTPostTableViewCell *postCell = [tableView dequeueReusableCellWithIdentifier:postIdentifier];
    self.postCell = postCell;
    if (!postCell) {
        postCell = [[TTPostTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postIdentifier];
    }
    
    TTWall *wall = [self.wallPostArray objectAtIndex:indexPath.row];
    
    postCell.dateLabel.text = wall.date;
    postCell.postTextLabel.text = [self stringByStrippingHTML:wall.text];
    

    
    
    postCell.addLikeBtn.frame = CGRectMake(postCell.addLikeBtn.frame.origin.x, postCell.addLikeBtn.frame.origin.y,[self widthOfTextForString:wall.likeCount maxSize:CGSizeMake(100, postCell.addLikeBtn.frame.size.height)], postCell.addLikeBtn.frame.size.height);
    
    postCell.addComentBtn.frame = CGRectMake(postCell.addComentBtn.frame.origin.x, postCell.addComentBtn.frame.origin.y,[self widthOfTextForString:wall.commentCount maxSize:CGSizeMake(100, postCell.addComentBtn.frame.size.height)], postCell.addComentBtn.frame.size.height);
    
    
    [postCell.addLikeBtn  setTitle:wall.likeCount forState:UIControlStateNormal];
    [postCell.addComentBtn  setTitle:wall.commentCount forState:UIControlStateNormal];
    
    
    UIFont* font = [UIFont systemFontOfSize:10.f];
    
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, -1);
    shadow.shadowBlurRadius = 0;
    
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentLeft];
    
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, paragraph, NSParagraphStyleAttributeName,shadow, NSShadowAttributeName, nil];
    
    CGRect rect = [[self stringByStrippingHTML:wall.text] boundingRectWithSize:CGSizeMake(postCell.postTextLabel.frame.size.width, CGFLOAT_MAX)
                                                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                    attributes:attributes
                                                                       context:nil];
    
    
    
    
    CGRect newFrame = postCell.postTextLabel.frame;
    newFrame.size.height = rect.size.height;
    postCell.postTextLabel.frame = newFrame;
    
    CALayer *imageLayerLike = postCell.addLikeBtn.layer;
    [imageLayerLike setCornerRadius:3];
    [imageLayerLike setMasksToBounds:YES];
    
    CALayer *imageLayerComent = postCell.addComentBtn.layer;
    [imageLayerComent setCornerRadius:3];
    [imageLayerComent setMasksToBounds:YES];
    
    postCell.addLikeBtn.frame = CGRectMake(postCell.addLikeBtn.frame.origin.x, newFrame.size.height + DELTA_LABEL + 10,postCell.addLikeBtn.frame.size.width,postCell.addLikeBtn.frame.size.height);
    postCell.addComentBtn.frame = CGRectMake(postCell.addComentBtn.frame.origin.x, newFrame.size.height + DELTA_LABEL + 10,postCell.addComentBtn.frame.size.width,postCell.addComentBtn.frame.size.height);
    
    
    
    
    postCell.userImageView.image = nil;
    postCell.postPhotoView.image = nil;
    postCell.userNameLabel.text = nil;
    
    
    NSURLRequest *request;
    
    if (wall.fromUser != nil) {
        
        request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:wall.fromUser.photoURL]];
        postCell.userNameLabel.text = [NSString stringWithFormat:@"%@ %@",wall.fromUser.firstName,wall.fromUser.lastName];
        
    } else if (wall.fromGroup != nil) {
        
        request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:wall.fromGroup.photoStringURL]];
        postCell.userNameLabel.text = [NSString stringWithFormat:@"%@",wall.fromGroup.nameGroup];
    }
    
    __weak TTPostTableViewCell *weakPostCell = postCell;
    
    [postCell.userImageView setImageWithURLRequest:request
                                  placeholderImage:nil
                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                               [UIView animateWithDuration:0.3
                                                                     delay:0.1
                                                                   options:UIViewAnimationOptionCurveEaseOut
                                                                animations:^{
                                                                    weakPostCell.userImageView.image = image;
                                                                    CALayer *imageLayer = weakPostCell.userImageView.layer;
                                                                    [imageLayer setCornerRadius:20];
                                                                    [imageLayer setMasksToBounds:YES];
                                                                } completion:^(BOOL finished) {
                                                                    
                                                                }];

                                               
                                           
                                               
                                           } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
     
     {
         
     }];
    
    
    if (wall.postImageURL != nil) {
        
        [[DAServerManager sharedManager]    getUserWithIds:wall.fromUserID
                                                 onSuccess:^(TTUser *user)
         {
             
             NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:wall.postImageURL]];
             
             __weak TTPostTableViewCell *weakPostCell = postCell;
             [postCell.userImageView setImage:[UIImage imageNamed:@"images.jpeg"]];
              weakPostCell.postPhotoView.image = [UIImage imageNamed:@"images.jpeg"];
              CGSize size = [self newSizeFromImageHight:wall.postImageHight width:wall.postImageWidth];
             weakPostCell.addLikeBtn.frame = CGRectMake(weakPostCell.addLikeBtn.frame.origin.x, size.height + DELTA_LABEL + 10 + 10 + newFrame.size.height ,weakPostCell.addLikeBtn.frame.size.width,weakPostCell.addLikeBtn.frame.size.height);
             
             weakPostCell.addComentBtn.frame = CGRectMake(weakPostCell.addComentBtn.frame.origin.x, size.height + DELTA_LABEL + 10 + 10 + newFrame.size.height ,weakPostCell.addComentBtn.frame.size.width,weakPostCell.addComentBtn.frame.size.height);
             [postCell.userImageView setImageWithURLRequest:request
                                           placeholderImage:nil
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                        
                                                        [UIView animateWithDuration:0.3
                                                                              delay:0.1
                                                                            options:UIViewAnimationOptionCurveEaseOut
                                                                         animations:^{
                                                                             
                                                                             
                                                                             weakPostCell.postPhotoView.image = image;
                                                                             
                                                                             CGSize size = [self newSizeFromImageHight:wall.postImageHight width:wall.postImageWidth];
                                                                             
                                                                             weakPostCell.postPhotoView.frame = CGRectMake(newFrame.origin.x, newFrame.size.height + DELTA_LABEL + 10 ,size.width,size.height);
                                                                             weakPostCell.addLikeBtn.frame = CGRectMake(weakPostCell.addLikeBtn.frame.origin.x, size.height + DELTA_LABEL + 10 + 10 + newFrame.size.height ,weakPostCell.addLikeBtn.frame.size.width,weakPostCell.addLikeBtn.frame.size.height);
                                                                             
                                                                             weakPostCell.addComentBtn.frame = CGRectMake(weakPostCell.addComentBtn.frame.origin.x, size.height + DELTA_LABEL + 10 + 10 + newFrame.size.height ,weakPostCell.addComentBtn.frame.size.width,weakPostCell.addComentBtn.frame.size.height);
                                                                            
                                                                             
                                                                         } completion:^(BOOL finished) {
                                                                             
                                                                         }];

                                                        
                                                      
                                                        
                                                    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                        
                                                    }];
         } onFailure:^(NSError *error) {
             
         }];
        
    }
    
    
    return postCell;
    
    
    
    return nil;
}

- (CGFloat)widthOfTextForString:(NSString *)aString maxSize:(CGSize)aSize {
    
    UIFont* font = [UIFont systemFontOfSize:15.f];
    
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, -1);
    shadow.shadowBlurRadius = 0;
    
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentLeft];
    
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, paragraph, NSParagraphStyleAttributeName,shadow, NSShadowAttributeName, nil];
    
    CGSize sizeOfText = [aString boundingRectWithSize: aSize
                                              options: (NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                           attributes: attributes
                                              context: nil].size;
    
    return ceilf(sizeOfText.width + 35);
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
    
    /*
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
*/
}

    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 
        
        TTWall *wall = [self.wallPostArray objectAtIndex:indexPath.row];
        
        TTPostTableViewCell *postCell = (TTPostTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        UIFont* font = [UIFont systemFontOfSize:10.f];
        
        NSShadow* shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = CGSizeMake(0, -1);
        shadow.shadowBlurRadius = 0;
        
        NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
        [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
        [paragraph setAlignment:NSTextAlignmentLeft];
        
        NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, paragraph, NSParagraphStyleAttributeName,shadow, NSShadowAttributeName, nil];
        
        CGRect rect = [[self stringByStrippingHTML:wall.text] boundingRectWithSize:CGSizeMake(postCell.postTextLabel.frame.size.width, CGFLOAT_MAX)
                                                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                        attributes:attributes
                                                                           context:nil];
        
        
        CGRect newFrame = postCell.postTextLabel.frame;
        newFrame.size.height = rect.size.height;
        
        if (wall.postImageURL != nil) {
            
            CGSize size = [self newSizeFromImageHight:wall.postImageHight width:wall.postImageWidth];
            
            float height = newFrame.size.height + DELTA_LABEL + 10 + 10 + size.height + postCell.addLikeBtn.frame.size.height + 5;
            
            return height;
            
        } else {
            
            return newFrame.size.height + DELTA_LABEL + 10 + 5 + postCell.addLikeBtn.frame.size.height;
        }
        
        
 
        return 45;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark -
#pragma mark MNMBottomPullToRefreshManagerClient

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
@end

