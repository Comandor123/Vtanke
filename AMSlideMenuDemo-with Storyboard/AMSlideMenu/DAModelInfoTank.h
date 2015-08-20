//
//  DAModelInfoTank.h
//  VTanke
//
//  Created by Егор on 9/5/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAModelInfoTank : NSObject

@property(nonatomic, strong) NSMutableDictionary *allResultDictionary;
@property(nonatomic, strong) NSMutableArray *allResultAllKeys;



@property(nonatomic, strong) NSMutableArray *chassisResultArray;
@property(nonatomic, strong) NSMutableArray *chassisResultArrayAllKeys;

@property(nonatomic, strong) NSMutableArray *crewResultArray;
@property(nonatomic, strong) NSMutableArray *crewResultArrayAllKeys;

@property(nonatomic, strong) NSMutableArray * enginesResultArray;
@property(nonatomic, strong) NSMutableArray *enginesResultArrayAllKEys;

@property(nonatomic, strong) NSMutableArray *gunsResultArray;
@property(nonatomic, strong) NSMutableArray *gunsResultArrayAllKeys;

@property(nonatomic, strong) NSMutableArray *radiosResultArray;
@property(nonatomic, strong) NSMutableArray *radiosResultArrayAllKeys;

@property(nonatomic, strong) NSMutableArray *turretsResultArray;
@property(nonatomic, strong) NSMutableArray *turretsResultArrayAllKeys;










@property(nonatomic, strong) NSDictionary *section1;
@property(nonatomic, strong) NSDictionary *section2;
@property(nonatomic, strong) NSDictionary *section3;
@property(nonatomic, strong) NSDictionary *section4;
@property(nonatomic, strong) NSDictionary *section5;
@property(nonatomic, strong) NSDictionary *section6;
@property(nonatomic, strong) NSDictionary *section7;
//section 0
@property(nonatomic, strong)NSString* chassis_rotation_speed;
@property(nonatomic, strong)NSString* circular_vision_radius;
@property(nonatomic, strong)NSString* contour_image;
@property(nonatomic, strong)NSString* engine_power;
@property(nonatomic, strong)NSString* gun_damage_max;
@property(nonatomic, strong)NSString* gun_max_ammo;
@property(nonatomic, strong)NSString* gun_damage_min;

@property(nonatomic, strong)NSString* gun_name;
@property(nonatomic, strong)NSString* gun_piercing_power_max;
@property(nonatomic, strong)NSString* gun_piercing_power_min;
@property(nonatomic, strong)NSString* gun_rate;
@property(nonatomic, strong)NSString* image;
@property(nonatomic, strong)NSString* image_small;
@property(nonatomic, strong)NSString* is_gift;
@property(nonatomic, strong)NSString* is_premium;
@property(nonatomic, strong)NSString* level;
@property(nonatomic, strong)NSString* limit_weight;
@property(nonatomic, strong)NSString* max_health;
@property(nonatomic, strong)NSString* name;
@property(nonatomic, strong)NSString* name_i18n;
@property(nonatomic, strong)NSString* nation;
@property(nonatomic, strong)NSString* nation_i18n;
@property(nonatomic, strong)NSString* price_credit;
@property(nonatomic, strong)NSString* price_gold;
@property(nonatomic, strong)NSString* radio_distance;
@property(nonatomic, strong)NSString* short_name_i18n;
@property(nonatomic, strong)NSString* speed_limit;
@property(nonatomic, strong)NSString* tank_id;
@property(nonatomic, strong)NSString* turret_armor_board;
@property(nonatomic, strong)NSString* turret_armor_fedd;
@property(nonatomic, strong)NSString* turret_armor_forehead;
@property(nonatomic, strong)NSString* turret_rotation_speed;
@property(nonatomic, strong)NSString* type;
@property(nonatomic, strong)NSString* type_i18n;
@property(nonatomic, strong)NSString* vehicle_armor_board;
@property(nonatomic, strong)NSString* vehicle_armor_fedd;
@property(nonatomic, strong)NSString* vehicle_armor_forehead;
@property(nonatomic, strong)NSString* weight;

//section 1 chassis
@property(nonatomic, strong)NSString* chassis_is_default;
@property(nonatomic, strong)NSString* chassis_module_id;

//section 2 crew
@property(nonatomic, strong)NSString* crew_role;
@property(nonatomic, strong)NSString* crew_role_i18n;
@property(nonatomic, strong)NSString* crew_additional_roles;

//section 3 engines
@property(nonatomic, strong)NSString* engines_is_default;
@property(nonatomic, strong)NSString* engines_module_id;

//section 4 guns
@property(nonatomic, strong)NSString* guns_is_default;
@property(nonatomic, strong)NSString* guns_module_id;

//section 5 radios
@property(nonatomic, strong)NSString* radios_is_default;
@property(nonatomic, strong)NSString* radios_module_id;

//section 6 turrets
@property(nonatomic, strong)NSString* turrets_is_default;
@property(nonatomic, strong)NSString* turrets_module_id;
- (instancetype)initWithDictionary:(NSDictionary *) responseObject;
@end
