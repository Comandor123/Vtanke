//
//  DASpisokTankovModel.m
//  VTanke
//
//  Created by Егор on 9/3/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DASpisokTankovModel.h"

@implementation DASpisokTankovModel
-(instancetype)initWithDictionary:(NSDictionary*) dictionary
{
   // NSLog(@"%@", dictionary);
    NSArray*arrayKeys = [NSArray arrayWithArray:[dictionary allKeys]];
    self.arrayAll = [NSMutableArray array];

    self.arrayName = [NSMutableArray array];
    self.arraySortName = [NSMutableArray array];

    self.arrayNation = [NSMutableArray array];
    self.arrayLevel = [NSMutableArray array];
    self.arrayType = [NSMutableArray array];
    self.arrayTankID = [NSMutableArray array];

    for (int i = 0; i<=[arrayKeys count] - 1; i++)
    {
        [self.arrayAll addObject:[dictionary valueForKey:[arrayKeys objectAtIndex:i]]];
    }
    
    for (NSDictionary*curentDict in self.arrayAll)
    {
        [self.arrayName addObject:[curentDict valueForKey:@"name_i18n"]];
        [self.arrayNation addObject:[curentDict valueForKey:@"nation"]];
        [self.arrayLevel addObject:[curentDict valueForKey:@"level"]];
        [self.arrayType addObject:[curentDict valueForKey:@"type"]];
        [self.arrayTankID addObject:[curentDict valueForKey:@"tank_id"]];
    }
    
    return self;
}
@end
