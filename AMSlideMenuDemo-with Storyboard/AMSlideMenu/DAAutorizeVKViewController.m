//
//  DAAutorizeVKViewController.m
//  AMSlideMenu
//
//  Created by Егор on 8/27/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAAutorizeVKViewController.h"
#import "DAServerManager.h"
#import "DALoginWargamingViewController.h"
#import "VKNetworkingVK.h"
static NSString *const NEXT_CONTROLLER_SEGUE_ID = @"START_WORK_WAR";

@interface DAAutorizeVKViewController ()
@property(nonatomic, strong) VKNetworkingVK *network;
@end

@implementation DAAutorizeVKViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.network = [VKNetworkingVK sharedInstance] ;

    [[DAServerManager sharedManager] authorizeUser:^(TTUser *user )
    {
     //   NSLog(@"AUTHORIZED!");
      //  NSLog(@"%@ %@", user.firstName, user.lastName);
        [self startWorking];
    }
     fromPopVC:self];
    //[self performSegueWithIdentifier:@"modal" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)startWorking
{
    //DALoginWargamingViewController*vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"DALoginWargamingViewController"];
            //[self.navigationController pushViewController:vc animated:YES];
    
    [self.network authorizeUser:^{
  [self performSegueWithIdentifier:NEXT_CONTROLLER_SEGUE_ID sender:self];
    }
                      fromPopVC:self];

  //  [self performSegueWithIdentifier:NEXT_CONTROLLER_SEGUE_ID sender:self];
    
    
    
}

@end
