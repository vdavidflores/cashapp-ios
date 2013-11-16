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

@interface ViewControllerConsultar ()
-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest;
@end

@implementation ViewControllerConsultar

@synthesize content,request;


- (NSString *)tabTitle
{
	return @"Consultas";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NSDictionary *item = (NSDictionary *)[self.content objectAtIndex:indexPath.row];

    
    UIAlertView *alert=[[UIAlertView alloc]initWithFrame:CGRectMake(50.0, 20.0, 100.0f, 400.0f)];
    alert.title=@"Tiket de operación";
    
    alert.message=[NSString stringWithFormat:@" %@ \n ", [[item objectForKey:@"IDKEY"] substringToIndex:5]];
    
    alert.delegate=self.content;
    [alert addButtonWithTitle:@"OK"];
    
    NSArray *subViewArray = alert.subviews;
    for(int x=0;x<[subViewArray count];x++){
        if([[[subViewArray objectAtIndex:x] class] isSubclassOfClass:[UILabel class]])
        {
            UILabel *label = [subViewArray objectAtIndex:x];
            label.textAlignment = NSTextAlignmentLeft;
            if ([subViewArray objectAtIndex:1]) {
                label.font = [UIFont systemFontOfSize:40.0];
                label.textAlignment = NSTextAlignmentCenter;
            }
        }
        
    }
    UILabel *concepto = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 100.0f, 245.0f, 50.0f)];
    concepto.textAlignment = NSTextAlignmentLeft;
    concepto.numberOfLines = 2;
    concepto.backgroundColor =[UIColor clearColor];
    concepto.textColor = [UIColor whiteColor];
    [concepto setText:[NSString stringWithFormat:@"concepto: %@", [item objectForKey:@"CONCEPTO"]]];
    [alert addSubview:concepto];

    
    
    
    
    [alert show];
    
    
    
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
static NSString *CellIdentifier = @"MyIdentifier";
    

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
         cell = [self makeLensListCell: CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
       
    
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];

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
    [request cancel];
    [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://kupay.tk/kuCloudAppDev/index.php"]]];
    
    NSMutableDictionary *nameElements = [NSMutableDictionary dictionary];
    
    [nameElements setObject:usr forKey:@"usr"];
    [nameElements setObject:[@"1234" init] forKey:@"pin"];
    [nameElements setObject:imei forKey:@"imei"];
    [nameElements setObject:@"1" forKey:@"dias"];
    
    NSError *error = nil;
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
    [request startAsynchronous];
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
    NSLog(response);
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if ([[dataDictionary objectForKey:@"RESULTADO"] isEqualToString:@"SOLICITUD_EXITOSA"]){
      
    self.content =   [dataDictionary[@"DATOS"] objectForKey:@"OPERACIONES"];
        [self.tableview reloadData];
    }
    
  }

@end
