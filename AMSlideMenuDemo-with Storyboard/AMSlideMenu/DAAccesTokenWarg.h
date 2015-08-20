//
//  DAAccesTokenWarg.h
//  AMSlideMenu
//
//  Created by Егор on 8/24/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAAccesTokenWarg : NSObject

@property (strong, nonatomic) NSString* nickname;

@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) NSDate* expirationDate;
@property (strong, nonatomic) NSString* userID;

@end
