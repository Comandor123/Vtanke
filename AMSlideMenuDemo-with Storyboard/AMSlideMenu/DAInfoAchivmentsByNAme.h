//
//  DAInfoAchivmentsByNAme.h
//  VTanke
//
//  Created by Егор on 9/9/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAInfoAchivmentsByNAme : NSObject

@property(nonatomic, strong) NSString * name;
@property(nonatomic, strong) NSString * section_rus;
@property(nonatomic, strong) NSString * image_big;
@property(nonatomic, strong) NSString * description;
@property(nonatomic, strong) NSString * condition;
@property(nonatomic, strong) NSString * name_rus;
@property(nonatomic, strong) NSMutableArray *options;






- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
