//
//  AppDelegate.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 10/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
@class RevealController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RevealController *viewController;
@property (strong,nonatomic) FMDatabase * db;

@end
