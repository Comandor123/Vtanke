//
//  DASplashSegue.m
//  AMSlideMenu
//
//  Created by Егор on 8/25/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DASplashSegue.h"

@implementation DASplashSegue
- ( void ) perform
{
    // Для перехода к стартовому экрану будем использовать стандартный presentModalViewController.
    // Обратите внимание на параметр animated, я намеренно установил его в NO, т.к. анимацию перехода
    // мы выполнили заранее.
    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
}
@end
