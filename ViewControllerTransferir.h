//
//  ViewControllerTransferir.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 10/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"ASIFormDataRequest.h"
@interface ViewControllerTransferir : UIViewController
- (IBAction)onEnviar:(id)sender;
- (IBAction)onParaInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *campoPara;
@property (weak, nonatomic) IBOutlet UITextField *campoCantidad;
@property (strong, nonatomic) UIAlertView *transfiriendoDialog;
@property (nonatomic, retain) ASIFormDataRequest *request;
@property (strong,nonatomic) NSString *pin;
@property (strong, nonatomic) UIAlertView * pinalert ;

@end
