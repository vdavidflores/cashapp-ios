//
//  ViewControllerLLaveKu.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 28/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"
#import "KUSoket.h"

@interface ViewControllerLLaveKu : UIViewController <KUSoketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codigo;
- (IBAction)onGenerar:(id)sender;

@property (strong, nonatomic) UIAlertView * pinalert ;
@property (nonatomic, retain) KUSoket *request;
@property (strong,nonatomic) NSString *pin;
@property (strong, nonatomic) UIAlertView *transfiriendoDialog;


@end
