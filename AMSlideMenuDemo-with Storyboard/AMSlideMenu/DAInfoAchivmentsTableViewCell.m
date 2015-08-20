//
//  DAInfoAchivmentsTableViewCell.m
//  VTanke
//
//  Created by Егор on 9/8/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAInfoAchivmentsTableViewCell.h"
#import "DAServerManager.h"
#import "SVProgressHUD.h"

@implementation DAInfoAchivmentsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionSharing:(id)sender
{
    
    UIAlertView *alertNotSharing = [[UIAlertView alloc] initWithTitle:@"НЕ ОПУБЛИКОВАНО" message:@"Достижение не получено" delegate:self cancelButtonTitle:@"Продолжить" otherButtonTitles:nil, nil];
    if ((self.actionSharing.backgroundColor == [UIColor clearColor]))
    {
        [alertNotSharing show];
        return;
    }
    self.indicatorSharing.color = [UIColor greenColor];
    //[self.indicatorSharing startAnimating];
    DAServerManager* net = [DAServerManager sharedManager];
    NSString *messangeName = self.nameAchivmentsLAbel.text;
    NSString *messangeTwo = [NSString stringWithFormat:@"#achiv"];
    NSMutableString *string = [NSMutableString stringWithString:@"Поздравляем с Достижением!\n" ];
    [string appendFormat:@"Название достижения: %@\n",messangeName];
    [string appendString:messangeTwo];
    NSLog(@"%@",string);
    
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ОПУБЛИКОВАНО" message:nil delegate:self cancelButtonTitle:@"Продолжить" otherButtonTitles:nil, nil];
  
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [net postAchivmentsInUserID:string image:[self.imageAchiment image] onSuccess:^(id responseObject)
         {
             //[self.indicatorSharing stopAnimating];
             [alert show];

            [SVProgressHUD dismiss];
             
         } onFailure:^(NSError *error) {
             
         }];
        
    
    });
  
    
}
@end
