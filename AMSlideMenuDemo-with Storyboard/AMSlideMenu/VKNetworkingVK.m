//
//  VKNetworkingVK.m
//  VKSDKTestApplication
//
//  Created by Егор on 8/18/14.
//  Copyright (c) 2014 VK. All rights reserved.
//

#import "VKNetworkingVK.h"
#import "AFNetworking.h"
#import "DALoginWargamingViewController.h"



@interface VKNetworkingVK()
@property(nonatomic, strong) NSMutableArray *arrayFriends;
@property (strong,nonatomic) AFHTTPRequestOperationManager *requestOperationManager;
@property(nonatomic, strong) NSMutableArray *arrayAllAchivm;

@end
static NSString* kSettingsATWG        = @"acces_token_wg";
static NSString* kSettingsNWG         = @"nickneim_wg";
static NSString* kSettingsEWG           = @"expiration_date_at_wg";
static NSString* kSettingsUIDWG           = @"user_id_at_wg";

@implementation VKNetworkingVK

-(id)init{
    self = [super init];
    if (self)
    {
        self.arrayGroups = [NSMutableArray array];
        self.arrayFriends = [NSMutableArray array];
        self.arrayName = [NSMutableArray array];
        self.arrayFamily = [NSMutableArray array];
        self.arrayPhoto = [NSMutableArray array];
        self.arrayAllAchivm = [NSMutableArray array];
        self.type = [NSMutableArray array];
        self.country = [NSMutableArray array];
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://api.worldoftanks.ru/wot/"]];
         [self loadSettings];
        
    }
    return self;
}


+(VKNetworkingVK*)sharedInstance{
    static VKNetworkingVK* VKNetworkingVK = nil;
    static dispatch_once_t predicate;
    dispatch_once( &predicate,
                  ^{
        VKNetworkingVK = [ [ self alloc ] init ];

    } );
    return VKNetworkingVK;
}
- (void) authorizeUser:(void(^)()) completion fromPopVC:(UIViewController *)pvc{
    
   
   // if ([[NSDate date] compare:self.expirationDate] == NSOrderedDescending)
    if (self.accessToken) {
   
        completion();
        
    } else
    {
        
        
        DALoginWargamingViewController* vc = [[DALoginWargamingViewController alloc] initWithCompletionBlock:^(DAAccesTokenWarg *token) {
            
            [self saveSettings];
            self.accessToken = token;
            
            
            if (token) {
                completion();

                
            } else if (completion) {
                completion(nil);
            }
            
        }];
        
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [pvc presentViewController:nav animated:YES completion:nil];
        
    }
}


#pragma mark - network operation for wargaming.net



- (void)getUserWithIds:(NSString *)ids onSuccess:(void (^)(DAUserWargaming *user))success onFailure:(void (^)(NSError *))failure {
    NSNumber *idUser = [[NSNumber alloc] initWithInt:[ids intValue]];
    //NSInteger idUser =[ids intValue];
    
    __block DAUserWargaming *user = nil;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:idUser,@"account_id",@"c1b89f7d89ac48316cb8515b5f816573",@"application_id", nil];
    
    [self.requestOperationManager GET:@"account/info/" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject)
    {

        NSDictionary *objects = [[responseObject objectForKey:@"data"] objectForKey:ids];
        
        user = [[DAUserWargaming alloc] initWithDictionary:objects];
       
            
        success(user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        success(user);
    });
    
}



