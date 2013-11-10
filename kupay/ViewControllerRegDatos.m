//
//  ViewControllerRegDatos.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 09/11/13.
//  Copyright (c) 2013 ku. All rights reserved.
//
#import "iToast.h"
#import "ViewControllerRegDatos.h"
#import "ViewControllerPregunta.h"
#import "ViewControllerRegSeguridad.h"

@interface ViewControllerRegDatos ()

@end

@implementation ViewControllerRegDatos
@synthesize paises;
@synthesize nombreTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.paises = [NSArray arrayWithObjects:@"Mexico", @"Chile", @"Peru",nil];
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
    
    //Se añade el top bar
    [self addtop];
    UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.paisTextField.delegate = self;
    self.paisTextField.inputView = dummyView;
    self.paisTextField.tag = 666;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addtop{
    CGRect frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 70.0f);
    UIView *topBar = [[UIView alloc] initWithFrame:frame];
    topBar.backgroundColor =  [UIColor whiteColor];
    
    UIImage *img1 = [UIImage imageNamed:@"datosS"];
    UIImageView* img1View = [[UIImageView alloc] initWithImage:img1];
    img1View.frame = CGRectMake(20, 5, 50, 50);
    UILabel *lb1= [[UILabel alloc] initWithFrame:CGRectMake(20, 58, 50, 10)];
    lb1.text=@"datos";
    lb1.font = [UIFont systemFontOfSize:12];
    lb1.textAlignment = NSTextAlignmentCenter;
    lb1.textColor= [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
    [topBar addSubview:lb1];
    [topBar addSubview:img1View];
    
    UIImage *img2 = [UIImage imageNamed:@"seguridad"];
    UIImageView* img2View = [[UIImageView alloc] initWithImage:img2];
    img2View.frame = CGRectMake(140, 5, 50, 50);
    UILabel *lb2= [[UILabel alloc] initWithFrame:CGRectMake(130, 58, 70, 10)];
    lb2.text=@"seguridad";
    lb2.font = [UIFont systemFontOfSize:12];
    lb2.textAlignment = NSTextAlignmentCenter;
    lb2.textColor= [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
    [topBar addSubview:lb2];
    
    
    [topBar addSubview:img2View];
    
    
    UIImage *img3 = [UIImage imageNamed:@"enlace"];
    UIImageView* img3View = [[UIImageView alloc] initWithImage:img3];
    img3View.frame = CGRectMake(250, 5, 50, 50);
    UILabel *lb3= [[UILabel alloc] initWithFrame:CGRectMake(250, 58, 50, 10)];
    lb3.text=@"enlace";
    lb3.font = [UIFont systemFontOfSize:12];
    lb3.textAlignment = NSTextAlignmentCenter;
    lb3.textColor= [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
    [topBar addSubview:lb3];
    
    [topBar addSubview:img3View];
    
    [self.view addSubview:topBar];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textField"); // this will show which textField did end editing ...
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Indica tu pais de residencia" message:@"click for submission \n\n\n\n "delegate:self  cancelButtonTitle:@"Acepar"
                                          otherButtonTitles:nil,nil];
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(10, 40, 264, 120)];
    table.delegate = self;
    table.dataSource = self;
    [alert addSubview:table];
    
    [alert show];
}



//DElegado de listView para

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MyIdentifier2";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self makeLensListCell: CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    cell.textLabel.text = [self.paises objectAtIndex:indexPath.row];
   
    return cell;
}
- (UITableViewCell *)makeLensListCell: (NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = paises.count;
    return numberOfRows;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.paisTextField.text = [self.paises objectAtIndex:indexPath.row];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 666){
        return FALSE;
    }else{
        return YES;
    }
}


//////////////Fin del delegado

- (IBAction)onCancelar:(id)sender {
    
    
    ViewControllerPregunta *nc = [[ViewControllerPregunta alloc] init];
    [self presentViewController:nc animated:YES completion:nil];
}

