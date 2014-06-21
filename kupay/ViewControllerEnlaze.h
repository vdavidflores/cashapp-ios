//
//  ViewControllerEnlaze.h
//  kupay
//
//  Created by Codigo KU on 19/05/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KUSoket.h"
@interface ViewControllerEnlaze : UIViewController<KUSoketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codigoATF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *pin1TF;
@property (weak, nonatomic) IBOutlet UITextField *pin2TF;
@property (strong,nonatomic) UIAlertView *validandoDialog;
@property (strong,atomic) KUSoket *emalRequest;
- (IBAction)onCancelar:(id)sender;

- (IBAction)onAceptar:(id)sender;
- (IBAction)onEnviarCodigo:(id)sender;


@end
