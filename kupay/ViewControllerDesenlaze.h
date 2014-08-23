//
//  ViewControllerDesenlaze.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 28/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"
@interface ViewControllerDesenlaze : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textview;
- (IBAction)onDesenlazar:(id)sender;

@end
