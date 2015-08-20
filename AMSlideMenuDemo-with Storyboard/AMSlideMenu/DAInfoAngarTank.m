//
//  DAInfoAngarTank.m
//  VTanke
//
//  Created by Егор on 9/19/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAInfoAngarTank.h"

@implementation DAInfoAngarTank


- (instancetype)initWithDictionary:(NSArray *) responseObject{
    
    
    self.arrayCountBattles = [NSMutableArray array];
    self.arrayCountWins = [NSMutableArray array];
    self.arrayCountBattlesSort = [NSMutableArray array];
    self.arrayCountWinsSort = [NSMutableArray array];
    self.arrayMarkOfMistery = [NSMutableArray array];
    self.arrayTankIDandName = [NSMutableDictionary dictionary];
    self.arrayTankIDSort = [NSMutableArray array];
    self.arrayTankID = [NSMutableArray array];

    self.arrayTankName = [NSMutableArray array];
    self.arrayImage = [NSMutableArray array];
    
        for (NSDictionary*dict in responseObject) {
            [self.arrayTankID addObject:[dict objectForKey:@"tank_id"]];
            
            [self.arrayMarkOfMistery addObject:[dict objectForKey:@"mark_of_mastery"]];
            [self.arrayCountWins addObject:[[dict objectForKey:@"statistics"] objectForKey:@"wins"] ];
            [self.arrayCountBattles addObject:[[dict objectForKey:@"statistics"] objectForKey:@"battles"] ];
            
    
   
    
        }
    
       
    
    
    
    
    return self;
    
}



@end
