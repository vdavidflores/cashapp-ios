//
//  ViewControllerDeposito.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 31/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"
#import "KUSoket.h"

@interface ViewControllerDeposito : UIViewController <KUSoketDelegate>
- (IBAction)Aceptoar:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong,atomic) KUSoket *spei;
@property (weak, nonatomic) IBOutlet UILabel *TXTCantidad;
@property (weak, nonatomic) IBOutlet UITextField *INPUTcantidad;
@property (weak, nonatomic) IBOutlet UIButton *BTNaceptar;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *progress;
@property (weak, nonatomic) IBOutlet UITextView *TXTspei;

@end
