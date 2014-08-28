//
//  ViewControllerVerTarjetas.h
//  kupay
//
//  Created by Codigo KU on 26/08/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KUSoket.h"

@interface ViewControllerVerTarjetas : UIViewController  <UITableViewDataSource, UITableViewDelegate, KUSoketDelegate>
@property (strong,nonatomic) NSMutableArray *tarjetas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
-(void)recargar;
@property (strong,nonatomic) NSString *monto;
@property (strong, nonatomic) UIAlertView * pinalert ;
@property (nonatomic, retain) KUSoket *request;
@property (strong,nonatomic) NSString *pin;
@property (strong, nonatomic) UIAlertView *transfiriendoDialog;
@property  int  tarjetaAusar;
@property BOOL Deposito;

@end
