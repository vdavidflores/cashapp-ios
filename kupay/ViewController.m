//
//  ViewController.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 12/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewController.h"


#import "ViewControllerEscanear.h"
#import "ViewControllerTransferir.h"
#import "ViewControllerConsultar.h"
@interface ViewController ()

@end


@implementation ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        ViewControllerEscanear *escanear = [[ViewControllerEscanear alloc]  initWithNibName:@"ViewControllerEscanear" bundle:nil];
        ViewControllerTransferir *transferir = [[ViewControllerTransferir alloc]  initWithNibName:@"ViewControllerTransferir" bundle:nil];
        
        ViewControllerConsultar *consultar = [[ViewControllerConsultar alloc]  initWithNibName:@"ViewControllerConsultar" bundle:nil];
        
        [consultar setTitle:@"consultar"];
        
        [consultar.tabBarItem setTitle:@"consultar"];
        [escanear.tabBarItem setTitle:@"escanear"];
        [transferir.tabBarItem setTitle:@"transferir"];
        
        [escanear.tabBarItem setImage:[UIImage imageNamed:@"ku"]];
      
        self.selectedIndex = 2;
        
        NSArray* controlers = [NSArray arrayWithObjects:escanear,transferir,consultar,nil];
            [self setViewControllers:controlers];
        
     //  [self setTabEdgeColor:[UIColor clearColor]];
     //   [self setTabInnerStrokeColor:[UIColor yellowColor]];
        //[self beginAppearanceTransition:NO animated:NO];
      //  [self setTopEdgeColor:[UIColor yellowColor]];
       
       /*   [self setTabStrokeColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        
                [self setIconShadowColor:[UIColor clearColor]];
        [self setIconGlossyIsHidden:YES];
        */
       // [self setHidesBottomBarWhenPushed:YES];
    //    [self setSelectedTabColors:@[[UIColor whiteColor],[UIColor whiteColor]]];
      //  [self setBackgroundImageName:@"kucolor"];
        
        
        /////////////////////////////////////////////////////////////////////////////////////////
        
        [self.tabBarController.tabBar setTranslucent:NO];
        
        [[UITabBar appearance] setBackgroundColor:[UIColor redColor]];
        
       [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"kucolor"]];
      
        [[UITabBar appearance] setTintColor:[UIColor clearColor]];
        
        
        CGRect frame = CGRectMake(0.0, 0, self.view.bounds.size.width, 49);
        
        UIView *v = [[UIView alloc] initWithFrame:frame];
        
        [v setBackgroundColor:[[UIColor alloc] initWithRed:197.0/255.0
                                                     green:30.0/255.0
                                                      blue:79.0/255.0
                                                     alpha:1.0]];
        [[UITabBar appearance] insertSubview:v atIndex:0];
        
       // [[UITabBar appearance] setSelectedImageTintColor:[UIColor clearColor]];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
      //[v release];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
