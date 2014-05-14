//
//  ViewControllerDeposito.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 31/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"

@interface ViewControllerDeposito : UIViewController <UITableViewDataSource, UITableViewDelegate>
- (IBAction)Aceptoar:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong,nonatomic) NSArray *tarjetas;

@end
