//
//  ViewControllerRegDatos.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 09/11/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"ASIFormDataRequest.h"

@interface ViewControllerRegDatos : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *anoTextField;
@property (weak, nonatomic) IBOutlet UITextField *mesTextField;
@property (weak, nonatomic) IBOutlet UITextField *diaTextField;
@property (weak, nonatomic) IBOutlet UITextField *correoTextField;
@property (weak, nonatomic) IBOutlet UITextField *apellidoTextField;
@property (weak, nonatomic) IBOutlet UITextField *nombreTextField;
@property (strong,nonatomic) UIAlertView *validandoDialog;
- (IBAction)onCancelar:(id)sender;
- (IBAction)onAceptar:(id)sender;
@property (nonatomic, retain) ASIFormDataRequest *request;

@end
