//
//  DASearchUser.m
//  AMSlideMenu
//
//  Created by Егор on 8/25/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DASearchUser.h"

@implementation DASearchUser
- (instancetype)initWithDictionary:(NSArray *) responseObject
{
    self.nickname = [NSMutableArray array];
    self.account_id = [NSMutableArray array];
    for (NSDictionary*object in responseObject) {
        [self.nickname addObject:[object objectForKey:@"nickname"]];
        [self.account_id addObject:[[object objectForKey:@"account_id"] stringValue]];
        
        

    }

       return self;
}
@end
