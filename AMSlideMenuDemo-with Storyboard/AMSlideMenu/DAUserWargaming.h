//
//  DAUserWargaming.h
//  AMSlideMenu
//
//  Created by Егор on 8/23/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAUserWargaming : NSObject


@property(nonatomic, strong) NSDictionary *section1;
@property(nonatomic, strong) NSDictionary *section2;
@property(nonatomic, strong) NSDictionary *section3;
@property(nonatomic, strong) NSDictionary *section4;
@property(nonatomic, strong) NSDictionary *section5;
@property(nonatomic, strong) NSDictionary *section6;



@property(nonatomic, strong)NSString* client_language;
@property(nonatomic, strong)NSString* nickname;
@property(nonatomic, strong)NSString* account_id;
@property(nonatomic, strong)NSString* last_battle_time;
@property(nonatomic, strong)NSString* created_at;
@property(nonatomic, strong)NSString* updated_at;
@property(nonatomic, strong)NSString* global_rating;
@property(nonatomic, strong)NSString* clan_id;
@property(nonatomic, strong)NSString* logout_at;

@property(nonatomic, strong)NSString*statistics_max_xp;
@property(nonatomic, strong)NSString*statistics_max_damage;
@property(nonatomic, strong)NSString*statistics_max_damage_vehicle;

@property(nonatomic, strong)NSString*statistics_clan_spotted;
@property(nonatomic, strong)NSString*statistics_clan_hits;
@property(nonatomic, strong)NSString*statistics_clan_battle_avg_xp;
@property(nonatomic, strong)NSString*statistics_clan_draws;
@property(nonatomic, strong)NSString*statistics_clan_wins;
@property(nonatomic, strong)NSString*statistics_clan_losses;
@property(nonatomic, strong)NSString*statistics_clan_capture_points;
@property(nonatomic, strong)NSString*statistics_clan_battles;
@property(nonatomic, strong)NSString*statistics_clan_damage_dealt;
@property(nonatomic, strong)NSString*statistics_clan_hits_percents;
@property(nonatomic, strong)NSString*statistics_clan_damage_received;
@property(nonatomic, strong)NSString*statistics_clan_shots;
@property(nonatomic, strong)NSString*statistics_clan_xp;
@property(nonatomic, strong)NSString*statistics_clan_frags;
@property(nonatomic, strong)NSString*statistics_clan_survived_battles;
@property(nonatomic, strong)NSString*statistics_clan_dropped_capture_points;

@property(nonatomic, strong)NSString*statistics_all_spotted;
@property(nonatomic, strong)NSString*statistics_all_hits;
@property(nonatomic, strong)NSString*statistics_all_battle_avg_xp;
@property(nonatomic, strong)NSString*statistics_all_draws;
@property(nonatomic, strong)NSString*statistics_all_wins;
@property(nonatomic, strong)NSString*statistics_all_losses;
@property(nonatomic, strong)NSString*statistics_all_capture_points;
@property(nonatomic, strong)NSString*statistics_all_battles;
@property(nonatomic, strong)NSString*statistics_all_damage_dealt;
@property(nonatomic, strong)NSString*statistics_all_hits_percents;
@property(nonatomic, strong)NSString*statistics_all_damage_received;
@property(nonatomic, strong)NSString*statistics_all_shots;
@property(nonatomic, strong)NSString*statistics_all_xp;
@property(nonatomic, strong)NSString*statistics_all_frags;
@property(nonatomic, strong)NSString*statistics_all_survived_battles;
@property(nonatomic, strong)NSString*statistics_all_dropped_capture_points;

@property(nonatomic, strong)NSString*statistics_company_spotted;
@property(nonatomic, strong)NSString*statistics_company_hits;
@property(nonatomic, strong)NSString*statistics_company_battle_avg_xp;
@property(nonatomic, strong)NSString*statistics_company_draws;
@property(nonatomic, strong)NSString*statistics_company_wins;
@property(nonatomic, strong)NSString*statistics_company_losses;
@property(nonatomic, strong)NSString*statistics_company_capture_points;
@property(nonatomic, strong)NSString*statistics_company_battles;
@property(nonatomic, strong)NSString*statistics_company_damage_dealt;
@property(nonatomic, strong)NSString*statistics_company_hits_percents;
@property(nonatomic, strong)NSString*statistics_company_damage_received;
@property(nonatomic, strong)NSString*statistics_company_shots;
@property(nonatomic, strong)NSString*statistics_company_xp;
@property(nonatomic, strong)NSString*statistics_company_frags;
@property(nonatomic, strong)NSString*statistics_company_survived_battles;
@property(nonatomic, strong)NSString*statistics_company_dropped_capture_points;


@property(nonatomic, strong)NSString*statistics_historical_spotted;
@property(nonatomic, strong)NSString*statistics_historical_hits;
@property(nonatomic, strong)NSString*statistics_historical_battle_avg_xp;
@property(nonatomic, strong)NSString*statistics_historical_draws;
@property(nonatomic, strong)NSString*statistics_historical_wins;
@property(nonatomic, strong)NSString*statistics_historical_losses;
@property(nonatomic, strong)NSString*statistics_historical_capture_points;
@property(nonatomic, strong)NSString*statistics_historical_battles;
@property(nonatomic, strong)NSString*statistics_historical_damage_dealt;
@property(nonatomic, strong)NSString*statistics_historical_hits_percents;
@property(nonatomic, strong)NSString*statistics_historical_damage_received;
@property(nonatomic, strong)NSString*statistics_historical_shots;
@property(nonatomic, strong)NSString*statistics_historical_xp;
@property(nonatomic, strong)NSString*statistics_historical_frags;
@property(nonatomic, strong)NSString*statistics_historical_survived_battles;
@property(nonatomic, strong)NSString*statistics_historical_dropped_capture_points;


@property(strong, nonatomic) NSMutableArray *allKeys;
@property(strong, nonatomic) NSMutableDictionary *allKeysAlldict;



@property(strong, nonatomic) NSMutableArray *allKeysStat;//3

@property(strong, nonatomic) NSMutableArray *allKeysAll;//16
@property(strong, nonatomic) NSMutableArray *allKeysClan;//16
@property(strong, nonatomic) NSMutableArray *allKeysCompany;//16
@property(strong, nonatomic) NSMutableArray *allKeysHistory;//16


@property(strong, nonatomic) NSMutableDictionary *allKeysAlldictallKeysAll;
@property(strong, nonatomic) NSMutableDictionary *allKeysAlldictallKeysClan;
@property(strong, nonatomic) NSMutableDictionary *allKeysAlldictallKeysCompany;
@property(strong, nonatomic) NSMutableDictionary *allKeysAlldictallKeysHistory;





@property(strong, nonatomic) NSArray *allObject;
@property(strong, nonatomic) NSDictionary*response;


- (instancetype)initWithDictionary:(NSDictionary *) responseObject;


@end
