//
//  DAInfoAngarTank.h
//  VTanke
//
//  Created by Егор on 9/19/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAInfoAngarTank : NSObject
@property(nonatomic, strong) NSMutableDictionary *arrayTankIDandName;
@property(nonatomic, strong) NSMutableArray *arrayTankID;

@property(nonatomic, strong) NSMutableArray *arrayTankIDSort;

@property(nonatomic, strong) NSMutableArray *arrayTankName;
@property(nonatomic, strong) NSMutableArray  *arrayImage;
@property(nonatomic, strong) NSMutableArray* arrayCountWins;
@property(nonatomic, strong) NSMutableArray *arrayCountBattles;
@property(nonatomic, strong) NSMutableArray* arrayCountWinsSort;
@property(nonatomic, strong) NSMutableArray *arrayCountBattlesSort;
@property(nonatomic, strong) NSMutableArray *arrayMarkOfMistery;
- (instancetype)initWithDictionary:(NSArray *) responseObject;

@end
