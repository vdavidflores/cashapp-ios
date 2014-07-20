//
//  ViewControllerInfo.m
//  kupay
//
//  Created by Codigo KU on 19/07/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import "ViewControllerInfo.h"

@interface ViewControllerInfo ()

@end

@implementation ViewControllerInfo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view  setBackgroundColor:[[ UIColor alloc] initWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
        
        [self kuTopbar];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)kuTopbar{
    
    
    CGRect frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 55.0f);
    UIView *topBar = [[UIView alloc] initWithFrame:frame];
    topBar.backgroundColor =  [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
    
    
    //boton de navicon
    UIButton *navicon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // [navicon addTarget:self action:@selector(handlenavicon) forControlEvents:UIControlEventTouchUpInside];
    [navicon setBackgroundImage:[UIImage imageNamed:@"opciones"] forState:UIControlStateNormal];
    [navicon setFrame:CGRectMake(0, 3, 65, 50)];
    [navicon addTarget:self.navigationController.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside ];
    
    
    
    //saldo
    UILabel* titulo = [[UILabel alloc] init];
    titulo.frame = CGRectMake(0,0,150,50.0);
    titulo.textAlignment = NSTextAlignmentCenter;
    titulo.textColor = [UIColor whiteColor];
    titulo.numberOfLines = 0;
    titulo.backgroundColor =[UIColor clearColor];
    titulo.text = @"Deposito";
    titulo.font = [titulo.font fontWithSize:20.0];
    
    [topBar addSubview:titulo];
    [titulo setCenter:CGPointMake(topBar.center.x, topBar.center.y)];
    [topBar addSubview:navicon];
    
    [self.view addSubview:topBar];
    

    
    
}

@end
