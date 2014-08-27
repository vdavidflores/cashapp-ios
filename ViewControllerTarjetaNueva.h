//
//  ViewControllerTarjetaNueva.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 04/11/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KUSoket.h"
#import "KuBDD.h"
@interface ViewControllerTarjetaNueva : UIViewController <KUSoketDelegate>
@property (weak, nonatomic) IBOutlet UIButton *BTNinfoCVC;
@property (strong, nonatomic) UIAlertView * pinalert ;
@property (nonatomic, retain) KUSoket *request;
@property (strong,nonatomic) NSString *pin;
@property (strong, nonatomic) UIAlertView *transfiriendoDialog;
- (IBAction)onAceptar:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *INPUTtitular;
@property (weak, nonatomic) IBOutlet UITextField *INPUTtarjeta;
@property (weak, nonatomic) IBOutlet UITextField *INPUTmes;
@property (weak, nonatomic) IBOutlet UITextField *INPUTanio;
@property (weak, nonatomic) IBOutlet UITextField *INPUTcvc;


@end
