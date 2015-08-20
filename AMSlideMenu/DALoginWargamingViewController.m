//
//  DALoginWargamingViewController.m
//  AMSlideMenu
//
//  Created by Егор on 8/24/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DALoginWargamingViewController.h"
#import "VKNetworkingVK.h"
#import "MainVC.h"
@interface DALoginWargamingViewController ()
@property (copy, nonatomic) DALoginCompletionBlock completionBlock;
@property (weak, nonatomic) UIWebView* webView;
@property(nonatomic, weak) VKNetworkingVK *network;
@property(nonatomic, strong) NSTimer *timer;

@end

@implementation DALoginWargamingViewController



- (id) initWithCompletionBlock:(DALoginCompletionBlock) completionBlock {
    
    self = [super init];
    if (self)
    {
        self.completionBlock = completionBlock;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.network = [VKNetworkingVK sharedInstance];
    CGRect r = self.view.bounds;
    r.origin = CGPointZero;
    
   
        UIWebView* webView = [[UIWebView alloc] initWithFrame:r];
        
        webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self.view addSubview:webView];
        
        self.webView = webView;
        

        self.navigationItem.title = @"Wargaming";
    
        
        NSString* urlString =
        @"https://api.worldoftanks.ru/wot/auth/login/?application_id=c1b89f7d89ac48316cb8515b5f816573&redirect_uri=https://ru.wargaming.net/developers/api_explorer/wot/auth/login/complete/&display=popup";
        
        NSURL* url = [NSURL URLWithString:urlString];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        
        webView.delegate = self;
        
        [webView loadRequest:request];
    
   
    
}
- (void) actionCancel:(UIBarButtonItem*) item {
    
    if (self.completionBlock) {
        self.completionBlock(nil);
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark - UIWebViewDelegete

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   

    
    
    
    if ([[[request URL] description] rangeOfString:@"&access_token="].location != NSNotFound)
    {
        DAAccesTokenWarg* token = [[DAAccesTokenWarg alloc] init];
        NSString* query = [[request URL] description];
        NSArray* array = [query componentsSeparatedByString:@"?"];
        
        if ([array count] > 1) {
            query = [array lastObject];
        }

        NSArray* pairs = [query componentsSeparatedByString:@"&"];
        
        for (NSString* pair in pairs)
        {
            NSArray* values = [pair componentsSeparatedByString:@"="];
            if ([values count] == 2) {
                NSString* key = [values firstObject];
                NSLog(@"%@", key);
                if ([key isEqualToString:@"account_id"])
                {
                    self.network.userID = [values lastObject] ;
                }
                if ([key isEqualToString:@"expires_at"])
                {
                    
                    NSTimeInterval interval = [[values lastObject] doubleValue];
                    self.network.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                }
                if ([key isEqualToString:@"access_token"])
                {
                     self.network.accessTokenString = [values lastObject];
                }
                if ([key isEqualToString:@"nickname"])
                {
                     self.network.nickname = [values lastObject];
                }
            }
        }
        
        self.webView.delegate = nil;
        
        if (self.completionBlock) {
            self.completionBlock(token);
        }
        

        [self.network saveSettings];
        
        
        
        [self dismissViewControllerAnimated:YES
                                 completion:nil];

        return NO;
    }

    return YES;
}


@end
