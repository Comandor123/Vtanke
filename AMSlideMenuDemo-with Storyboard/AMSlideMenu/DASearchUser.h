//
//  DASearchUser.h
//  AMSlideMenu
//
//  Created by Егор on 8/25/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DASearchUser : NSObject
@property(nonatomic, strong)NSMutableArray* nickname;
@property(nonatomic, strong)NSMutableArray* account_id;
- (instancetype)initWithDictionary:(NSArray *) responseObject;

@end
