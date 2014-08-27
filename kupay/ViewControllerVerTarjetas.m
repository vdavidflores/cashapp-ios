//
//  ViewControllerVerTarjetas.m
//  kupay
//
//  Created by Codigo KU on 26/08/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import "ViewControllerVerTarjetas.h"
#import "ViewControllerTarjetaNueva.h"

@interface ViewControllerVerTarjetas ()

@end

@implementation ViewControllerVerTarjetas

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization  //[btnNueva setAction:]

    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    
    KuBDD *bdd = [[KuBDD alloc] init];
    [bdd abrirKuBDD];
    NSMutableArray *listaTarjetas = [bdd obtenerColumna:@"nombre" deLaTabla:@"TARJETA"];
    self.tarjetas = listaTarjetas;
    NSLog(@"______---------_____||||____%lu",(unsigned long)[self.tarjetas count]);
    [bdd cerrarBdd];
    [self.tableView reloadData];
    

}
-(void)recargar{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem *btnNueva = [[UIBarButtonItem alloc] initWithTitle:@"Añadir Nueva" style:UIBarButtonItemStylePlain target:self action:@selector(NuevaTarjeta)];
    btnNueva.tintColor = [UIColor whiteColor];
    [[self navigationItem] setRightBarButtonItem:btnNueva];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)NuevaTarjeta{
    ViewControllerTarjetaNueva *tjtnva = [[ViewControllerTarjetaNueva alloc] init];
    [[self navigationController] pushViewController:tjtnva animated:YES];
    
}


//DElegado de listView para uitableview de loista de tarjetas


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"boorando!");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableArray *work_array = [NSMutableArray arrayWithArray:self.tarjetas];
        [work_array removeObjectAtIndex:indexPath.row];
      //  self.tarjetas = [NSArray arrayWithArray:work_array];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [tableView setEditing:YES animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [self makeLensListCell: CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor clearColor];

    }
          cell.textLabel.text = [self.tarjetas objectAtIndex:indexPath.row];
        NSLog(@" PATH 2");
        return cell;
    
}

- (UITableViewCell *)makeLensListCell: (NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        NSInteger numberOfRows = [self.tarjetas count];
        return numberOfRows;

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

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Selecciona una tarjeta";
}

@end
