//
//  ViewControllerRetiro.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 28/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerRetiro.h"
#import "iToast.h"
#import "ViewControllerVerTarjetas.h"
#import "KuBDD.h"

@interface ViewControllerRetiro ()

@end

@implementation ViewControllerRetiro
@synthesize BTNacepar,clabe1,clabe2,monto, destino, clabeLabel, distanciaBTNAceparDeMonto, beneficiario, beneficiarioLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view  setBackgroundColor:[[ UIColor alloc] initWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
    [destino addTarget:self
                  action:@selector(pickOne:)
        forControlEvents:UIControlEventValueChanged];
    [self kuTopbar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickOne:(id)sender{
    NSLog(@"piker: %ld",(long)[destino selectedSegmentIndex]);
    
    if ([destino selectedSegmentIndex]==0) {
        [clabeLabel setHidden:YES];
        [clabe1 setHidden:YES];
        [clabe2 setHidden:YES];
        [beneficiarioLabel setHidden:YES];
        [beneficiario setHidden:YES];
        distanciaBTNAceparDeMonto.constant = 38.0;
      
    }else if ([destino selectedSegmentIndex]==1){
        [clabeLabel setHidden:NO];
        [clabe1 setHidden:NO];
        [clabe2 setHidden:NO];
        [beneficiarioLabel setHidden:NO];
        [beneficiario setHidden:NO];
        distanciaBTNAceparDeMonto.constant = 210.0;

    }
}

-(void)kuTopbar{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"opciones"] style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    
    
    [self.navigationItem setLeftBarButtonItem:button];
    [self.navigationItem setTitle:@"Retiro"];
}


- (IBAction)onAceptar:(id)sender {
    if (![[monto text] isEqualToString:@""]) {
        monto.backgroundColor = [UIColor whiteColor];
        
        
        if (destino.selectedSegmentIndex == 0) {
            ViewControllerVerTarjetas *tarjetas =  [[ViewControllerVerTarjetas alloc]init];
            [tarjetas setMonto:[self.monto text]];
            [tarjetas setDeposito:NO];
            [[self navigationController] pushViewController:tarjetas animated:YES];
            
        }else{
            
            if (![[clabe1 text] isEqualToString:@""]) {
                clabe1.backgroundColor = [UIColor whiteColor];
                
                if (![[clabe2 text] isEqualToString:@""]) {
                    clabe2.backgroundColor = [UIColor whiteColor];
                    
                    
                    if ([[clabe2 text] isEqualToString:[clabe1 text]]) {
                        clabe2.backgroundColor = [UIColor whiteColor];
                        
                        if (![[beneficiario text] isEqualToString:@""]) {
                            beneficiario.backgroundColor = [UIColor whiteColor];
                    
            
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Confirma tu retiro" message:[NSString stringWithFormat:@"¿Deseas retirar $%@ a la cuenta interbancaria %@?",[monto text],[clabe1 text]] delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
            al.tag = 789;
            [al show];
                            
                        }else{
                            [[[iToast makeText:@"Indica el beneficiario"]setDuration:2000] show] ;
                            [beneficiario becomeFirstResponder];
                            beneficiario.backgroundColor = [UIColor yellowColor];
                        }
                    
                    }else{
                        [[[iToast makeText:@"La cuenta CLABE no coincide"]setDuration:2000] show] ;
                       
                        clabe2.backgroundColor = [UIColor yellowColor];
                        [clabe1 becomeFirstResponder];
                        clabe1.backgroundColor = [UIColor yellowColor];
                        
                        
                    }
                    
                }else{
                    [[[iToast makeText:@"Repite la CLABE"]setDuration:2000] show] ;
                    [clabe2 becomeFirstResponder];
                    clabe2.backgroundColor = [UIColor yellowColor];
                    
                    
                }
                
            }else{
                [[[iToast makeText:@"Ingresa la CLABE"]setDuration:2000] show] ;
                [clabe1 becomeFirstResponder];
                clabe1.backgroundColor = [UIColor yellowColor];
                
                
            }
            
        }
        
        
    }else{
        [[[iToast makeText:@"Cantidad vacia"]setDuration:2000] show] ;
        [monto becomeFirstResponder];
        monto.backgroundColor = [UIColor yellowColor];
        
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 789 && buttonIndex == 1) {
        [self pedirPinYenviar];
    }
    if (alertView.tag==450 && buttonIndex==1) {
        KuBDD * bd = [[KuBDD alloc]init];
        [bd abrirKuBDD];
        
        self.request = [[KUSoket alloc] init];
        [self.request setDelegate:self];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setObject:[beneficiario text] forKey:@"beneficiario"];
        [data setObject:[clabe1 text] forKey:@"clabe"];
        [data setObject:[monto text] forKey:@"monto"];
        [data setObject:[bd obtenerDatoConKey:@"id" deLaTabla:@"USR"] forKey:@"usr"];
        [data setObject:[bd obtenerDatoConKey:@"kuPrivKey" deLaTabla:@"USR"] forKey:@"imei"];
        [data setObject:[[self.pinalert textFieldAtIndex:0] text] forKey:@"pin"];
        [self.request startRequestForAction:@"22" andData:data];
        self.transfiriendoDialog = [[UIAlertView alloc] initWithTitle:@"Transferencia en proceso" message:@"Espera un momento \n\n\n\n"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:nil, nil];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.center = CGPointMake(139.5, 95.5); // .5 so it doesn't blur
        self.transfiriendoDialog.tag = 450;
        [self.transfiriendoDialog addSubview:spinner];
        [spinner startAnimating];
        [self.transfiriendoDialog show];
        
    }
    
}
-(void)pedirPinYenviar{
    self.pinalert = [[UIAlertView alloc] initWithTitle:@"Ingresa tu PIN" message:@"Ingresa tu pin de seguridad (4 digitos)" delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
    self.pinalert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    self.pinalert.tag =	450;
    [[self.pinalert textFieldAtIndex: 0] setTextAlignment:NSTextAlignmentCenter];
    [[self.pinalert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [self.pinalert show];
}



-(void)processCompletedWhitResult:(NSDictionary *)result inAcction:(NSNumber *)acction{
    [self.transfiriendoDialog dismissWithClickedButtonIndex:-1 animated:YES];
    if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"EXITO"]) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Retiro exitoso" message:@"El retiro de saldo con tu tarjeta ha sido realizado con éxito.\nPuedes confirmarlo en tu registro de movimientos y se vera reflejado en tu centa bancaria en las proximas 48 horas." delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [al show];
        
    }else if([[result objectForKey:@"RESULTADO"] isEqualToString:@"FALLA"]) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Operación declinada" message:[result[@"DATOS"] objectForKey:@"MENSAJE"]delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [al show];
        
    }
}

@end
