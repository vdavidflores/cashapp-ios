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
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"opciones"] style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    
    
    [self.navigationItem setLeftBarButtonItem:button];
    [self.navigationItem setTitle:@"Desenlaze"];
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
        [bdd Update:@"DROP TABLE TARJETA"];
        [bdd cerrarBdd];
        
        ViewControllerPregunta *preg = [[ViewControllerPregunta alloc] init];
        [self presentViewController:preg animated:YES completion:nil];
      
    }
    
}

@end
