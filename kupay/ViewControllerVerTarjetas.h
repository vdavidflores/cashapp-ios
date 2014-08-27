//
//  ViewControllerVerTarjetas.h
//  kupay
//
//  Created by Codigo KU on 26/08/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerVerTarjetas : UIViewController  <UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) NSMutableArray *tarjetas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
-(void)recargar;
@end
