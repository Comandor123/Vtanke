//
//  DAExitViewControllerViewController.m
//  VTanke
//
//  Created by Егор on 9/10/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAExitViewControllerViewController.h"
#import "VKNetworkingVK.h"
#import "DAServerManager.h"
#import "MainVC.h"
@interface DAExitViewControllerViewController ()




@end




static NSString* kSettingsATWG         = @"acces_token_wg";
static NSString* kSettingsNWG          = @"nickneim_wg";
static NSString* kSettingsEWG          = @"expiration_date_at_wg";
static NSString* kSettingsUIDWG        = @"user_id_at_wg";
static NSString* kToken = @"kToken";
static NSString* kExpirationDate = @"kExpirationDate";
static NSString* kUserID = @"kUserID";




@implementation DAExitViewControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIAlertView *alertView= [[UIAlertView alloc] initWithTitle:@"Внимание!После выхода приложение необходимо перезапустить." message:@"Выйти?" delegate:self cancelButtonTitle:@"Не выходить" otherButtonTitles:@"Выйти", nil];
    [alertView show];
    
    alertView.delegate = self;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark -  UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"push" sender:self];

    }
    if (buttonIndex == 1) {
        VKNetworkingVK * network = [VKNetworkingVK sharedInstance];
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];

        [network exit:[userDefaults objectForKey:kSettingsATWG] onSuccess:^{
            [userDefaults removeObjectForKey:kSettingsATWG];
            [userDefaults removeObjectForKey:kSettingsNWG];
            [userDefaults removeObjectForKey:kSettingsEWG];
            [userDefaults removeObjectForKey:kSettingsUIDWG];
            [userDefaults removeObjectForKey:kToken];
            [userDefaults removeObjectForKey:kExpirationDate];
            [userDefaults removeObjectForKey:kUserID];
            [self performSegueWithIdentifier:@"push" sender:self];
        } onFailure:^(NSError *error)
        {
            
        }];
    }
    
    
}


@end
