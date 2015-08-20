//
//  DAAchivmentsModel.h
//  VTanke
//
//  Created by Егор on 9/8/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAAchivmentsModel : NSObject


@property(nonatomic, strong) NSMutableArray *arraAll;
@property(nonatomic, strong) NSMutableSet *setAllAchivments;
@property(nonatomic, strong) NSMutableArray *arrayMyAchivments;
@property(nonatomic, strong) NSMutableArray *arrrayNotAcchivments;
@property(nonatomic, strong) NSMutableArray *arraCountAchiv;





- (instancetype)initWithDictionary:(NSDictionary *) responseObject andArrayAll:(NSArray*) arrayAl;

@end
