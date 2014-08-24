//  AppDelegate.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 10/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerMain.h"
#import "RevealController.h"
#import "ViewControllerMain.h"
#import "RearViewController.h"
#import "CRNavigationBar.h"
#import "CRNavigationController.h"
#import "ViewControllerPregunta.h"
@implementation AppDelegate


@synthesize viewController, db;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"database.kupay"];	
    
    self.db = [FMDatabase databaseWithPath:path];
    
    [self.db open];
    
    bool cratus = [db executeUpdate:@"create table USR(id text, kuPrivKey text, kuPubKey text, ultimoToken text)"];
    
    //[db executeUpdate:@"create table TARJETA(id text, kuPrivKey text, kuPubKey text, ultimoToken text)"];
    
    NSLog(@"Base creada: %@", (cratus) ? @"YES" : @"NO");
    if (cratus){
        [db executeUpdate:@"INSERT INTO USR (id,kuPrivKey,kuPubKey,ultimoToken) values (?,?,?,?)",@"ku",@"ku",@"ku",@"ku"];
        NSLog(@"fila inseratada");
    }
    FMResultSet *res = [db executeQuery:@"select id from USR"];
    NSString *idnt = nil;
    int i = 0;
    while ([res next]) {
        idnt = [res stringForColumn:@"id"];
        i++;
    }
    NSLog(@"fillas en bdd: %d " ,i );
    if (![idnt isEqualToString:@"ku"]){
        NSLog(@"%@", @"El usuario ya estaba logeado");
        ViewControllerMain *frontViewController = [[ViewControllerMain alloc] init];
        
        CRNavigationController * navController = [[CRNavigationController alloc] initWithRootViewController:
                                       frontViewController ];
        
        [navController.navigationBar setBarTintColor:[UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
        
        navController.navigationBar.tintColor = [UIColor whiteColor];
        [navController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        navController.navigationBar.translucent = NO;

        
        RearViewController *rearViewController = [[RearViewController alloc] init];
        
        
        RevealController *revealController = [[RevealController alloc] initWithFrontViewController:navController rearViewController:rearViewController];
        
        
        
        
        
        self.viewController = revealController;
        self.window.rootViewController = self.viewController;


    }else{
        NSLog(@" %@ %@", @"no no estaba logeado ident es ", idnt);
 
        ViewControllerPregunta *vcp = [[ViewControllerPregunta alloc] init];
        self.window.rootViewController = vcp;
    }
    
    // Override point for customization after application launch.
    
    
   // [[UITabBar appearance] setBackgroundColor:[[UIColor alloc] initWithRed:197 green:30 blue:79 alpha:100]];
       //                                          ViewControllerMain *vc = [[ViewControllerMain alloc] init];
    
 
  
    

    [self.window makeKeyAndVisible];
   
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
