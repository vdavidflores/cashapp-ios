//
//  ViewControllerConsultar.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 12/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerConsultar.h"
#import "iToast.h"


@interface ViewControllerConsultar ()

@end

@implementation ViewControllerConsultar

@synthesize content;


- (NSString *)tabTitle
{
	return @"Consultas";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NSDictionary *item = (NSDictionary *)[self.content objectAtIndex:indexPath.row];

    
    UIAlertView *alert=[[UIAlertView alloc]initWithFrame:CGRectMake(50.0, 20.0, 100.0f, 400.0f)];
    alert.title=@"Tiket de operación";
    
    alert.message=[NSString stringWithFormat:@" %@ \n ", [[item objectForKey:@"operacionId"] substringToIndex:5]];
    
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
    [concepto setText:[NSString stringWithFormat:@"concepto: %@", [item objectForKey:@"concepto"]]];
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

  
  
    
    
    NSDictionary *item = (NSDictionary *)[self.content objectAtIndex:indexPath.row];
    

    
    switch ([[item objectForKey:@"tipo"] integerValue]) {
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"Abono de %@$%@",[item objectForKey:@"polo"],[item objectForKey:@"monto"]];
            cell.detailTextLabel.text = [item objectForKey:@"fecha"];
            cell.imageView.image = [UIImage imageNamed:@"mdm"];
            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"Compra de %@$%@",[item objectForKey:@"polo"],[item objectForKey:@"monto"]];
            cell.detailTextLabel.text = [item objectForKey:@"fecha"];
            cell.imageView.image = [UIImage imageNamed:@"compm"];
            break;
            
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"Transferencia de %@$%@",[item objectForKey:@"polo"],[item objectForKey:@"monto"]];
            cell.detailTextLabel.text = [item objectForKey:@"fecha"];
            cell.imageView.image = [UIImage imageNamed:@"tranm"];
            break;
        case 5:
            cell.textLabel.text = [NSString stringWithFormat:@"Compra de %@$%@",[item objectForKey:@"polo"],[item objectForKey:@"monto"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@" %@ \n %@ ",[item objectForKey:@"fecha"], @"dsfas"];
            cell.imageView.image = [UIImage imageNamed:@"compm"];
            break;

            
        default:
        
            cell.textLabel.text = [NSString stringWithFormat:@"Movimiento desconosidp de %@$%@",[item objectForKey:@"polo"],[item objectForKey:@"monto"]];
            cell.detailTextLabel.text = [item objectForKey:@"fecha"];
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
    
    
    NSString *json =  @"{"
    @"  \"data\": ["
    @"{"
    @"    \"tipo\": \"1\" , "
     @"    \"monto\": \"23\" , "
    @"    \"fecha\": \"hoy\" , "
          @"    \"operacionId\": \"23sm4348u5ij34bhij34b5jk4\" , "
    @"    \"concepto\": \"abono en oxxo\" , "
    @"    \"polo\": \"-\"  "
    @"},"
    @"{"
    @"    \"tipo\": \"2\" , "
    @"    \"monto\": \"434\" , "
    @"    \"fecha\": \"hoy\" , "
      @"    \"operacionId\": \"f4ds45534m5ijk34bn5bn34jk\" , "
    @"    \"concepto\": \"transferencia a usuario\" , "
    @"    \"polo\": \"+\"  "
    @"},"
    @"{"
    @"    \"tipo\": \"3\" , "
    @"    \"monto\": \"31\" , "
    @"    \"fecha\": \"hoy\" , "
    @"    \"operacionId\": \"3h5gb45mkn34knjk34n5340\" , "
     @"    \"concepto\": \"transferencia a usuario\" , "
    @"    \"polo\": \"-\"  "
    @"},"
    @"{"
    @"    \"tipo\": \"1\" , "
    @"    \"monto\": \"31\" , "
    @"    \"fecha\": \"hoy\" , "
    @"    \"operacionId\": \"45jn334mnj5hb34jb45jk\" , "
     @"    \"concepto\": \"tarjeta de abono\" , "
    @"    \"polo\": \"+\"  "
    @"}"
     @"]"
    
    @"}";
     NSError *error = nil;
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    self.content = [dataDictionary objectForKey:@"data"];;
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
