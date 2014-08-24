//
//  ViewControllerDeposito.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 31/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerDeposito.h"
#import "ViewControllerCodigoOXXO.h"
#import "ViewControllerTarjetaNueva.h"
#import "iToast.h"

@interface ViewControllerDeposito ()

@end

@implementation ViewControllerDeposito
@synthesize segmentedControl;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view  setBackgroundColor:[[ UIColor alloc] initWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
    
    [self kuTopbar];
    
    self.tarjetas = [NSArray arrayWithObjects:@"Visa",@"La Master",@"Visa elctron", @"Viajes", nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)kuTopbar{
    
    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"opciones"] style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    
    
    [self.navigationItem setLeftBarButtonItem:button];
    [self.navigationItem setTitle:@"Deposito"];

    [segmentedControl addTarget:self
                         action:@selector(pickOne:)
               forControlEvents:UIControlEventValueChanged];
    
	   
}

- (IBAction)Aceptoar:(id)sender {
    
    if (segmentedControl.selectedSegmentIndex ==1){
    ViewControllerCodigoOXXO *codifgooxo = [[ViewControllerCodigoOXXO alloc]init];
    [[self navigationController] pushViewController:codifgooxo animated:YES];
    }else{
  
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selecciona la tarjeta a usar (desliza para borrar)" message:@"click for submission \n\n\n \n\n\n\n\n\n"delegate:self  cancelButtonTitle:@"Cancelar"
                                              otherButtonTitles:@"Aceptar",nil];
     
       UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(10, 70, 264, 175)];
        table.delegate = self;
        table.dataSource = self;
        
        [alert addSubview:table];
        
        [alert show];

        
        /*  ViewControllerTarjetaNueva *listTarj = [[ViewControllerTarjetaNueva alloc]init];
        [[self navigationController] pushViewController:listTarj animated:YES];
*/
    }
    
}
-(void) pickOne:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
   
    [iToast makeText:[NSString stringWithFormat:@"seleccionado %@",[segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]]]];
}



//DElegado de listView para uitableview de loista de tarjetas


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"boorando!");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        NSMutableArray *work_array = [NSMutableArray arrayWithArray:self.tarjetas];
        [work_array removeObjectAtIndex:indexPath.row];
        self.tarjetas = [NSArray arrayWithArray:work_array];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [tableView setEditing:YES animated:YES];
}
-(void)rmove{
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  //  SimpleEditableListAppDelegate *controller = (SimpleEditableListAppDelegate *)[[UIApplication sharedApplication] self];
  //  if (indexPath.row == [controller countOfList]-1) {
  //      return UITableViewCellEditingStyleInsert;
  //  } else {
        return UITableViewCellEditingStyleDelete;
  //  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self makeLensListCell: CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
       
    }
    
    if (indexPath.section==1) {
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [self.tarjetas objectAtIndex:indexPath.row];  //  cell.editingAccessoryView = self.editButtonItem;
    return cell;
    }else{
        cell.textLabel.text = @"Añadir nueva";
        return cell;

    }
}
- (UITableViewCell *)makeLensListCell: (NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0)
    {
        return 1;
    }
    else{
        NSInteger numberOfRows = [self.tarjetas count];
        return numberOfRows;
    }
    
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return NO;
    }
        return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Borrar";
}

@end
