//
//  DAModelInfoTank.m
//  VTanke
//
//  Created by Егор on 9/5/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAModelInfoTank.h"

@implementation DAModelInfoTank
- (instancetype)initWithDictionary:(NSDictionary *) responseObject
{
    

    
    self.allResultDictionary = [NSMutableDictionary dictionaryWithDictionary:responseObject];
    NSArray *arrayRemovKeys = @[@"chassis",@"crew",@"engines",@"guns",@"radios",@"turrets"];
    [self.allResultDictionary removeObjectsForKeys:arrayRemovKeys];
    
    
    
    
    
    self.chassisResultArray = [NSMutableArray arrayWithArray:[responseObject objectForKey:@"chassis"]];
    self.crewResultArray = [NSMutableArray arrayWithArray:[responseObject objectForKey:@"crew"]];
    self.enginesResultArray = [NSMutableArray arrayWithArray:[responseObject objectForKey:@"engines"]];
    self.gunsResultArray = [NSMutableArray arrayWithArray:[responseObject objectForKey:@"guns"]];
    self.radiosResultArray = [NSMutableArray arrayWithArray:[responseObject objectForKey:@"radios"]];
    self.turretsResultArray = [NSMutableArray arrayWithArray:[responseObject objectForKey:@"turrets"]];

    self.allResultAllKeys  = [NSMutableArray arrayWithArray:[self.allResultDictionary allKeys]];
    
    self.chassisResultArrayAllKeys =[NSMutableArray arrayWithArray:@[@"is_default",@"module_id"]];
    self.crewResultArrayAllKeys =[NSMutableArray arrayWithArray:@[@"role",@"role_i18n"]];
    self.enginesResultArrayAllKEys =[NSMutableArray arrayWithArray:@[@"is_default",@"module_id"]];
    self.gunsResultArrayAllKeys =[NSMutableArray arrayWithArray:@[@"is_default",@"module_id"]];
    self.radiosResultArrayAllKeys =[NSMutableArray arrayWithArray:@[@"is_default",@"module_id"]];
    self.turretsResultArrayAllKeys =[NSMutableArray arrayWithArray:@[@"is_default",@"module_id"]];
    
    
    
    
    
    self.chassis_rotation_speed = @"Скорость поворота стокового шасси";
    self.circular_vision_radius = @"Обзор стоковой башни";
    self.contour_image = @"URL к изображению-контуру танка";
    self.engine_power = @"Мощность стокового двигателя";
    self.gun_damage_max = @"Максимальный урон стокового орудия";
    self.gun_damage_min = @"Минимальный урон стокового орудия";
    self.gun_name = @"Название стокового орудия";
    self.gun_piercing_power_max = @"Максимальное пробитие стокового орудия";
    self.gun_piercing_power_min = @"Минимальное пробитие стокового орудия";
    self.gun_rate = @"Скорострельность стокового орудия";
    self.image = @"URL на изображения танка 160x100px";
    self.image_small = @"URL на изображения танка 124x31px";
    self.is_gift = @"Признак, что танк - подарочный";
    self.is_premium = @"Признак, что танк - премиумный";
    self.level = @"Уровень";
    self.limit_weight = @"Предельный вес";
    self.max_health = @"Прочность";
    self.name = @"Название";
    self.name_i18n = @"Локализация названия";
    self.nation = @"Нация";
    self.nation_i18n = @"Локализация нация";
    self.price_credit = @"Цена в кредитах";
    self.price_gold = @"Цена в золоте";
    self.radio_distance = @"Дистанция стоковой радиостанции";
    self.short_name_i18n = @"Локализированное короткое название танка";
    self.speed_limit = @"Максимальная скорость";
    self.tank_id = @"Идентификатор танка";
    self.turret_armor_board = @"Бортовая броня стоковой башни";
    self.turret_armor_fedd = @"Кормовая броня стоковой башни";
    self.turret_armor_forehead = @"Лобовая броня стоковой башни";
    self.turret_rotation_speed = @"Скорость вращения стоковой башни";
    self.type = @"Тип танка";
    self.type_i18n = @"Локализированный тип танка";
    self.vehicle_armor_board = @"Бортовая броня корпуса";
    self.vehicle_armor_fedd = @"Кормовая броня корпуса";
    self.vehicle_armor_forehead = @"Лобовая броня корпуса";
    self.weight = @"Вес";
    
    
    
    self.chassis_is_default =@"Признак, что модуль стоковый";
    self.chassis_module_id =@"Идентификатор модуля";
    
    self.crew_role =@"Роль члена экипажа";
    self.crew_role_i18n =@"Локализация роли члена экипажа";
    
    self.engines_is_default =@"Признак, что модуль стоковый";
    self.engines_module_id =@"Идентификатор модуля";
    
    self.guns_is_default =@"Признак, что модуль стоковый";
    self.guns_module_id =@"Идентификатор модуля";
    
    self.radios_is_default =@"Признак, что модуль стоковый";
    self.radios_module_id =@"Идентификатор модуля";
    
    self.turrets_is_default =@"Признак, что модуль стоковый";
    self.turrets_module_id =@"Идентификатор модуля";
    
    
    self.section1 = [[NSDictionary alloc] initWithObjects:@[ self.chassis_rotation_speed,self.circular_vision_radius,
                                                             self.contour_image,self.engine_power,
                                                             self.gun_damage_max,self.gun_damage_min,
                                                             self.gun_name,self.gun_piercing_power_max,
                                                             self.gun_piercing_power_min,self.gun_rate,
                                                             self.image,self.image_small,
                                                             self.is_gift,self.is_premium,
                                                             self.level,self.limit_weight,
                                                             self.max_health,self.name_i18n,
                                                             self.nation,self.nation_i18n ,
                                                             self.price_credit,self.price_gold,

                                                             self.radio_distance,
                                                             self.short_name_i18n,
                                                             self.speed_limit,
                                                             self.tank_id,
                                                             self.turret_armor_board,
                                                             self.turret_armor_fedd,
                                                             self.turret_armor_forehead,
                                                             self.turret_rotation_speed,
                                                             self.type,
                                                             self.type_i18n,
                                                             self.vehicle_armor_board,
                                                             self.vehicle_armor_fedd,
                                                             self.vehicle_armor_forehead ,
                                                             self.weight] forKeys:@[@"chassis_rotation_speed",
                                                                                    @"circular_vision_radius",
                                                                                    @"contour_image",@"engine_power",
                                                                                    @"gun_damage_max",
                                                                                    @"gun_damage_min",
                                                                                    @"gun_name",
                                                                                    @"gun_piercing_power_max",
                                                                                    @"gun_piercing_power_min",
                                                                                     @"gun_rate",
                                                                                    @"image",
                                                                                     @"image_small",
                                                                                    @"is_gift", @"is_premium", @"level", @"limit_weight",
                                                                                    @"max_health",
                                                                                     @"nation",
                                                                                    @"name_i18n",
                                                                                    @"nation_i18n",
                                                                                     @"price_credit",
                                                                                    @"price_gold",
                                                                                     @"radio_distance",
                                                                                    @"short_name_i18n",
                                                                                     @"speed_limit",
                                                                                    @"tank_id",
                                                                                     @"turret_armor_board",
                                                                                    @"turret_armor_fedd",
                                                                                       @"turret_armor_forehead",
                                                                                    @"turret_rotation_speed",
                                                                                       @"type",
                                                                                    @"type_i18n",
                                                                                       @"vehicle_armor_board",
                                                                                    @"vehicle_armor_fedd",
                                                                                       @"vehicle_armor_forehead",
                                                                                    @"weight"]];
    
    
    
    self.section2 = [[NSDictionary alloc] initWithObjects:@[ self.chassis_is_default,
                                                             self.chassis_module_id] forKeys:@[@"is_default",@"module_id"]];
    
    self.section3 = [[NSDictionary alloc] initWithObjects:@[ self.crew_role,
                                                             self.crew_role_i18n] forKeys:@[@"role",@"role_i18n"]];
    
    
    
    self.section4 = [[NSDictionary alloc] initWithObjects:@[self.engines_is_default,
                                                            self.engines_module_id]
                                                  forKeys:@[@"is_default",@"module_id"]];
    
    
    self.section5 = [[NSDictionary alloc] initWithObjects:@[self.guns_is_default,
                                                            self.guns_module_id ] forKeys:@[@"is_default",@"module_id"]];
    
    
    self.section6 = [[NSDictionary alloc] initWithObjects:@[ self.radios_is_default,
                                                             self.radios_module_id ] forKeys:@[@"is_default",@"module_id"]];
    
    self.section7 = [[NSDictionary alloc] initWithObjects:@[ self.turrets_is_default,
                                                             self.turrets_module_id] forKeys:@[@"is_default",@"module_id"]];
    
    
    
    return self;
    
}
@end
