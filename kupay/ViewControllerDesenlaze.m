//
//  ViewControllerDesenlaze.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 28/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerDesenlaze.h"
#import "KuBDD.h"
#import "ViewControllerPregunta.h"
@interface ViewControllerDesenlaze ()

@end

@implementation ViewControllerDesenlaze
@synthesize textview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        [self kuTopbar];
        textview.backgroundColor = [UIColor clearColor];
        [self.view  setBackgroundColor:[[ UIColor alloc] initWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
    }
    return self;
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
    UILabel* titulo = [[UILabel alloc] init];
    titulo.frame = CGRectMake(0,0,150,50.0);
    titulo.textAlignment = NSTextAlignmentCenter;
    titulo.textColor = [UIColor whiteColor];
    titulo.numberOfLines = 0;
    titulo.backgroundColor =[UIColor clearColor];
    titulo.text = @"Desenlaze";
    titulo.font = [titulo.font fontWithSize:20.0];
    
    [topBar addSubview:titulo];
    [titulo setCenter:CGPointMake(topBar.center.x, topBar.center.y)];
    [topBar addSubview:navicon];
    // [topBar addSubview:referscar];
    
    [self.view addSubview:topBar];
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

- (IBAction)onDesenlazar:(id)sender {
    
    UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Deseas desenlazar este equipo?" message:@"Se eliminarán todos los datos relacionados a tu cuenta de este dispositivo." delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
    
    [alert show];
    
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        KuBDD *bdd = [[KuBDD alloc] init];
        [bdd abrirBDDenPath:@"database.kupay"];
        [bdd actualizarCampo:@"id" conDato:@"ku" deLaTabla:@"USR"];
        [bdd actualizarCampo:@"kuPrivKey" conDato:@"ku" deLaTabla:@"USR"];
        [bdd cerrarBdd];
        
        ViewControllerPregunta *preg = [[ViewControllerPregunta alloc] init];
        [self presentViewController:preg animated:YES completion:nil];
      
    }
    
}

@end
