//
//  DALoginWargamingViewController.h
//  AMSlideMenu
//
//  Created by Егор on 8/24/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAAccesTokenWarg.h"
@interface DALoginWargamingViewController : UIViewController<UIWebViewDelegate>

typedef void(^DALoginCompletionBlock)(DAAccesTokenWarg* token);


- (id) initWithCompletionBlock:(DALoginCompletionBlock) completionBlock;
@end