-(void) getSeachUserFromNickname:(NSString *)nickname onSuccess:(void (^) (DASearchUser *user)) success onFailure:(void (^) (NSError *error)) failure
{
    
    __block DASearchUser *userSeach = nil;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:nickname,@"search",@"c1b89f7d89ac48316cb8515b5f816573",@"application_id", nil];
    
    [self.requestOperationManager GET:@"account/list/" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *objects = [responseObject objectForKey:@"data"];

   
            userSeach = [[DASearchUser alloc] initWithDictionary:objects];
      
        
 
        
        
        
        success(userSeach);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        success(userSeach);
    });
    
    
}
-(void) getSpisokTankovOnSuccess:(void (^) (DASpisokTankovModel *user)) success onFailure:(void (^) (NSError *error)) failure{
    __block DASpisokTankovModel *user = nil;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"c1b89f7d89ac48316cb8515b5f816573",@"application_id", nil];
    
    [self.requestOperationManager GET:@"encyclopedia/tanks/" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *objects = [responseObject objectForKey:@"data"];
        
        user = [[DASpisokTankovModel alloc] initWithDictionary:objects];
        

        for (NSString*strngType in self.type) {
            for (NSString*stringCountry in self.country) {
                
                for (int i  = 0; i<=[user.arrayType count] - 1; i++)
                {
                    if (![strngType isEqualToString:@"none"] & ![stringCountry isEqualToString:@"none"] & !(self.level == 0) ) {
                        if ([[user.arrayType objectAtIndex:i] isEqualToString:strngType] & [[user.arrayNation objectAtIndex:i] isEqualToString:stringCountry] & [[user.arrayLevel objectAtIndex:i] integerValue] == self.level)
                        {
                            [user.arraySortName addObject:[user.arrayName objectAtIndex:i]];
                        }
                    }
                    
                    if ([strngType isEqualToString:@"none"])
                    {
                        if (![stringCountry isEqualToString:@"none"] & !(self.level == 0) )
                        {
                            if ([[user.arrayNation objectAtIndex:i] isEqualToString:stringCountry] & ([[user.arrayLevel objectAtIndex:i] integerValue] == self.level))
                            {
                                [user.arraySortName addObject:[user.arrayName objectAtIndex:i]];
                            }
                        }
                    }
                    
                    if ([stringCountry isEqualToString:@"none"])
                    {
                        if (![strngType isEqualToString:@"none"] & !(self.level == 0) )
                        {
                            if ([[user.arrayType objectAtIndex:i] isEqualToString:strngType] & ([[user.arrayLevel objectAtIndex:i] integerValue] == self.level))
                            {
                                [user.arraySortName addObject:[user.arrayName objectAtIndex:i]];
                            }
                        }
                    }
                    if ((self.level == 0))
                    {
                        if (![strngType isEqualToString:@"none"] & ![stringCountry isEqualToString:@"none"] )
                        {
                            if ([[user.arrayType objectAtIndex:i] isEqualToString:strngType] & [[user.arrayNation objectAtIndex:i] isEqualToString:stringCountry])
                            {
                                [user.arraySortName addObject:[user.arrayName objectAtIndex:i]];
                            }
                        }
                    }
                }

            }
        }
                success(user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        success(user);
    });
    
    
}

-(void) getInfoTankID:(NSNumber*)idTank  onSuccess:(void (^) (DAModelInfoTank *user)) success onFailure:(void (^) (NSError *error)) failure

{
    
    __block DAModelInfoTank *user = nil;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
  //  NSInteger integerID = [idTank intValue];
    
    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:idTank,@"tank_id",@"c1b89f7d89ac48316cb8515b5f816573",@"application_id", nil];
    
    [self.requestOperationManager GET:@"encyclopedia/tankinfo/" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *objects = [[responseObject objectForKey:@"data"] objectForKey:[idTank stringValue]];
        
        
         user = [[DAModelInfoTank alloc] initWithDictionary:objects];
        
        success(user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        success(user);
    });

    
    
}

-(void) getAllAchivmentsOnSuccess:(void (^) (DAAchivmentsModel *user)) success onFailure:(void (^) (NSError *error)) failure{
    __block DAAchivmentsModel *user = nil;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    //  NSInteger integerID = [idTank intValue];
    
    
    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"name",@"fields",@"c1b89f7d89ac48316cb8515b5f816573",@"application_id", nil];
    
    [self.requestOperationManager GET:@"encyclopedia/achievements/" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
        NSArray *dict = [[NSArray alloc] initWithArray:[[responseObject objectForKey:@"data"] allKeys]];
        [self.arrayAllAchivm addObjectsFromArray:dict];
        success(user);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        success(user);
    });
    
}

-(void) getAchivmentsByUserID:(NSNumber*) userID onSuccess:(void (^) (DAAchivmentsModel *user)) success onFailure:(void (^) (NSError *error)) failure
{
    __block DAAchivmentsModel *user = nil;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    //  NSInteger integerID = [idTank intValue];
    
    
    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:userID,@"account_id",@"c1b89f7d89ac48316cb8515b5f816573",@"application_id", nil];
    
    [self.requestOperationManager GET:@"account/achievements/" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [userID stringValue];
        NSDictionary *objects   = [responseObject objectForKey:@"data"];
        NSDictionary *dictTwo    = [objects      objectForKey:string];
        NSDictionary *dictThree =  [dictTwo    objectForKey:@"achievements"];
        user = [[DAAchivmentsModel alloc] initWithDictionary:dictThree andArrayAll:self.arrayAllAchivm];

        
        success(user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        success(user);
    });
    
    
}

