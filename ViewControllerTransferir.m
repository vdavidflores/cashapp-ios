//
//  ViewControllerTransferir.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 10/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerTransferir.h"
#import "iToast.h"
@interface ViewControllerTransferir ()

@end

@implementation ViewControllerTransferir
@synthesize campoPara,campoCantidad;

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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1){
        if(buttonIndex == 1){
           
            
        }
    }


}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
