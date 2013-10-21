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
        
        
        
        [consultar.tabBarItem setTitle:@"consultar"];
        [escanear.tabBarItem setTitle:@"escanear"];
        [transferir.tabBarItem setTitle:@"transferir"];
        
        [escanear.tabBarItem setImage:[UIImage imageNamed:@"scanerLogoUnselected"]];
        [escanear.tabBarItem  setSelectedImage:[UIImage imageNamed:@"scanerLogoSelected"]];
        [consultar.tabBarItem setImage:[UIImage imageNamed:@"historyLogoUnselected"]];
        [consultar.tabBarItem setSelectedImage:[UIImage imageNamed:@"historyLogoSelected"]];
        [transferir.tabBarItem setImage:[UIImage imageNamed:@"transferLogoUnselected"]];
        [transferir.tabBarItem setSelectedImage:[UIImage imageNamed:@"transferLogoSelected"]];
        
        
        self.selectedIndex = 2;
        
        NSArray* controlers = [NSArray arrayWithObjects:escanear,transferir,consultar,nil];
        [self setViewControllers:controlers];
        
        [self.tabBarController.tabBar setTranslucent:NO];
    
        
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor clearColor]];
        
        [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selectedTab"]];
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
        
        [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabhostbg"]];
        [[UITabBarItem appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0], UITextAttributeTextColor,
          [UIFont fontWithName:@"ProximaNova-Semibold" size:0.0], UITextAttributeFont,
          nil]forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], UITextAttributeTextColor,
          [UIFont fontWithName:@"ProximaNova-Semibold" size:0.0], UITextAttributeFont,
          nil]forState:UIControlStateSelected];
        
        [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
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
