//
//  ViewControllerTarjetaNueva.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 04/11/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerTarjetaNueva.h"

@interface ViewControllerTarjetaNueva ()

@end

@implementation ViewControllerTarjetaNueva
@synthesize BTNinfoCVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
        [[self navigationItem] setTitle:@"Nueva Tarjeta"];
        
        BTNinfoCVC.tintColor = [UIColor whiteColor];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == 450 && buttonIndex == 1){
        //LOADER TRANSFIRIENDO
        self.pin = [[self.pinalert textFieldAtIndex:0] text];
        self.transfiriendoDialog = [[UIAlertView alloc] initWithTitle:@"Encriptando datos" message:@"Espera un momento \n\n\n\n"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:nil, nil];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.center = CGPointMake(139.5, 95.5); // .5 so it doesn't blur
        self.transfiriendoDialog.tag = 450;
        [self.transfiriendoDialog addSubview:spinner];
        [spinner startAnimating];
        [self.transfiriendoDialog show];
        
        KuBDD *bdd = [[KuBDD alloc] init];
        [bdd abrirBDDenPath:@"database.kupay"];
        NSString *imei = [bdd obtenerDatoConKey:@"kuPrivKey" deLaTabla:@"USR"];
        NSString *usr = [bdd obtenerDatoConKey:@"id" deLaTabla:@"USR"];
        
        NSLog(@"DATOS EN BDD %@, %@", imei, usr);
        //   [request cancel];
        //    [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://kupay.tk/kuCloudAppDev/index.php"]]];
        
        NSMutableDictionary *nameElements = [NSMutableDictionary dictionary];
        
        [nameElements setObject:usr forKey:@"usr"];
        [nameElements setObject:self.pin forKey:@"pin"];
        [nameElements setObject:imei forKey:@"imei"];
        [nameElements setObject:[self.INPUTtitular text] forKey: @"nombre_titular"];
        [nameElements setObject:[self.INPUTtarjeta text] forKey: @"numero_tarjeta"];
        [nameElements setObject:[self.INPUTcvc text] forKey: @"cvv"];
        [nameElements setObject:[self.INPUTmes text] forKey: @"exp_mes"];
        [nameElements setObject:[self.INPUTanio text] forKey: @"exp_anio"];
        
        
        self.request = [[KUSoket alloc] init];
        self.request.delegate = self;
        [self.request startRequestForAction:@"11" andData:nameElements];
    }
}

-(void)processCompletedWhitResult:(NSDictionary *)result inAcction:(NSNumber *)acction{
    [self.transfiriendoDialog dismissWithClickedButtonIndex:-1 animated:YES];
    switch ([acction integerValue]) {
        case 11:
            if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"EXITO"]) {
                NSString *nombre = [[self.INPUTtarjeta text] substringFromIndex:12];
                KuBDD *inserT = [[KuBDD alloc] init];
                [inserT abrirKuBDD];
         
                
            BOOL x   =  [inserT Update:[NSString stringWithFormat:@"INSERT INTO TARJETA (nombre,numero_tarjeta_cryp, nombre_titular_cryp,exp_mes_cryp,exp_anio_cryp,cvv_cryp) values ('%@','%@','%@','%@','%@','%@')",
                                [NSString stringWithFormat:@"************%@",nombre],
                                [result[@"DATOS"] objectForKey:@"numero_tarjeta_cryp"],
                                [result[@"DATOS"] objectForKey:@"nombre_titular_cryp"],
                                [result[@"DATOS"] objectForKey:@"exp_mes_cryp"],
                                [result[@"DATOS"] objectForKey:@"exp_anio_cryp"],
                                [result[@"DATOS"] objectForKey:@"cvv_cryp"]]];
                
                
                
                if (x) {
                  
                    [[self navigationController] popViewControllerAnimated:YES];
                }
                
            } else if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"FALLA"]) {
                UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Tarjeta no registrada" message:[result[@"DATOS"] objectForKey:@"MENSAJE"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [al show];
            }

            break;
            
        default:
            break;
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

-(BOOL)validarCampos{
    return YES;
}

- (IBAction)onAceptar:(id)sender {
    
    if ([self validarCampos]) {
        [self pedirPinYenviar];
    }
    
}
@end
