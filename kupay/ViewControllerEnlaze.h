//
//  ViewControllerEnlaze.h
//  kupay
//
//  Created by Codigo KU on 19/05/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KUSoket.h"
#import "TPKeyboardAvoiding/TPKeyboardAvoidingScrollView.h"
@interface ViewControllerEnlaze : UIViewController<KUSoketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codigoATF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *pin1TF;
@property (weak, nonatomic) IBOutlet UITextField *pin2TF;
@property (strong,nonatomic) UIAlertView *validandoDialog;
@property (strong, nonatomic) NSString *imei;
@property (strong, nonatomic) NSString *usr;
@property (strong,atomic) KUSoket *emalRequest;
@property (strong,atomic) KUSoket *enlazarRequest;

- (IBAction)onCancelar:(id)sender;
- (IBAction)onAceptar:(id)sender;
- (IBAction)onEnviarCodigo:(id)sender;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scv;


@end
