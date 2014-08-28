//
//  ViewControllerRetiro.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 28/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"
@interface ViewControllerRetiro : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *destino;
@property (weak, nonatomic) IBOutlet UITextField *monto;
@property (weak, nonatomic) IBOutlet UITextField *clabe1;
@property (weak, nonatomic) IBOutlet UITextField *clabe2;
@property (weak, nonatomic) IBOutlet UIButton *BTNacepar;
@property (weak, nonatomic) IBOutlet UILabel *clabeLabel;
- (IBAction)onAceptar:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanciaBTNAceparDeMonto;

@end
