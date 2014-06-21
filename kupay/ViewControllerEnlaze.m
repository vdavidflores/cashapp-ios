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
@interface ViewControllerEnlaze ()

@end

@implementation ViewControllerEnlaze
@synthesize emailTF,codigoATF,pin1TF,pin2TF,emalRequest;

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
-(void)processCompletedWhitResult:(NSDictionary*)result inAcction:(NSNumber *)acction{
   
    if ([acction integerValue] == 15) {
        NSLog(@"accion 15");
        if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"EXITO"]) {
            NSLog(@"LOGOGOGOOGOGOGOGOOG");
            [[[iToast makeText:@"CóDIGO ENVIADO"] setDuration:3000] show];
        }
    }
    
  }

@end
