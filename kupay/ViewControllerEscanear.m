//
//  ViewControllerEscanear.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 10/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerEscanear.h"
#import "KuBDD.h"
#import "ViewControllerMain.h"

@interface ViewControllerEscanear ()
-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest;
@end

@implementation ViewControllerEscanear
@synthesize reader,ecaneando, request, qr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"dsfds");


    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  //  [self scan];
    self.view.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];

    NSLog(@"cargando vista por primera vez");
    if ([self init_camera]) {
        self.ecaneando = YES;
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"abriendo escaneo");
    if (self.ecaneando){
        NSLog(@"el escaner esta cargado");
    }else{
        NSLog(@"el escaner NO esta cargado");
        [self.reader start];
        
    }
    
}

- (void) viewDidDisappear:(BOOL)animated{
    NSLog(@"escaneo cerrado");
    self.ecaneando = NO;
    [self.reader stop];
}
- (void) readerView:(ZBarReaderView *)readerView didReadSymbols: (ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol * s = nil;
    for (s in symbols)
    {
       //aqui va la deteccion del QR
       
        [self.reader stop];

        if([s type] == 64){
            
            //Empezar el request
            [request cancel];
            [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://kupay.tk/kuCloudAppDev/index.php"]]];
            
            NSMutableDictionary *nameElements = [NSMutableDictionary dictionary];
            
            [nameElements setObject:[s data] forKey:@"qr"];
            qr = [s data];
            // [nameElements setObject:@"1234" forKey:@"password"];
            NSError *error = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:nameElements
                                                               options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                 error:&error];
            NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"DATA: %@", jsonString);
            
            [request setPostValue:@"4" forKey:@"ACCION"];
            [request setPostValue:jsonString forKey:@"DATA"];
            [request setTimeOutSeconds:20];
            
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
            [request setShouldContinueWhenAppEntersBackground:YES];
#endif
            
            [request setDelegate:self];
            
            [request setDidFinishSelector:@selector(enrespuesta:)];
            request.tag = 342;
            [request startAsynchronous];
            
            
        }
        
        
        
    }
}



