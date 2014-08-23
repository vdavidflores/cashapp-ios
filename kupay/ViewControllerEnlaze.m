//
//  ViewControllerEnlaze.m
//  kupay
//
//  Created by Codigo KU on 19/05/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import "ViewControllerEnlaze.h"
#import "ViewControllerPregunta.h"
#import "iToast.h"
#import "NSData+MD5.h"
#import "KuBDD.h"


#import "RevealController.h"
#import "ViewControllerMain.h"
#import "RearViewController.h"
#import "ViewControllerPregunta.h"

@interface ViewControllerEnlaze ()

@end



@implementation ViewControllerEnlaze
@synthesize emailTF,codigoATF,pin1TF,pin2TF,emalRequest,scv,enlazarRequest;

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
    [self.view setBackgroundColor:[UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
    // Do any additional setup after loading the view from its nib.
    scv.bounces = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancelar:(id)sender {
    ViewControllerPregunta *nc = [[ViewControllerPregunta alloc] init];
    [self presentViewController:nc animated:YES completion:nil];

}

- (IBAction)onAceptar:(id)sender {
    
    if(![self.emailTF.text isEqualToString:@""] && [self validateEmailWithString:[self.emailTF text]])
    {
        if(![codigoATF.text isEqualToString:@""] && [self validateEmailWithString:[self.emailTF text]])
        {
            
            if(![pin1TF.text isEqualToString:@""] && [self validateEmailWithString:[self.emailTF text]])
            {

                if(![pin2TF.text isEqualToString:@""] && [self validateEmailWithString:[self.emailTF text]])
                {
                    
                    if([pin2TF.text isEqualToString:pin1TF.text] )
                    {
                    
                        enlazarRequest = [[KUSoket alloc] init];
                        enlazarRequest.delegate = self;
                        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
                    
                  NSData *bytes = [[NSFileHandle fileHandleForReadingAtPath: @"/dev/random"] readDataOfLength: 100];
                        self.imei = [bytes MD5];
                        self.usr = emailTF.text;
                    [data setObject:self.usr forKey:@"usr"];
                    [data setObject:self.imei forKey:@"imei"];
                    [data setObject:[pin1TF text] forKey:@"pin"];
                    [data setObject:[codigoATF text] forKey:@"pass"];
                    [data setObject:@"4" forKey:@"rol1"];
                    [data setObject:@"5" forKey:@"rol2"];
                   
                    
                        [enlazarRequest startRequestForAction:@"14" andData:data];
                    
                    
                    }else{
                        self.pin2TF.backgroundColor=[UIColor yellowColor];
                        [self.pin2TF becomeFirstResponder];
                        [[[iToast makeText:@"Codigo no ingresado"] setDuration:2000] show];
                    }
                
                }else{
                    self.pin2TF.backgroundColor=[UIColor yellowColor];
                    [self.pin2TF becomeFirstResponder];
                    [[[iToast makeText:@"Codigo no ingresado"] setDuration:2000] show];
                }

                
            }else{
                self.pin1TF.backgroundColor=[UIColor yellowColor];
                [self.pin1TF becomeFirstResponder];
                [[[iToast makeText:@"Codigo no ingresado"] setDuration:2000] show];
            }
            
        
        }else{
            self.codigoATF.backgroundColor=[UIColor yellowColor];
            [self.codigoATF becomeFirstResponder];
            [[[iToast makeText:@"Codigo no ingresado"] setDuration:2000] show];
        }

        
    }else{
        self.emailTF.backgroundColor=[UIColor yellowColor];
        [self.emailTF becomeFirstResponder];
        [[[iToast makeText:@"Correo invaldo"] setDuration:2000] show];
    }
    
}




- (IBAction)onEnviarCodigo:(id)sender {
    
    if(![self.emailTF.text isEqualToString:@""] && [self validateEmailWithString:[self.emailTF text]])
    {
        
        emalRequest = [[KUSoket alloc]init];
        emalRequest.delegate = self;
        NSMutableDictionary *nameElements = [NSMutableDictionary dictionary];
        [nameElements setObject:[self.emailTF text] forKey:@"usr"];
        [emalRequest startRequestForAction:@"15" andData:nameElements];
        
    }else{
        self.emailTF.backgroundColor=[UIColor yellowColor];
        [self.emailTF becomeFirstResponder];
        [[[iToast makeText:@"Correo invaldo"] setDuration:2000] show];
    }
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void)processCompletedWhitResult:(NSDictionary*)result inAcction:(NSNumber *)acction
{
    NSLog(@"REPUESTASSSS");
    if ([acction integerValue] == 15) {
        NSLog(@"accion 15");
        if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"EXITO"]) {
            [[[iToast makeText:@"Código de acceso enviado"] setDuration:3000] show];
        }
    }else if ([acction intValue] == 14){
        
        if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"EXITO"]) {
            [[[iToast makeText:@"Bienvenido"] setDuration:3000] show];
            KuBDD *bdd = [[KuBDD alloc] init];
            [bdd abrirBDDenPath:@"database.kupay"];
            [bdd actualizarCampo:@"id" conDato:self.usr deLaTabla:@"USR"];
            [bdd actualizarCampo:@"kuPrivKey" conDato:self.imei deLaTabla:@"USR"];
            [bdd cerrarBdd];
            
            ViewControllerMain *frontViewController = [[ViewControllerMain alloc] init];
            RearViewController *rearViewController = [[RearViewController alloc] init];
            
            
            RevealController *revealController = [[RevealController alloc] initWithFrontViewController:frontViewController rearViewController:rearViewController];
            
             [self presentViewController:revealController animated:YES completion:nil];
                       
            
        }else{
            NSLog(@"Falla en 14");
        }

    }
    
}

@end
