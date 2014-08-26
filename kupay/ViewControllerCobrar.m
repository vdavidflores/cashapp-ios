//
//  ViewControllerCobrar.m
//  kupay
//
//  Created by Codigo KU on 01/07/14.
//  Copyright (c) 2014 ku. All rights reserved.
//
#import "ViewControllerQR.h"
#import "ViewControllerCobrar.h"
#import "iToast.h"
#import "KuBDD.h"



@interface ViewControllerCobrar ()

@end

@implementation ViewControllerCobrar
@synthesize monto, concepto, pinalert,generandoDialog, generarReq;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view  setBackgroundColor:[[ UIColor alloc] initWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];

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

- (IBAction)onGenerar:(id)sender {
    
    if(![self.monto.text isEqualToString:@""])
    {
        self.monto.backgroundColor=[UIColor whiteColor];

        
        if(![self.monto.text isEqualToString:@""])
        {
            self.monto.backgroundColor=[UIColor whiteColor];
            
            
            self.pinalert = [[UIAlertView alloc] initWithTitle:@"Ingresa tu PIN" message:@"Ingresa tu pin de seguridad (4 digitos)" delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
            self.pinalert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            self.pinalert.tag =	450;
            [[self.pinalert textFieldAtIndex: 0] setTextAlignment:NSTextAlignmentCenter];
            [[self.pinalert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
            [self.pinalert show];

            
        }else{
            self.monto.backgroundColor=[UIColor yellowColor];
            [self.monto becomeFirstResponder];
            [[[iToast makeText:@"Monto no ingresado"] setDuration:2000] show];
        }
        
    }else{
        self.monto.backgroundColor=[UIColor yellowColor];
        [self.monto becomeFirstResponder];
        [[[iToast makeText:@"Monto no ingresado"] setDuration:2000] show];
    }

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if(alertView.tag == 450 && buttonIndex == 1 && ![[[self.pinalert textFieldAtIndex:0] text] isEqualToString:@""]){
        //LOADER TRANSFIRIENDO
        self.pin = [[self.pinalert textFieldAtIndex:0] text];
        generarReq = [[KUSoket alloc] init];
        generarReq.delegate = self;
        
        
        KuBDD *bdd = [[KuBDD alloc] init];
        [bdd abrirBDDenPath:@"database.kupay"];
        NSString *imei = [bdd obtenerDatoConKey:@"kuPrivKey" deLaTabla:@"USR"];
        NSString *usr = [bdd obtenerDatoConKey:@"id" deLaTabla:@"USR"];
        

        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        
       //NSData *bytes = [[NSFileHandle fileHandleForReadingAtPath: @"/dev/random"] readDataOfLength: 100];
        [data setObject:usr forKey:@"usr"];
        [data setObject:self.monto.text forKey:@"monto"];
        [data setObject:self.concepto.text forKey:@"concepto"];
        [data setObject:imei forKey:@"imei"];
        [data setObject:@"CARGO" forKey:@"tipo"];
        [data setObject:self.pin forKey:@"pin"];




        
        
        [generarReq startRequestForAction:@"3" andData:data];
        
        
        self.generandoDialog = [[UIAlertView alloc] initWithTitle:@"Generando QR" message:@"Espera un momento \n\n\n\n"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:nil, nil];
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.center = CGPointMake(139.5, 95.5); // .5 so it doesn't blur
        self.generandoDialog.tag = 450;
        [self.generandoDialog addSubview:spinner];
        [spinner startAnimating];
        [self.generandoDialog show];
    }
    
    
}

-(void)processCompletedWhitResult:(NSDictionary *)result inAcction:(NSNumber *)acction{
    
    [generandoDialog dismissWithClickedButtonIndex:-1 animated:YES];

    if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"EXITO"]) {
        
        NSLog(@"El resultado es: %@",[result[@"DATOS"] objectForKey:@"OPERACION"]);
        
        
        
        NSLog(@"OPERACION-------%@",[result[@"DATOS"] objectForKey:@"OPERACION"] );
        NSString *OP = [result[@"DATOS"] objectForKey:@"OPERACION"];
        
        ViewControllerQR *qr = [[ViewControllerQR alloc] init];
        [qr cargarQRconoperacion:OP];
        [[self navigationController] pushViewController:qr animated:YES];
        
    }else if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"FALLA"]){
        
        UIAlertView *alertaFalla = [[UIAlertView alloc] initWithTitle:@"Error al crear el cargo" message:[result[@"DATOS"] objectForKey:@"MENSAJE"]delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
        alertaFalla.tag =	459;
        [alertaFalla show];
        
    }else{
        [[[iToast makeText:@"Algo salio mal :("] setDuration:200] show];
    }
}
@end