- (BOOL) init_camera {
    self.reader = [ZBarReaderView new];
    ZBarImageScanner * scanner = [ZBarImageScanner new];
    [scanner setSymbology: 0
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    [scanner setSymbology: ZBAR_QRCODE
                   config: ZBAR_CFG_ENABLE
                       to: 1];
  bool n = [self.reader initWithImageScanner:scanner];
    [self.reader setTrackingColor:[[UIColor alloc] initWithRed:197.0/255.0
                                                         green:30.0/255.0
                                                          blue:79.0/255.0
                                                         alpha:1.0]];
    self.reader.readerDelegate = self;
    
    const float h = [UIScreen mainScreen].bounds.size.height;
    const float w = [UIScreen mainScreen].bounds.size.width;

    CGRect reader_rect = CGRectMake(0.0, 0.0,
                                    w , h );
    self.reader.frame = reader_rect;
    self.reader.backgroundColor = [UIColor colorWithRed:179.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
    [self.reader start];
    
    [self.view addSubview: self.reader];
    return YES;
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)tabImageName
{
	return @"comp.png";
}

-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest{
    if (elrequest.tag == 342) {
        NSString *result = elrequest.responseString;
        NSError *error = nil;NSLog(@"respuesta es: %@",result);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];

        
        if ([dataDictionary[@"RESULTADO"]   isEqualToString:@"OPERACION_DISPONIBLE"] ){
            
            NSString *tipo = nil;
            if ([[dataDictionary[@"DATOS"] objectForKey:@"TIPO"] isEqualToString:@"ABONO_A_QUIEN_DETECTA"]){
                tipo= @"Abono";
            }else if ([[dataDictionary[@"DATOS"] objectForKey:@"TIPO"] isEqualToString:@"CARGO_A_QUIEN_DETECTA"]){
                tipo= @"Cargo";
            }
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:tipo message:[NSString stringWithFormat:@"Concepto: %@ \nMonto: %@",[dataDictionary[@"DATOS"] objectForKey:@"CONCEPTO"], [dataDictionary[@"DATOS"] objectForKey:@"MONTO"]] delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
            
            [(UILabel*) alert.subviews[1] setTextAlignment:NSTextAlignmentLeft];
            
          /*  for (UIView *view in alert.subviews) {
                if([[view class] isSubclassOfClass:[UILabel class]]) {
                    ((UILabel*)view).textAlignment = NSTextAlignmentLeft;
                                   }
            }*/
            alert.tag =	233;
            
            [alert show];
        }else if ([dataDictionary[@"RESULTADO"]   isEqualToString:@"OPERACION_NO_DISPONIBLE"] ){
        
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Operación no diponible" message:@"El codigo detectado no esta disponible, probablemente ya fue usado o se encuentra desactivado" delegate:self  cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            alert.tag =	2334;
            
            [alert show];
        
        }
        
             
    } else  if (elrequest.tag == 390) {
        [self.transfiriendoDialog dismissWithClickedButtonIndex:-1 animated:YES];
        NSString *result = elrequest.responseString;
        NSError *error = nil;NSLog(@"respuesta es: %@",result);
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
        
        NSString *resultadoTrans = nil;
        if ([dataDictionary[@"RESULTADO"]   isEqualToString:@"TRANSACCION_EXITOSA"] ){
            
            resultadoTrans = @"Transaccón exitosa";
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:resultadoTrans message:@"mensaje publicitario" delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:nil, nil];
            
            alert.tag =	234534;
            
            [alert show];

            ViewControllerMain *myTBC = (ViewControllerMain *)self.tabBarController;
            [myTBC actualizarSaldo];
            
        }else if ([dataDictionary[@"RESULTADO"]   isEqualToString:@"TRANSACCION_FALLIDA"] ){
            if([[dataDictionary[@"DATOS"] objectForKey:@"CAUSA_FALLA"] isEqualToString:@"FONDOS_INUFICIENTES"]){
                NSLog(@"no marmaja");
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Transferencia fallida" message:@"No cuentas con saldo suficiente para relizar esta operación" delegate:self  cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
                alert.tag =	234534;
                [alert show];
            }else if([[dataDictionary[@"DATOS"] objectForKey:@"CAUSA_FALLA"] isEqualToString:@"USUARIO_INVALIDO"]||[[dataDictionary[@"DATOS"] objectForKey:@"CAUSA"] isEqualToString:@"USUARIO_INVALIDO"]){
                NSLog(@"no marmaja");
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Transferencia fallida" message:@"Usuario invalido, verifica tu pin" delegate:self  cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
                alert.tag =	234534;
                [alert show];
            }else {
            
            resultadoTrans = @"Transaccón fallida";
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:resultadoTrans message:@"mensaje publicitario" delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:nil, nil];
            
            alert.tag =	234534;
            
            [alert show];
            }

            
        }
        
        
        
    
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Operación invalida" message:@"El código parece no ser un código kuPay valido" delegate:self  cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        alert.tag =	2334;
        
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 233 && buttonIndex == 1){
            // PIN
            self.pinalert = [[UIAlertView alloc] initWithTitle:@"Ingresa tu PIN" message:@"Ingresa tu pin de seguridad (4 digitos)" delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
            self.pinalert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            self.pinalert.tag =	450;
            [[self.pinalert textFieldAtIndex: 0] setTextAlignment:NSTextAlignmentCenter];
            [[self.pinalert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
            [self.pinalert show];

    }
    
     if(alertView.tag == 233 && buttonIndex == 0){
         [reader start];
     }
    if(alertView.tag == 450 && buttonIndex == 0){
        [reader start];
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
    
    if(alertView.tag == 450 && buttonIndex == 1){
         [reader start];
    }
    
    if (alertView.tag == 2334) {
        [reader start];
    }
    if (alertView.tag == 234534) {
         [reader start];
    }
    
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
    
    [nameElements setObject:usr forKey:@"usr"];
    [nameElements setObject:qr forKey:@"qr"];
    [nameElements setObject:self.pin forKey:@"pin"];
    [nameElements setObject:imei forKey:@"imei"];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:nameElements
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"DATA: %@", jsonString);
    
    [request setPostValue:@"6" forKey:@"ACCION"];
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

@end
