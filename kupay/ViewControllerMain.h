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

#import "KUSoket.h"

@interface ViewControllerMain : UITabBarController<KUSoketDelegate> {
    IBOutlet UITabBarController *tabbar;
}
@property (strong, nonatomic) UILabel *saldo;
@property (strong, nonatomic)  UIButton *referscar;
@property (atomic,retain) KUSoket *saldoRequest;
-(void)cambiarSaldo:(NSString *)saldoN;
-(void)actualizarSaldo;
@end
