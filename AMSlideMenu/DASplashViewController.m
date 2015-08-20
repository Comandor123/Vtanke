//
//  DASplashViewController.m
//  AMSlideMenu
//
//  Created by Егор on 8/25/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "DASplashViewController.h"

@interface DASplashViewController ()

@end

@implementation DASplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- ( void ) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Анимируем стандартными средствами Cocoa
    [UIView animateWithDuration:2.0 delay:0.2 options:0
                     animations:^
     {
         // Сделаем простую анимацию смещения логотипа вверх (в моём примере
         //  логотип встаёт на позицию, которая совпадает с онной в стартовом экране,
         //   чтобы переход не был заметен
         CGRect frame = self.imageView.frame;
         frame.origin.y = 15.0;
         self.imageView.frame = frame;
     }
                     completion:^( BOOL completed )
     {
         // По окончанию анимации выполним наш переход к стартовому экрану
         [self performSegueWithIdentifier:@"splash" sender:self];
     }];
}
@end
