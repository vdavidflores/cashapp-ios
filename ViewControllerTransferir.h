//
//  ViewControllerTransferir.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 10/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerTransferir : UIViewController
- (IBAction)onEnviar:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *campoPara;
@property (weak, nonatomic) IBOutlet UITextField *campoCantidad;


@end
