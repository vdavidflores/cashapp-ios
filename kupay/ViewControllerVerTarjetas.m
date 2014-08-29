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
    
    self.tableView.backgroundColor = [UIColor grayColor];
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 789 && buttonIndex == 1) {
        [self pedirPinYenviar];
    }
    if (alertView.tag==450 && buttonIndex==1) {
        KuBDD * bd = [[KuBDD alloc]init];
        [bd abrirKuBDD];
        
        self.request = [[KUSoket alloc] init];
        [self.request setDelegate:self];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setObject:[bd obtenerDatoConKey:@"numero_tarjeta_cryp" deLaTabla:@"TARJETA" enLaPocicion:self.tarjetaAusar] forKey:@"numero_tarjeta_cryp"];
        [data setObject:[bd obtenerDatoConKey:@"nombre_titular_cryp" deLaTabla:@"TARJETA" enLaPocicion:self.tarjetaAusar] forKey:@"nombre_titular_cryp"];
        [data setObject:[bd obtenerDatoConKey:@"exp_mes_cryp" deLaTabla:@"TARJETA" enLaPocicion:self.tarjetaAusar] forKey:@"exp_mes_cryp"];
        [data setObject:[bd obtenerDatoConKey:@"exp_anio_cryp" deLaTabla:@"TARJETA" enLaPocicion:self.tarjetaAusar] forKey:@"exp_anio_cryp"];
        [data setObject:[bd obtenerDatoConKey:@"cvv_cryp" deLaTabla:@"TARJETA" enLaPocicion:self.tarjetaAusar] forKey:@"cvv_cryp"];
        [data setObject:[self monto] forKey:@"monto"];
        [data setObject:[bd obtenerDatoConKey:@"id" deLaTabla:@"USR"] forKey:@"usr"];
        [data setObject:[bd obtenerDatoConKey:@"kuPrivKey" deLaTabla:@"USR"] forKey:@"imei"];
        [data setObject:[[self.pinalert textFieldAtIndex:0] text] forKey:@"pin"];
        ([self Deposito])?[self.request startRequestForAction:@"16" andData:data]:[self.request startRequestForAction:@"18" andData:data];
        self.transfiriendoDialog = [[UIAlertView alloc] initWithTitle:@"Transferencia en proceso" message:@"Espera un momento \n\n\n\n"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:nil, nil];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.center = CGPointMake(139.5, 95.5); // .5 so it doesn't blur
        self.transfiriendoDialog.tag = 450;
        [self.transfiriendoDialog addSubview:spinner];
        [spinner startAnimating];
        [self.transfiriendoDialog show];
        
    }
    
}
-(void)pedirPinYenviar{
    self.pinalert = [[UIAlertView alloc] initWithTitle:@"Ingresa tu PIN" message:@"Ingresa tu pin de seguridad (4 digitos)" delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
    self.pinalert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    self.pinalert.tag =	450;
    [[self.pinalert textFieldAtIndex: 0] setTextAlignment:NSTextAlignmentCenter];
    [[self.pinalert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [self.pinalert show];
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
    
    KuBDD *bdd = [[KuBDD alloc] init];
    [bdd abrirKuBDD];
    
   // BOOL Deposito = YES;
   
        self.tarjetaAusar = indexPath.row+1;
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Confirma tu tarjeta" message:[NSString stringWithFormat:@"¿Deseas %@ $%@ usando la tarjeta %@?",([self Deposito]) ? @"depositar" : @"retirar",[self monto],[bdd obtenerDatoConKey:@"nombre" deLaTabla:@"TARJETA" enLaPocicion:[self tarjetaAusar]]] delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
        al.tag = 789;
        [al show];
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
      

    }
      cell.backgroundColor = [UIColor clearColor];
     cell.textLabel.textColor = [UIColor whiteColor];
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

-(void)processCompletedWhitResult:(NSDictionary *)result inAcction:(NSNumber *)acction{
    
    [self.transfiriendoDialog dismissWithClickedButtonIndex:-1 animated:YES];
    if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"EXITO"]) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ exitoso", ([self Deposito])? @"Depósito": @"Retiro"] message:[NSString stringWithFormat:@"El %@ de saldo con tu tarjeta ha sido realizado con éxito.\nPuedes confirmarlo en tu registro de movimientos.\n%@",([self Deposito])?@"depósito":@"retiro",([self Deposito])?@"":@"Se vera reflejado en tu centa bancaria en las proximas 48 horas."] delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [al show];
        
    }else if([[result objectForKey:@"RESULTADO"] isEqualToString:@"FALLA"]) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Operación declinada" message:[result[@"DATOS"] objectForKey:@"MENSAJE"]delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [al show];

    }
    
}

@end
