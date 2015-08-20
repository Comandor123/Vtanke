//
//  DAUserWargaming.m
//  AMSlideMenu
//
//  Created by Егор on 8/23/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAUserWargaming.h"


@implementation DAUserWargaming

- (instancetype)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super init];
    if (self) {

        self.allKeys = [NSMutableArray arrayWithArray:[responseObject allKeys]];
        self.response = responseObject;
        
        self.allKeysAlldict = [NSMutableDictionary dictionaryWithDictionary:[responseObject objectForKey:@"statistics"]];
        
        
        self.allKeysAlldictallKeysAll = [NSMutableDictionary dictionaryWithDictionary:[self.allKeysAlldict objectForKey:@"all"]];
        self.allKeysAlldictallKeysClan = [NSMutableDictionary dictionaryWithDictionary:[self.allKeysAlldict objectForKey:@"clan"]];
        self.allKeysAlldictallKeysCompany = [NSMutableDictionary dictionaryWithDictionary:[self.allKeysAlldict objectForKey:@"company"]];
        self.allKeysAlldictallKeysHistory = [NSMutableDictionary dictionaryWithDictionary:[self.allKeysAlldict objectForKey:@"historical"]];
        
        
        
        
        
        
        NSMutableArray*arrayMaxXP = [NSMutableArray arrayWithObject:@"max_xp" ];
        NSMutableArray*arrayMaxDamage = [NSMutableArray arrayWithObject:@"max_damage"];
        NSMutableArray*arrayMaxDemageVehicle = [NSMutableArray arrayWithObject:@"max_damage_vehicle"];
        
        
        NSMutableArray*arrayMax = [[NSMutableArray alloc] init];
        [arrayMax addObjectsFromArray:arrayMaxDemageVehicle];
        [arrayMax addObjectsFromArray:arrayMaxDamage];
        [arrayMax addObjectsFromArray:arrayMaxXP];
        
        
      
        self.allKeysStat = [NSMutableArray arrayWithArray:arrayMax];
        self.allKeysAll = [NSMutableArray arrayWithArray:[[self.allKeysAlldict objectForKey:@"all"] allKeys]];
        //NSLog(@"%@", self.allKeysAll);
        self.allKeysClan = [NSMutableArray arrayWithArray:[[self.allKeysAlldict objectForKey:@"clan"]allKeys]];
        self.allKeysCompany = [NSMutableArray arrayWithArray:[[self.allKeysAlldict objectForKey:@"company"]allKeys]];
        self.allKeysHistory = [NSMutableArray arrayWithArray:[[self.allKeysAlldict objectForKey:@"historical"] allKeys]];

        
       
        
        
        
     //   NSLog(@"%@", self.response);
       // NSLog(@"%@", self.allKeys);
        
        self.client_language =@"Язык, выбранный в клиенте игры";
        self.nickname = @"Имя игрока";
        self.account_id =@"Идентификатор аккаунта игрока";
        self.last_battle_time =@"Дата последнего проведенного боя";
        self.created_at =@"Дата создания аккаунта игрока";
        self.updated_at =@"Дата обновления информации об игроке";
        self.global_rating =@"Глобальный рейтинг";
        self.clan_id =@"Идентификатор клана";
        self.logout_at =@"Дата окончания последней игровой сессии";
        
        
        
        self.statistics_max_xp = @"Максимальный заработаный опыт за бой";
        self.statistics_max_damage= @"Максимальный урон за бой";
        self.statistics_max_damage_vehicle= @"Техника, на которой был нанесен максимальный урон за бой";
 
        
        
         self.statistics_clan_spotted = @"Кол-во обнаруженных противников";
         self.statistics_clan_hits = @"Кол-во попаданий";
        self.statistics_clan_battle_avg_xp = @"Средний опыт за бой";
         self.statistics_clan_draws = @"Кол-во ничьих";
        self.statistics_clan_wins = @"Кол-во побед";
         self.statistics_clan_losses = @"Кол-во поражений";
        self.statistics_clan_capture_points = @"Кол-во очков захвата";
        self.statistics_clan_battles = @"Кол-во проведённых боёв";
        self.statistics_clan_damage_dealt = @"Кол-во нанесённых повреждений";
         self.statistics_clan_hits_percents = @"Процент попаданий";
         self.statistics_clan_damage_received = @"Кол-во полученных повреждений";
        self.statistics_clan_shots = @"Кол-во произведённых выстрелов";
         self.statistics_clan_xp = @"Кол-во заработаного опыта";
         self.statistics_clan_frags = @"Кол-во уничтоженных танков";
         self.statistics_clan_survived_battles = @"Кол-во боёв в которых игрок выжил";
        self.statistics_clan_dropped_capture_points = @"Кол-во очков защиты";
        
        
        
         self.statistics_all_spotted = @"Кол-во обнаруженных противников";
         self.statistics_all_hits = @"Кол-во попадани";
         self.statistics_all_battle_avg_xp = @"Средний опыт за бой";
        self.statistics_all_draws = @"Кол-во ничьих";
        self.statistics_all_wins = @"Кол-во побед";
       self.statistics_all_losses = @"Кол-во поражений";
         self.statistics_all_capture_points = @"Кол-во очков захвата";
         self.statistics_all_battles = @"Кол-во проведённых боёв";
         self.statistics_all_damage_dealt = @"Кол-во нанесённых повреждений";
         self.statistics_all_hits_percents = @"Процент попаданий";
         self.statistics_all_damage_received = @"Кол-во полученных повреждений";
        self.statistics_all_shots = @"Кол-во произведённых выстрелов";
         self.statistics_all_xp = @"Кол-во заработаного опыта";
         self.statistics_all_frags = @"Кол-во уничтоженных танков";
        self.statistics_all_survived_battles = @"Кол-во боёв в которых игрок выжил";
        self.statistics_all_dropped_capture_points = @"Кол-во очков защиты";
        
        
        
        self.statistics_company_spotted = @"Кол-во обнаруженных противников";
        self.statistics_company_hits = @"Кол-во попаданий";
        self.statistics_company_battle_avg_xp = @"Средний опыт за бой";
         self.statistics_company_draws = @"Кол-во ничьих";
         self.statistics_company_wins = @"Кол-во боёв в которых игрок выжил";
         self.statistics_company_losses = @"Кол-во поражений";
        self.statistics_company_capture_points = @"Кол-во очков захвата";
         self.statistics_company_battles = @"Кол-во проведённых боёв";
         self.statistics_company_damage_dealt = @"Кол-во нанесённых повреждений";
        self.statistics_company_hits_percents = @"Процент попаданий";
        self.statistics_company_damage_received = @"Кол-во полученных повреждений";
         self.statistics_company_shots = @"Кол-во произведённых выстрелов";
        self.statistics_company_xp = @"Кол-во заработаного опыта";
         self.statistics_company_frags = @"Кол-во уничтоженных танков";
         self.statistics_company_survived_battles = @"Кол-во боёв в которых игрок выжил";
        self.statistics_company_dropped_capture_points = @"Кол-во очков защиты";
        
        
        self.statistics_historical_spotted = @"Кол-во обнаруженных противников";
         self.statistics_historical_hits = @"Кол-во попаданий";
         self.statistics_historical_battle_avg_xp = @"Средний опыт за бой";
         self.statistics_historical_draws = @"Кол-во ничьих";
        self.statistics_historical_wins = @"Кол-во побед";
         self.statistics_historical_losses = @"Кол-во поражений";
         self.statistics_historical_capture_points = @"Кол-во очков захвата";
        self.statistics_historical_battles = @"Кол-во проведённых боёв";
         self.statistics_historical_damage_dealt = @"Кол-во нанесённых повреждений";
         self.statistics_historical_hits_percents = @"Процент попаданий";
         self.statistics_historical_damage_received = @"Кол-во полученных повреждений";
        self.statistics_historical_shots = @"Кол-во произведённых выстрелов";
         self.statistics_historical_xp = @"Кол-во заработаного опыта";
         self.statistics_historical_frags = @"Кол-во уничтоженных танков";
         self.statistics_historical_survived_battles = @"Кол-во боёв в которых игрок выжил";
         self.statistics_historical_dropped_capture_points = @"Кол-во очков защиты";
        
        
        self.section1 = [[NSDictionary alloc] initWithObjects:@[self.client_language,
        self.nickname,
        self.account_id,
        self.last_battle_time,
        self.created_at,
        self.updated_at,
        self.global_rating,
        self.clan_id,
        self.logout_at] forKeys:@[@"client_language",@"nickname",@"account_id",@"last_battle_time",@"created_at",@"updated_at",@"global_rating",@"clan_id",@"logout_at"]];
        
        
        
        
        
        self.section2 = [[NSDictionary alloc] initWithObjects:@[self.statistics_max_xp,
                                                        self.statistics_max_damage,
                                                                self.statistics_max_damage_vehicle] forKeys:@[@"max_xp",@"max_damage",@"max_damage_vehicle"]];

        self.section3 = [[NSDictionary alloc] initWithObjects:@[self.statistics_clan_spotted,
                         self.statistics_clan_hits,
                         self.statistics_clan_battle_avg_xp,
                         self.statistics_clan_draws,
                         self.statistics_clan_wins,
                         self.statistics_clan_losses,
                         self.statistics_clan_capture_points,
                         self.statistics_clan_battles,
                         self.statistics_clan_damage_dealt,
                         self.statistics_clan_hits_percents,
                         self.statistics_clan_damage_received,
                         self.statistics_clan_shots,
                         self.statistics_clan_xp,
                         self.statistics_clan_frags,
                         self.statistics_clan_survived_battles,
                                                                self.statistics_clan_dropped_capture_points] forKeys:@[@"spotted",@"hits",@"battle_avg_xp",@"draws",@"wins",@"losses",@"capture_points",@"battles",@"damage_dealt"
                                                                               ,@"hits_percents",@"damage_received",@"shots",@"xp",@"frags",@"survived_battles",@"dropped_capture_points"]];
                         
                         
                         
        self.section4 = [[NSDictionary alloc] initWithObjects:@[ self.statistics_all_spotted,
                         self.statistics_all_hits,
                         self.statistics_all_battle_avg_xp,
                         self.statistics_all_draws,
                         self.statistics_all_wins,
                         self.statistics_all_losses,
                         self.statistics_all_capture_points,
                         self.statistics_all_battles,
                         self.statistics_all_damage_dealt,
                         self.statistics_all_hits_percents,
                         self.statistics_all_damage_received,
                         self.statistics_all_shots,
                         self.statistics_all_xp,
                         self.statistics_all_frags,
                         self.statistics_all_survived_battles,
                         self.statistics_all_dropped_capture_points]
                                                      forKeys:@[@"spotted",@"hits",@"battle_avg_xp",@"draws",@"wins",@"losses",@"capture_points",@"battles",@"damage_dealt"
                                                                            ,@"hits_percents",@"damage_received",@"shots",@"xp",@"frags",@"survived_battles",@"dropped_capture_points"]];
        
        
        self.section5 = [[NSDictionary alloc] initWithObjects:@[self.statistics_company_spotted,
                         self.statistics_company_hits,
                         self.statistics_company_battle_avg_xp,
                         self.statistics_company_draws,
                         self.statistics_company_wins,
                         self.statistics_company_losses,
                         self.statistics_company_capture_points,
                         self.statistics_company_battles,
                         self.statistics_company_damage_dealt,
                         self.statistics_company_hits_percents,
                         self.statistics_company_damage_received,
                         self.statistics_company_shots,
                         self.statistics_company_xp,
                         self.statistics_company_frags,
                         self.statistics_company_survived_battles,
                                                                self.statistics_company_dropped_capture_points] forKeys:@[@"spotted",@"hits",@"battle_avg_xp",@"draws",@"wins",@"losses",@"capture_points",@"battles",@"damage_dealt"
                                                                                                                          ,@"hits_percents",@"damage_received",@"shots",@"xp",@"frags",@"survived_battles",@"dropped_capture_points"]];
        
        
        self.section6 = [[NSDictionary alloc] initWithObjects:@[self.statistics_historical_spotted,
                         self.statistics_historical_hits,
                         self.statistics_historical_battle_avg_xp,
                         self.statistics_historical_draws,
                         self.statistics_historical_wins,
                         self.statistics_historical_losses,
                         self.statistics_historical_capture_points,
                         self.statistics_historical_battles,
                         self.statistics_historical_damage_dealt,
                         self.statistics_historical_hits_percents,
                         self.statistics_historical_damage_received,
                         self.statistics_historical_shots,
                         self.statistics_historical_xp,
                         self.statistics_historical_frags,
                         self.statistics_historical_survived_battles,
                                                                self.statistics_historical_dropped_capture_points] forKeys:@[@"spotted",@"hits",@"battle_avg_xp",@"draws",@"wins",@"losses",@"capture_points",@"battles",@"damage_dealt"
                                                                                                                             ,@"hits_percents",@"damage_received",@"shots",@"xp",@"frags",@"survived_battles",@"dropped_capture_points"]];

        

    }
    return self;
}
@end
