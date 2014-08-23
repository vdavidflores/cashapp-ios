//
//  ViewControllerCobrar.h
//  kupay
//
//  Created by Codigo KU on 01/07/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "KUSoket.h"
@interface ViewControllerCobrar : UIViewController <KUSoketDelegate>
- (IBAction)onGenerar:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *monto;
@property (weak, nonatomic) IBOutlet UITextField *concepto;
@property (strong, nonatomic) UIAlertView * pinalert ;
@property (strong,nonatomic) NSString *pin;
@property (atomic,retain) KUSoket *generarReq;
@property (strong, nonatomic) UIAlertView *generandoDialog;

@end
