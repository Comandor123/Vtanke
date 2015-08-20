//
//  VKNetworkingVK.h
//  VKSDKTestApplication
//
//  Created by Егор on 8/18/14.
//  Copyright (c) 2014 VK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKSdk.h"
#import "DAUserWargaming.h"
#import "DAUserVK.h"
#import "DAAccesTokenWarg.h"
#import "DASearchUser.h"
#import "DASpisokTankovModel.h"
#import "DAModelInfoTank.h"
#import "DAAchivmentsModel.h"
#import "DAInfoAchivmentsByNAme.h"
#import "DAInfoAngarTank.h"
@interface VKNetworkingVK : NSObject
@property(nonatomic, strong) NSMutableArray *arrayGroups;
@property(nonatomic, strong) NSMutableArray *arrayName;
@property(nonatomic, strong) NSMutableArray *arrayFamily;
@property(nonatomic, strong) NSMutableArray *arrayPhoto;

@property(nonatomic, strong) NSString*nameVK;
@property(nonatomic, strong) NSString*familyVVK;


@property(nonatomic, strong) NSString *nickApponents;
@property(nonatomic, strong) NSString *idApponents;


@property (strong, nonatomic) DAAccesTokenWarg* accessToken;
@property (strong, nonatomic) NSString* accessTokenString;

@property (strong, nonatomic) NSString* nickname;
@property (strong, nonatomic) NSDate* expirationDate;
@property (strong, nonatomic) NSString* userID;



//seach tank
@property(strong, nonatomic) NSMutableArray*type;
@property(assign, nonatomic) NSInteger level;
@property(strong, nonatomic) NSMutableArray*country;


@property(nonatomic, strong) NSNumber *tankID;


@property(nonatomic, assign) NSInteger countMy;
@property(nonatomic, assign) NSInteger countApp;
+(VKNetworkingVK*)sharedInstance;
- (void) authorizeUser:(void(^)()) completion fromPopVC:(UIViewController *)pvc;
- (void)getUserWithIds:(NSString *)ids onSuccess:(void (^) (DAUserWargaming *user)) success onFailure:(void (^) (NSError *error)) failure;

-(void) getSeachUserFromNickname:(NSString *)ids onSuccess:(void (^) (DASearchUser *user)) success onFailure:(void (^) (NSError *error)) failure;

-(void) getSpisokTankovOnSuccess:(void (^) (DASpisokTankovModel *user)) success onFailure:(void (^) (NSError *error)) failure;


-(void) getInfoTankID:(NSNumber*)idTank  onSuccess:(void (^) (DAModelInfoTank *user)) success onFailure:(void (^) (NSError *error)) failure;


-(void) getAllAchivmentsOnSuccess:(void (^) (DAAchivmentsModel *user)) success onFailure:(void (^) (NSError *error)) failure;
-(void) getAchivmentsByUserID:(NSNumber*) userID onSuccess:(void (^) (DAAchivmentsModel *user)) success onFailure:(void (^) (NSError *error)) failure;


-(void) getInfoAchivmentByName:(NSString*) name onSuccess:(void (^) (DAInfoAchivmentsByNAme *user)) success onFailure:(void (^) (NSError *error)) failure;
-(void) exit:(NSString*) accesToken  onSuccess:(void (^) ( )) success onFailure:(void (^) (NSError *error)) failure;

-(void)getAngarInforUserID:(NSString *) userID  onSuccess:(void (^) (DAInfoAngarTank *user)) success onFailure:(void (^) (NSError *error)) failure;



- (void) saveSettings;
- (void) loadSettings;

@end
