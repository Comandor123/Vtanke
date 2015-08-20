//
//  DASpisokTankovModel.h
//  VTanke
//
//  Created by Егор on 9/3/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DASpisokTankovModel : NSObject
@property(nonatomic, strong) NSMutableArray *arrayAll;

@property(nonatomic, strong) NSMutableArray *arrayName;
@property(nonatomic, strong) NSMutableArray *arraySortName;

@property(nonatomic, strong) NSMutableArray *arrayNation;
@property(nonatomic, strong) NSMutableArray *arrayLevel;
@property(nonatomic, strong) NSMutableArray *arrayType;
@property(nonatomic, strong) NSMutableArray *arrayTankID;

-(instancetype)initWithDictionary:(NSDictionary*) dictionary;

@end
