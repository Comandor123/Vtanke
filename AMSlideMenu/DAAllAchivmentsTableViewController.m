//
//  DAAllAchivmentsTableViewController.m
//  VTanke
//
//  Created by Егор on 9/7/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAAllAchivmentsTableViewController.h"
#import "VKNetworkingVK.h"
#import "DAInfoAchivmentsTableViewCell.h"
#import "DAAchivmentsModel.h"
#import "DAInfoAchivmentsByNAme.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"

@interface DAAllAchivmentsTableViewController ()
@property(nonatomic, weak) VKNetworkingVK *networking;
@property(nonatomic, weak) DAAchivmentsModel *modelAchiv;
@property(nonatomic, weak) DAInfoAchivmentsByNAme *currentAchiv;
@property(nonatomic, strong) NSMutableArray *arrayName;
@property(nonatomic, strong) NSMutableArray *arraDescription;;
@property(nonatomic, strong) NSMutableArray *arrayCondition;
@property(nonatomic, strong) NSMutableArray *arrayImage_big;
@property(nonatomic, strong) NSMutableArray *arraySection_i18n;
@property(nonatomic, strong) NSMutableArray *numberRowsInTableView;

@end

@implementation DAAllAchivmentsTableViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self)
    {
        
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.networking = [VKNetworkingVK sharedInstance];

    NSNumber *number = [NSNumber numberWithInt:[self.networking.userID intValue]];
    self.arraDescription = [NSMutableArray array];
    self.arrayCondition = [NSMutableArray array];
    self.arrayImage_big = [NSMutableArray array];
    self.arrayName = [NSMutableArray array];
    self.arraySection_i18n = [NSMutableArray array];
    self.numberRowsInTableView = [NSMutableArray array];

    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.networking getAllAchivmentsOnSuccess:^(DAAchivmentsModel *user) {
            
            [self.networking    getAchivmentsByUserID:number onSuccess:^(DAAchivmentsModel *user)
             {
                 self.modelAchiv =user;
                 
                 for (NSString *string in self.modelAchiv.arrayMyAchivments) {
                     [self.networking getInfoAchivmentByName:string onSuccess:^(DAInfoAchivmentsByNAme *user) {
                         
                         [self.arraDescription addObject:user.description];
                         [self.arrayCondition addObject:user.condition];
                         [self.arrayImage_big addObject:user.image_big];
                         [self.arrayName addObject:user.name_rus];
                         [self.arraySection_i18n addObject:user.section_rus];
                         // NSLog(@"%@",self.modelAchiv.arrayMyAchivments);
                         [self.numberRowsInTableView addObjectsFromArray:self.arrayName];
                         [self.tableView reloadData];
                         if (string == [self.modelAchiv.arrayMyAchivments lastObject]) {
                             //NSLog(@"%@",self.modelAchiv.arraAll);
                             
                             for (NSString *string in self.modelAchiv.arrrayNotAcchivments) {
                                 
                                 [self.networking getInfoAchivmentByName:string onSuccess:^(DAInfoAchivmentsByNAme *user) {
                                     [self.arraDescription addObject:user.description];
                                     [self.arrayCondition addObject:user.condition];
                                     [self.arrayImage_big addObject:user.image_big];
                                     [self.arrayName addObject:user.name_rus];
                                     
                                     [self.arraySection_i18n addObject:user.section_rus];
                                     
                                     //NSLog(@"%@",   self.arraySection_i18n);
                                     [self.numberRowsInTableView removeAllObjects];
                                     [self.numberRowsInTableView addObjectsFromArray:self.arrayName];
                                     
                                     [self.tableView reloadData];
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [SVProgressHUD dismiss];
                                     });
                                     
                                     /*
                                      if ([self.numberRowsInTableView count] > 0){
                                      
                                      [self.tableView beginUpdates];
                                      UITableViewRowAnimation animation = UITableViewRowAnimationFade;
                                      
                                      animation = [self.numberRowsInTableView count] % 2 ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight;
                                      
                                      
                                      NSIndexPath* newIndexPath = [NSIndexPath indexPathForItem:[self.numberRowsInTableView count] - 1 inSection:0];
                                      
                                      [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:animation];
                                      [self.tableView endUpdates];
                                      
                                      }
                                      
                                      */
                                     
                                     
                                 } onFailure:^(NSError *error) {
                                     
                                 }];
                                 
                             }
                             
                             
                         }
                     } onFailure:^(NSError *error) {
                         
                     }];
                     
                     
                     
                     
                 }
                 
                 
                 
             } onFailure:^(NSError *error)
             {
                 
             }];
            
        } onFailure:^(NSError *error) {
            
        }];
        
      
    });

    
    
    

}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark -  UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.numberRowsInTableView count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
 
            DAInfoAchivmentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[DAInfoAchivmentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:CellIdentifier] ;
            }
    
 
    
    
    cell.indicatorSharing.color = [UIColor clearColor];
    
    cell.nameAchivmentsLAbel.text = [self.arrayName objectAtIndex:indexPath.row];
    cell.nameSectionLabel.text = [self.arraySection_i18n objectAtIndex:indexPath.row];
    cell.discriptionAchivments.text = [self.arraDescription objectAtIndex:indexPath.row];
    if (![[self.arrayCondition objectAtIndex:indexPath.row] isEqualToString:@"not"]) {
        cell.conditionLabel.text = [self.arrayCondition objectAtIndex:indexPath.row];
    }else{
        cell.conditionLabel.text = @"";

    }
    cell.actionSharing.backgroundColor = [UIColor clearColor];
    cell.actionSharing.tintColor = [UIColor clearColor];
    //cell.imageAchiment.text = [self.arrayName objectAtIndex:indexPath.row];
    
 
    if (indexPath.row <= [self.modelAchiv.arrayMyAchivments count]-1)
    {
        //cell.countAchivments.text = ;
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.arrayImage_big objectAtIndex:indexPath.row]]];
        
        __weak DAInfoAchivmentsTableViewCell* weakCell = cell;
        
        cell.imageAchiment.image = nil;
        
        [cell.imageAchiment
         setImageWithURLRequest:request
         placeholderImage:nil
         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
             
             
             weakCell.imageAchiment.image = image;
             [weakCell layoutSubviews];
             cell.actionSharing.backgroundColor = [UIColor redColor];
             cell.actionSharing.tintColor = [UIColor whiteColor];
         }
         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
             
         }];
    }
    
    if (indexPath.row > [self.modelAchiv.arrayMyAchivments count]-1)
    {
        
        cell.countAchivments.text = @"Достижение не получено";
    }
    

            return cell;
}

@end
