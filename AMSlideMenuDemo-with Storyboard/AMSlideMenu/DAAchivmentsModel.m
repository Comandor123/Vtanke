//
//  DAAchivmentsModel.m
//  VTanke
//
//  Created by Егор on 9/8/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAAchivmentsModel.h"

@implementation DAAchivmentsModel




- (instancetype)initWithDictionary:(NSDictionary *) responseObject andArrayAll:(NSArray*) arrayAl
{

    self.arraAll = [NSMutableArray array];
    self.arraCountAchiv = [NSMutableArray array];
    [self.arraAll addObjectsFromArray:arrayAl];
    NSLog(@"%lu", [self.arraAll count]);
    
    self.setAllAchivments = [NSMutableSet setWithArray:self.arraAll];
    self.arrayMyAchivments = [NSMutableArray array];
    self.arrrayNotAcchivments = [NSMutableArray array];
    [self.arrayMyAchivments addObjectsFromArray:[responseObject allKeys]];
    
    for (NSString*string in self.arraAll) {
        for (NSString *strinTwo in self.arrayMyAchivments) {
   

            if (![string isEqualToString:strinTwo]) {
                [self.arrrayNotAcchivments addObject:strinTwo];
            }
        }
    }

    return self;
}
@end