- (IBAction)onAceptar:(id)sender {
    if(![self.nombreTextField.text isEqualToString:@""] && [self.nombreTextField.text length] >= 3){
        nombreTextField.backgroundColor=[UIColor whiteColor];
        
        if(![self.apellidoTextField.text isEqualToString:@""] && [self.apellidoTextField.text length] >= 3){
            self.apellidoTextField.backgroundColor=[UIColor whiteColor];
            
            if(![self.correoTextField.text isEqualToString:@""] && [self validateEmailWithString:[self.correoTextField text]])
            {
                 self.correoTextField.backgroundColor=[UIColor whiteColor];
                
                
                
                if(![self.telefonoTextField.text isEqualToString:@""] && [self.telefonoTextField.text length] == 10){
                    self.telefonoTextField.backgroundColor=[UIColor whiteColor];

                    if(![self.diaTextField.text isEqualToString:@""] && [self.diaTextField.text length] == 2 && [[self.diaTextField text] integerValue] > 0 && [[self.diaTextField text] integerValue] <= 31){
                        self.diaTextField.backgroundColor=[UIColor whiteColor];
                        
                        
                        if(![self.mesTextField.text isEqualToString:@""] && [self.mesTextField.text length] == 2 && [[self.mesTextField text] integerValue] > 0 && [[self.mesTextField text] integerValue] <= 12){
                            self.mesTextField.backgroundColor=[UIColor whiteColor];
                            
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"yyyy"];
                            NSString *yearString = [formatter stringFromDate:[NSDate date]];
                            if(![self.anoTextField.text isEqualToString:@""] && [self.anoTextField.text length] == 4  && [[self.anoTextField text] integerValue] >= 1920 && [[self.anoTextField text] integerValue] <= [yearString intValue]){
                                self.anoTextField.backgroundColor=[UIColor whiteColor];
                                
                                if(![self.paisTextField.text isEqualToString:@""] && [self.paisTextField.text length] >= 2 ){
                                    self.paisTextField.backgroundColor=[UIColor whiteColor];
                                    
                                    
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirma tus Datos" message:[NSString stringWithFormat:@"Es importante que tus datos sean auténticos para poder garantizarte un buen servicio. \n\nIMPORTANTE-El correo que ingresaste electrónico será ligado a tu cuenta y solo podrá registrarse UNA VEZ. Si alguien ha transferido saldo a este correo lo recibirás en cuanto lo valides. \n \nLos datos que quieres registrar son: \nNombre: %@ \nApellido: %@ \nCORREO: %@ \nTelefono: %@\nFecha de nacimiento: %@-%@-%@ \nPais de residencia: %@ \n\n",[self.nombreTextField text], [self.apellidoTextField text], [self.correoTextField text], [self.telefonoTextField text],[self.diaTextField text],[self.mesTextField text],[self.anoTextField text], [self.paisTextField text]]delegate:self  cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Validar",nil];
                                    alert.tag = 777;
                                    [alert show];

                                    
                                   /* ViewControllerRegSeguridad *vcs = [[ViewControllerRegSeguridad alloc]init];
                                    [[self navigationController] pushViewController:vcs animated:YES];*/
                                    
                                    
                                }else{
                                    self.paisTextField.backgroundColor=[UIColor yellowColor];
                                    [self.paisTextField becomeFirstResponder];

                                }

                            }else{
                                self.anoTextField.backgroundColor=[UIColor yellowColor];
                                [self.anoTextField becomeFirstResponder];
                                [[[iToast makeText:@"Año de nacimiento invaldo (4 digitos)"] setDuration:3000] show];
                            }
              
                        }else{
                            self.mesTextField.backgroundColor=[UIColor yellowColor];
                            [self.mesTextField becomeFirstResponder];
                            [[[iToast makeText:@"Mes de nacimiento invaldo (2 digitos)"] setDuration:3000] show];
                        }
  
                    }else{
                        self.diaTextField.backgroundColor=[UIColor yellowColor];
                        [self.diaTextField becomeFirstResponder];
                        [[[iToast makeText:@"Dia de nacimiento invaldo (2 digitos)"] setDuration:3000] show];
                    }
                }else{
                    self.telefonoTextField.backgroundColor=[UIColor yellowColor];
                    [self.telefonoTextField becomeFirstResponder];
                    [[[iToast makeText:@"telefono invaldo, Se requieren 10 digitos"] setDuration:3000] show];
                }
 
            }else{
                self.correoTextField.backgroundColor=[UIColor yellowColor];
                [self.correoTextField becomeFirstResponder];
                [[[iToast makeText:@"Correo invaldo"] setDuration:2000] show];
            }

        }else{
            self.apellidoTextField.backgroundColor=[UIColor yellowColor];
            [self.apellidoTextField becomeFirstResponder];
            [[[iToast makeText:@"Apellido invaldo"] setDuration:2000] show];
        }
    }else{
        nombreTextField.backgroundColor=[UIColor yellowColor];
        [nombreTextField becomeFirstResponder];
        [[[iToast makeText:@"Nombre invaldo"] setDuration:2000] show];
       
    }
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
