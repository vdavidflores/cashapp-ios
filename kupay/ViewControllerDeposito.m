//
//  ViewControllerDeposito.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 31/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerDeposito.h"
#import "ViewControllerCodigoOXXO.h"
#import "ViewControllerTarjetaNueva.h"
#import "iToast.h"
#import "KuBDD.h"
#import "ViewControllerVerTarjetas.h"
#import "ViewControllerVerTarjetas.h"

@interface ViewControllerDeposito ()

@end

@implementation ViewControllerDeposito
@synthesize segmentedControl,INPUTcantidad;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view  setBackgroundColor:[[ UIColor alloc] initWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
    
    [self kuTopbar];
    
      
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)kuTopbar{
    
    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"opciones"] style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    
    
    [self.navigationItem setLeftBarButtonItem:button];
    [self.navigationItem setTitle:@"Deposito"];

    [segmentedControl addTarget:self
                         action:@selector(pickOne:)
               forControlEvents:UIControlEventValueChanged];
    
	   
}

- (IBAction)Aceptoar:(id)sender {
    if (![[INPUTcantidad text] isEqualToString:@""]) {
        INPUTcantidad.backgroundColor = [UIColor whiteColor];
        
        if (segmentedControl.selectedSegmentIndex ==0){
            ViewControllerVerTarjetas *tarjetas = [[ViewControllerVerTarjetas alloc] init];
            [tarjetas setMonto:[INPUTcantidad text]];
            [tarjetas setDeposito:YES];
            [[self navigationController] pushViewController:tarjetas animated:YES];
        }
        
            if (segmentedControl.selectedSegmentIndex ==1){
                UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Fuera de servicio" message:@"Esta función se encuentra momentaneamente fuera de servicio" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
                [al show];

            }
               
        
            
            
        }else{
            [[[iToast makeText:@"Cantidad vacia"]setDuration:2000] show] ;
            [INPUTcantidad becomeFirstResponder];
            INPUTcantidad.backgroundColor = [UIColor yellowColor];
            
            
        }
        
        
    
}
-(void) pickOne:(id)sender{
        switch ([segmentedControl selectedSegmentIndex]) {
        case 0:
            [self mostrarInputs];
            [self.progress stopAnimating];
            [self.spei stopRequest];
        break;
            
        case 1:
            [self mostrarInputs];
            [self.progress stopAnimating];
            [self.spei stopRequest];
        break;
            
        case 2:
            [self ocultarInputs];
            [self.progress startAnimating];
            KuBDD *bdd = [[KuBDD alloc] init];
            [bdd abrirBDDenPath:@"database.kupay"];
            NSString *imei = [bdd obtenerDatoConKey:@"kuPrivKey" deLaTabla:@"USR"];
            NSString *usr = [bdd obtenerDatoConKey:@"id" deLaTabla:@"USR"];
            [bdd cerrarBdd];
            NSMutableDictionary  *data = [[NSMutableDictionary  alloc] init];
            [data setValue:imei forKey:@"imei"];
            [data setValue:usr forKey:@"usr"];
            [data setValue:@"1" forKey:@"monto"];
            self.spei = [[KUSoket alloc] init];
            self.spei.delegate = self;
            [self.spei startRequestForAction:@"21" andData:data];
        break;
    }
}

-(void)ocultarInputs{
    [self.BTNaceptar setHidden:YES];
    [self.TXTCantidad setHidden:YES];
    [self.INPUTcantidad setHidden:YES];
  
}
-(void)mostrarInputs{
    [self.BTNaceptar setHidden:NO];
    [self.TXTCantidad setHidden:NO];
    [self.INPUTcantidad setHidden:NO];
    [self.TXTspei setHidden:YES];
  
}


-(void)processCompletedWhitResult:(NSDictionary *)result inAcction:(NSNumber *)acction{
    
    switch ([acction integerValue]) {
        case 21:
            if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"EXITO"]) {
                [self.progress stopAnimating];
                self.TXTspei.text = [NSString stringWithFormat:@"Tu cuenta CLABE Interbancaria es: %@ del banco: %@, Transfiere desde tu banca en linea el saldo que deses y se vera reflejado en tu cuenta Cashapp.",[result[@"DATOS"] objectForKey:@"clabe"], [result[@"DATOS"] objectForKey:@"bank"]];
                [self.TXTspei setHidden:NO];
                
            }
            break;
            
        default:
            break;
    }
    
}

@end
