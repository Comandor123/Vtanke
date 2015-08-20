//
//  DAUserVK.h
//  AMSlideMenu
//
//  Created by Егор on 8/24/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAUserVK : NSObject
@property(nonatomic, strong) NSArray *arrayName;
@property(nonatomic, strong) NSArray *arrayFamily;
@property(nonatomic, strong) NSArray *arrayPhoto;



- (instancetype)initWithArrayName:(NSArray *) arrayName andFamily:(NSArray *) arrayFamily andPhoto:(NSArray *) arrayPhoto;




@end
