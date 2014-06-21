//
//  ViewControllerRegDatos.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 09/11/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerPregunta.h"
#import "ViewControllerRegDatos.h"
#import "ViewControllerEnlaze.h"

@interface ViewControllerPregunta ()

@end

@implementation ViewControllerPregunta

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
    
    [self.view setBackgroundColor:[UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
    
    
    
    UIImageView*imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"splash.png"]];
    [[self view] addSubview:imageView];
    [[self view] bringSubviewToFront:imageView];

    //now fade out splash image
   // [NSThread sleepForTimeInterval:5.0];
    [UIView transitionWithView:self.view duration:3.0f options:UIViewAnimationOptionTransitionNone animations:^(void){imageView.alpha=0.0f;} completion:^(BOOL finished){[imageView removeFromSuperview];}];    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSi:(id)sender {
   ViewControllerEnlaze *seg = [[ViewControllerEnlaze alloc] init];
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:seg ];
    
    
    [nc setNavigationBarHidden:YES];
    
    [self presentViewController:nc animated:YES completion:nil];
}

- (IBAction)onNo:(id)sender {
    ViewControllerRegDatos *regd = [[ViewControllerRegDatos alloc] init];
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:
                                   regd ];
    
    
    [nc setNavigationBarHidden:YES];
    
    [self presentViewController:nc animated:YES completion:nil];
}
@end