-(void) getInfoAchivmentByName:(NSString*) name onSuccess:(void (^) (DAInfoAchivmentsByNAme *user)) success onFailure:(void (^) (NSError *error)) failure{
    __block DAInfoAchivmentsByNAme *user = nil;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    //  NSInteger integerID = [idTank intValue];
    
    
    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"name,section_i18n,image_big,description,condition,name_i18n,options",@"fields",@"c1b89f7d89ac48316cb8515b5f816573",@"application_id", nil];
    
    [self.requestOperationManager GET:@"encyclopedia/achievements/" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"%@", dictThree) ;
        
        NSDictionary *objects = [[responseObject objectForKey:@"data"] objectForKey:name];
        user = [[DAInfoAchivmentsByNAme alloc] initWithDictionary:objects];

        
        success(user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        success(user);
    });
    
    
    
    
    
}
-(void) exit:(NSString*) accesToken  onSuccess:(void (^) ( )) success onFailure:(void (^) (NSError *error)) failure
{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    
    
    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:accesToken,@"access_token",@"c1b89f7d89ac48316cb8515b5f816573",@"application_id", nil];
    
    [self.requestOperationManager GET:@"auth/logout/" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"%@", dictThree) ;
        
     
        
        
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        success();
    });
    
}


-(void)getAngarInforUserID:(NSString *) userID  onSuccess:(void (^) (DAInfoAngarTank *user)) success onFailure:(void (^) (NSError *error)) failure{
    __block DAInfoAngarTank *user = nil;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    //  NSInteger integerID = [idTank intValue];
    

    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:userID,@"account_id",@"c1b89f7d89ac48316cb8515b5f816573",@"application_id", nil];
    
    [self.requestOperationManager GET:@"account/tanks/" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSArray *objects = [[responseObject objectForKey:@"data"] objectForKey:userID];
        
        
            user = [[DAInfoAngarTank alloc] initWithDictionary:objects];
        for (NSNumber*tankID in user.arrayTankID) {
            NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"name_i18n,image,tank_id",@"fields",tankID,@"tank_id",@"c1b89f7d89ac48316cb8515b5f816573",@"application_id", nil];
            
            [self.requestOperationManager GET:@"encyclopedia/tankinfo/" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
               
                NSDictionary *objects = [responseObject objectForKey:@"data"];
                 NSDictionary *objectsTwo =[objects  objectForKey:[tankID stringValue]];
                
                
                                [user.arrayTankName addObject:[objectsTwo objectForKey:@"name_i18n"]];
                [user.arrayImage addObject:[objectsTwo objectForKey:@"image"]];
                
     
                for (int i = 0; i<=[user.arrayTankID count] -1; i++)
                {
                    if ([[user.arrayTankID objectAtIndex:i] isEqualToNumber:[objectsTwo objectForKey:@"tank_id"]])
                    {
                        [user.arrayTankIDSort addObject:[objectsTwo objectForKey:@"tank_id"]];
                        [user.arrayCountWinsSort addObject:[user.arrayCountWins objectAtIndex:i]];
                        [user.arrayCountBattlesSort addObject:[user.arrayCountBattles objectAtIndex:i]];
                    }
                }
                
                
                /*
                [user.arrayTankIDandName setObject:user.arrayTankName forKey:user.arrayTankIDSort];
                    
           
                for (int i = 0; i<=[[user.arrayTankIDandName allKeys] count] -1; i++)
                {
                    for (int j = 0; j<=[user.arrayTankID count] -1; j++)
                    {
                        if ([[[user.arrayTankIDandName allKeys] objectAtIndex:i] isEqualToNumber:[user.arrayTankID objectAtIndex:j]])
                        {
                            [user.arrayCountBattlesSort addObject:[user.arrayCountBattles objectAtIndex:j]];
                            [user.arrayCountWinsSort addObject:[user.arrayCountWins objectAtIndex:j]];
                            
                        }
                        
                    }
                }
                 */
                
                
                
                success(user);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        
        
        
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];



    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        success(user);
    });
    
    
}






#pragma mark - Save and Load
- (void) saveSettings {
 
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.accessTokenString forKey:kSettingsATWG];
    [userDefaults setObject:self.nickname forKey:kSettingsNWG];
    [userDefaults setObject:self.expirationDate forKey:kSettingsEWG];
   [userDefaults setObject:self.userID forKey:kSettingsUIDWG];
    [userDefaults synchronize];
}

- (void) loadSettings
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefaults objectForKey:kSettingsATWG];
    self.nickname= [userDefaults objectForKey:kSettingsNWG];
    self.expirationDate = [userDefaults objectForKey:kSettingsEWG];
    self.userID  = [userDefaults objectForKey:kSettingsUIDWG];

}

@end
