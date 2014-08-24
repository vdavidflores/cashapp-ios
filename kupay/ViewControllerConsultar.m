//
//  ViewControllerConsultar.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 12/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerConsultar.h"
#import "iToast.h"
#import "KuBDD.h"
#import "kuTableViewCell.h"

@interface ViewControllerConsultar ()
-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest;
@end

@implementation ViewControllerConsultar

@synthesize content,request,dataReq;


- (NSString *)tabTitle
{
	return @"Consultas";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NSDictionary *item = (NSDictionary *)[self.content objectAtIndex:indexPath.row];
    NSLog(@"1");
    
    UIAlertView *alert=[[UIAlertView alloc]initWithFrame:CGRectMake(50.0, 20.0, 100.0f, 400.0f)];
    alert.title=@"Ticket de operación";
    
    alert.message=[NSString stringWithFormat:@"Concepto: %@ \nTicket: %@",[item objectForKey:@"CONCEPTO"], [[item objectForKey:@"IDKEY"] substringToIndex:5]];

     NSLog(@"2");
    alert.delegate=self.content;
    [alert addButtonWithTitle:@"OK"];
     NSLog(@"3");
    
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1){
        if(buttonIndex == 1){
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#define SECONDLABEL_TAG 2

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"kuTableViewCell";
    UITableViewCell *cell;
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
      cell = (kuTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    } else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
   
    
    if (cell == nil) {
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
             cell = [[kuTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }else{
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    }
    
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];

    cell.textLabel.font=[UIFont boldSystemFontOfSize:16.0];
    NSDictionary *item = (NSDictionary *)[self.content objectAtIndex:indexPath.row];
    

    
    switch ([[item objectForKey:@"TIPO"] integerValue]) {
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"Abono de %@$%@",[item objectForKey:@"POLO"],[item objectForKey:@"MONTO"]];
            cell.detailTextLabel.text = [item objectForKey:@"FECHA"];
           cell.imageView.image = [UIImage imageNamed:@"mdm"];
            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"Compra de %@$%@",[item objectForKey:@"POLO"],[item objectForKey:@"MONTO"]];
            cell.detailTextLabel.text = [item objectForKey:@"FECHA"];
            cell.imageView.image = [UIImage imageNamed:@"compm"];
            break;
            
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"Transferencia de %@$%@",[item objectForKey:@"POLO"],[item objectForKey:@"MONTO"]];
            cell.detailTextLabel.text = [item objectForKey:@"FECHA"];
            cell.imageView.image = [UIImage imageNamed:@"tranm"];
            break;
        case 5:
            cell.textLabel.text = [NSString stringWithFormat:@"Compra de %@$%@",[item objectForKey:@"POLO"],[item objectForKey:@"MONTO"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@" %@ \n %@ ",[item objectForKey:@"FECHA"], @"---"];
            cell.imageView.image = [UIImage imageNamed:@"compm"];
            break;

            
        default:
        
            cell.textLabel.text = [NSString stringWithFormat:@"Movimiento desconosidp de %@$%@",[item objectForKey:@"POLO"],[item objectForKey:@"MONTO"]];
            cell.detailTextLabel.text = [item objectForKey:@"FECHA"];
            cell.imageView.image = [UIImage imageNamed:@"mdm"];
            
            break;
    }
    
    
  //  cell.imageView.frame = CGRectMake( 0, 0, 20, 20 );
    
return cell;
}


- (UITableViewCell *)makeLensListCell: (NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = [self.content count];
    return numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
     NSLog(@"CONSULTA");
    
    
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
  
    
    
    [self pullData];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableview addSubview:refreshControl];
    
    
    
   
}

-(void)pullData{
    KuBDD *bdd = [[KuBDD alloc] init];
    [bdd abrirBDDenPath:@"database.kupay"];
    NSString *imei = [bdd obtenerDatoConKey:@"kuPrivKey" deLaTabla:@"USR"];
    NSString *usr = [bdd obtenerDatoConKey:@"id" deLaTabla:@"USR"];
    
    NSLog(@"DATOS EN BDD %@, %@", imei, usr);
   // [request cancel];
  //  [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://kupay.tk/kuCloudAppDev/index.php"]]];
    
    NSMutableDictionary *nameElements = [NSMutableDictionary dictionary];
    
    [nameElements setObject:usr forKey:@"usr"];
    [nameElements setObject:imei forKey:@"imei"];
    [nameElements setObject:@"1" forKey:@"dias"];
    dataReq = [[KUSoket alloc] init];
    dataReq.delegate = self;
    [dataReq startRequestForAction:@"7" andData:nameElements];
    
 /*   NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:nameElements
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"DATA: %@", jsonString);
    
    [request setPostValue:@"7" forKey:@"ACCION"];
    [request setPostValue:jsonString forKey:@"DATA"];
    [request setTimeOutSeconds:20];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    [request setShouldContinueWhenAppEntersBackground:YES];
#endif
    
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(enrespuesta:)];
    [request setTag:390];
    [request startAsynchronous];*/
}

-(void)refresh:(UIRefreshControl *)refreshControl {
    [self pullData];
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest{
    NSError *error =nil;
    NSString * response = elrequest.responseString;
  // NSLog(response);
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if ([[dataDictionary objectForKey:@"RESULTADO"] isEqualToString:@"SOLICITUD_EXITOSA"]){
      
    self.content =   [dataDictionary[@"DATOS"] objectForKey:@"OPERACIONES"];
        [self.tableview reloadData];
    }
    
}

-(void)processCompletedWhitResult:(NSDictionary *)result inAcction:(NSNumber *)acction{
    if ([acction integerValue] == 7) {
        if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"SOLICITUD_EXITOSA"]){
            self.content =   [result[@"DATOS"] objectForKey:@"OPERACIONES"];
            [self.tableview reloadData];
        }
    }
}


@end
