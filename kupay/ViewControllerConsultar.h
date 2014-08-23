//
//  ViewControllerConsultar.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 12/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"ASIFormDataRequest.h"
#import "KUSoket.h"
@interface ViewControllerConsultar : UIViewController <UITableViewDataSource, UITableViewDelegate, KUSoketDelegate>{
   }
@property NSArray *fruits;
@property (retain,nonatomic) NSArray *content;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, retain) ASIFormDataRequest *request;
@property (atomic,retain) KUSoket *dataReq;
@end
