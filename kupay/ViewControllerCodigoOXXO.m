//
//  ViewControllerCodigoOXXO.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 31/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerCodigoOXXO.h"

@interface ViewControllerCodigoOXXO ()

@end

@implementation ViewControllerCodigoOXXO

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
    [self kuTopbar];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self kuTopbar];
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
    [navicon addTarget:self action:@selector(atras:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //saldo
    UILabel* titulo = [[UILabel alloc] init];
    titulo.frame = CGRectMake(0,0,150,50.0);
    titulo.textAlignment = NSTextAlignmentCenter;
    titulo.textColor = [UIColor whiteColor];
    titulo.numberOfLines = 0;
    titulo.backgroundColor =[UIColor clearColor];
    titulo.text = @"Pago en OXXO";
    titulo.font = [titulo.font fontWithSize:20.0];
    
    [topBar addSubview:titulo];
    [titulo setCenter:CGPointMake(topBar.center.x, topBar.center.y)];
    [topBar addSubview:navicon];
    
    [self.view addSubview:topBar];
}
- (IBAction)atras:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
