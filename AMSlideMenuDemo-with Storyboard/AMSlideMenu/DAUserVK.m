//
//  DAUserVK.m
//  AMSlideMenu
//
//  Created by Егор on 8/24/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DAUserVK.h"

@implementation DAUserVK

- (instancetype)initWithArrayName:(NSArray *) arrayName andFamily:(NSArray *) arrayFamily andPhoto:(NSArray *) arrayPhoto{
    
    self = [super init];
    if (self) {
        self.arrayFamily = arrayFamily;
        self.arrayName = arrayName;
        self.arrayPhoto = arrayPhoto;
    
    }
        return self;
}
@end
