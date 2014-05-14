//
//  ViewControllerTransferir.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 10/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerTransferir.h"
#import "ViewControllerMain.h"
#import "iToast.h"
#import "KuBDD.h"
@interface ViewControllerTransferir ()
-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest;
@end

@implementation ViewControllerTransferir
@synthesize campoPara,campoCantidad,request;

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
    
    self.view.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)onEnviar:(id)sender {
    
    
    
    if ([self validateEmailWithString:[campoPara text]]) {
        campoPara.backgroundColor = [UIColor whiteColor];
        if (![campoCantidad.text isEqualToString:@""]) {
            campoCantidad.backgroundColor = [UIColor whiteColor];
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Confirma tu transferencia." message:[NSString stringWithFormat:@"¿Deseas transferir $ %@ a %@?",campoCantidad.text,campoPara.text]   delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
            alert.tag =	1;
            //[alertView textFieldAtIndex: 0];
            [alert show];
            
        }else{
            [[[iToast makeText:@"Cantidad vacia"]setDuration:2000] show] ;
            [campoCantidad becomeFirstResponder];
            campoCantidad.backgroundColor = [UIColor yellowColor];
            
            
        }
        
        
    }else{
        [[[iToast makeText:@"Email invalido"] setDuration:2000] show];
        campoCantidad.backgroundColor = [UIColor whiteColor];
        [campoPara becomeFirstResponder];
        campoPara.backgroundColor = [UIColor yellowColor];
    }
  
   
}

- (IBAction)onParaInfo:(id)sender {
    
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Transferencia de saldo" message:@"Aqui se le da información al usuario sobre que significa transferir saldo, a quien se lo puede transferir y que pasa si el correo al que transfiere no esta dado de alta en kuPay." delegate:self  cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    alert.tag =	2;
    
    [alert show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1){
        if(buttonIndex == 1){
           // PIN
           self.pinalert = [[UIAlertView alloc] initWithTitle:@"Ingresa tu PIN" message:@"Ingresa tu pin de seguridad (4 digitos)" delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
            self.pinalert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            self.pinalert.tag =	450;
             [[self.pinalert textFieldAtIndex: 0] setTextAlignment:NSTextAlignmentCenter];
            [[self.pinalert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
            [self.pinalert show];
           

            
        }
        
    }
   
    if(alertView.tag == 450 && buttonIndex == 1){
        //LOADER TRANSFIRIENDO
        self.pin = [[self.pinalert textFieldAtIndex:0] text];
        [self pullData];
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

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


-(void)pullData{
    KuBDD *bdd = [[KuBDD alloc] init];
    [bdd abrirBDDenPath:@"database.kupay"];
    NSString *imei = [bdd obtenerDatoConKey:@"kuPrivKey" deLaTabla:@"USR"];
    NSString *usr = [bdd obtenerDatoConKey:@"id" deLaTabla:@"USR"];
    
    NSLog(@"DATOS EN BDD %@, %@", imei, usr);
    [request cancel];
    [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://kupay.tk/kuCloudAppDev/index.php"]]];
    
    NSMutableDictionary *nameElements = [NSMutableDictionary dictionary];
    
    [nameElements setObject:usr forKey:@"emisor"];
    [nameElements setObject:[self.campoPara text] forKey:@"receptor"];
    [nameElements setObject:[self.campoCantidad text] forKey:@"cantidad"];
    [nameElements setObject:self.pin forKey:@"pin"];
    [nameElements setObject:imei forKey:@"imei"];

    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:nameElements
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"DATA: %@", jsonString);
    
    [request setPostValue:@"1" forKey:@"ACCION"];
    [request setPostValue:jsonString forKey:@"DATA"];
    [request setTimeOutSeconds:20];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    [request setShouldContinueWhenAppEntersBackground:YES];
#endif
    
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(enrespuesta:)];
    [request setTag:390];
    [request startAsynchronous];
}

-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest{
    NSString *result = elrequest.responseString;
    NSError *error = nil;NSLog(@"respuesta es: %@",result);
    [self.transfiriendoDialog dismissWithClickedButtonIndex:-1 animated:YES];
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if([[dataDictionary objectForKey:@"RESULTADO"] isEqualToString:@"TRANSACCION_EXITOSA"]){
        
       ViewControllerMain *myTBC = (ViewControllerMain *)self.tabBarController;
        [myTBC actualizarSaldo];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Transferencia exitosa" message:@"Tu transferencia se ha realizado exitosamente" delegate:self  cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        alert.tag =	2765;
        
        [alert show];
        
    }else if([[dataDictionary objectForKey:@"RESULTADO"] isEqualToString:@"TRANSACCION_FALLIDA"]){
        NSLog(@"transaccion fallida");
        if([[dataDictionary[@"DATOS"] objectForKey:@"CAUSA_FALLA"] isEqualToString:@"FONDOS_INUFICIENTES"]){
             NSLog(@"no marmaja");
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Transferencia fallida" message:@"No cuentas con saldo suficiente para relizar esta operación" delegate:self  cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            alert.tag =	43564;
            [alert show];
        }else if([[dataDictionary[@"DATOS"] objectForKey:@"CAUSA_FALLA"] isEqualToString:@"USUARIO_INVALIDO"]){
            NSLog(@"usuario malo malo.");
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Transferencia fallida" message:@"Datos de seguridad invalidos, verifica tu pin" delegate:self  cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            alert.tag =	123443;
            [alert show];
        }else if([[dataDictionary[@"DATOS"] objectForKey:@"CAUSA_FALLA"] isEqualToString:@"FALLA_MENSAJE"]){
            NSLog(@"nose q pedo.");

            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Transferencia fallida" message:[dataDictionary[@"DATOS"] objectForKey:@"MENSAJE"] delegate:self  cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            alert.tag =	34523;
             [alert show];
        }else {
            NSLog(@"menos se q pedo.");
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Transferencia fallida" message:@"Algo salio mal pero tu saldo esta intacto, intenta con mas suerte! =)" delegate:self  cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            alert.tag =	3242;
            [alert show];

        }

        
    }

}

@end
