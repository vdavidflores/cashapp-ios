//
//  ViewControllerPerfil.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 28/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerPerfil.h"

@interface ViewControllerPerfil ()

@end

@implementation ViewControllerPerfil

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self kuTopbar];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)kuTopbar{
    CGRect frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 55.0f);
    UIView *topBar = [[UIView alloc] initWithFrame:frame];
    topBar.backgroundColor =  [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
    
    //Boton refrescar
    UIButton *referscar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [referscar addTarget:self action:@selector(handlereferscar) forControlEvents:UIControlEventTouchUpInside];
    [referscar setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [referscar setFrame:CGRectMake(self.view.frame.size.width-50, 12, 36, 32)];
    
    //boton de navicon
    UIButton *navicon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // [navicon addTarget:self action:@selector(handlenavicon) forControlEvents:UIControlEventTouchUpInside];
    [navicon setBackgroundImage:[UIImage imageNamed:@"opciones"] forState:UIControlStateNormal];
    [navicon setFrame:CGRectMake(0, 3, 65, 50)];
    [navicon addTarget:self.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside ];
    
    
    //saldo
    UILabel* titulo = [[UILabel alloc]init];
    titulo.frame = CGRectMake(0,0,150,50.0);
    titulo.textAlignment = NSTextAlignmentCenter;
    titulo.textColor = [UIColor whiteColor];
    titulo.numberOfLines = 0;
    titulo.backgroundColor = [UIColor clearColor];
    titulo.text = @"Perfil";
    titulo.font = [titulo.font fontWithSize:20.0];
    
    [topBar addSubview:titulo];
    [titulo setCenter:CGPointMake(topBar.center.x, topBar.center.y)];
    [topBar addSubview:navicon];
    // [topBar addSubview:referscar];
    
    [self.view addSubview:topBar];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
