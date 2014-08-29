//
//  ViewControllerLLaveKu.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 28/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerLLaveKu.h"
#import "KuBDD.h"
@interface ViewControllerLLaveKu ()

@end

@implementation ViewControllerLLaveKu

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self kuTopbar];
        [self.view  setBackgroundColor:[[ UIColor alloc] initWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
        [self.navigationItem setTitle:@"Código de acceso"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)kuTopbar{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"opciones"] style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    
    
    [self.navigationItem setLeftBarButtonItem:button];
    [self.navigationItem setTitle:@"Código de Acceso"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onGenerar:(id)sender {
    [self pedirPinYenviar];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  
    if (alertView.tag==450 && buttonIndex==1) {
        KuBDD * bd = [[KuBDD alloc]init];
        [bd abrirKuBDD];
        
        self.request = [[KUSoket alloc] init];
        [self.request setDelegate:self];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];

        [data setObject:[bd obtenerDatoConKey:@"id" deLaTabla:@"USR"] forKey:@"usr"];
        [data setObject:[bd obtenerDatoConKey:@"kuPrivKey" deLaTabla:@"USR"] forKey:@"imei"];
        [data setObject:[[self.pinalert textFieldAtIndex:0] text] forKey:@"pin"];
      [self.request startRequestForAction:@"13" andData:data];
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
        [self.codigo setText:[result[@"DATOS"] objectForKey:@"llave_ku"]];
    }else if([[result objectForKey:@"RESULTADO"] isEqualToString:@"FALLA"]) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Operación rechazada" message:[result[@"DATOS"] objectForKey:@"MENSAJE"]delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [al show];
        
    }

}

@end
