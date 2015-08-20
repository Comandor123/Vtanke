//
//  DAInfoAchivmentsByNAme.m
//  VTanke
//
//  Created by Егор on 9/9/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAInfoAchivmentsByNAme.h"

@implementation DAInfoAchivmentsByNAme
- (instancetype)initWithDictionary:(NSDictionary *) responseObject{
    
    self.name = [responseObject objectForKey:@"name"];
    self.section_rus = [responseObject objectForKey:@"section_i18n"];
    self.description = [responseObject objectForKey:@"description"];
    self.name_rus = [responseObject objectForKey:@"name_i18n"];
    self.options = [responseObject objectForKey:@"options"];
    self.image_big = [responseObject objectForKey:@"image_big"];
    self.condition = [responseObject objectForKey:@"condition"];

    
    if([self.condition  isKindOfClass:[NSNull class]]) {
        self.condition  = @"нет";
    }
  
    if ([self.options isKindOfClass:[NSArray class]]) {
        NSArray *array = [NSArray arrayWithArray:[responseObject objectForKey:@"options"]];
        self.image_big =  [[array firstObject] objectForKey:@"image_big"];
    }
    if([self.options  isKindOfClass:[NSNull class]]) {
        self.options  = [NSMutableArray arrayWithArray:@[@"нет"]];
    }
    
    
    return self;
    
}
@end
