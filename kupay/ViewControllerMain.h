//
//  ViewController.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 12/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "AKTabBarController.h"
#import "ZUUIRevealController.h"
#import "ASIFormDataRequest.h"

@interface ViewControllerMain : UITabBarController {
    IBOutlet UITabBarController *tabbar;
}
@property (strong, nonatomic) UILabel *saldo;
@property (strong, nonatomic)  UIButton *referscar;
@property (nonatomic, retain) ASIFormDataRequest *request;


@end
