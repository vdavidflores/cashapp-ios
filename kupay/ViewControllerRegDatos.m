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
-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest;
@end

@implementation ViewControllerRegDatos
@synthesize request;
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
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
    
    //Se añade el top bar
  //  [self addtop];

    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addtop{		
    CGRect frame = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, 70.0f);
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
//DElegado de listView para




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
                
                    if(![self.diaTextField.text isEqualToString:@""] && [self.diaTextField.text length] == 2 && [[self.diaTextField text] integerValue] > 0 && [[self.diaTextField text] integerValue] <= 31){
                        self.diaTextField.backgroundColor=[UIColor whiteColor];
                        
                        
                        if(![self.mesTextField.text isEqualToString:@""] && [self.mesTextField.text length] == 2 && [[self.mesTextField text] integerValue] > 0 && [[self.mesTextField text] integerValue] <= 12){
                            self.mesTextField.backgroundColor=[UIColor whiteColor];
                            
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"yyyy"];
                            NSString *yearString = [formatter stringFromDate:[NSDate date]];
                            if(![self.anoTextField.text isEqualToString:@""] && [self.anoTextField.text length] == 4  && [[self.anoTextField text] integerValue] >= 1920 && [[self.anoTextField text] integerValue] <= [yearString intValue]){
                                self.anoTextField.backgroundColor=[UIColor whiteColor];
                                
                                
                                [self call];
                                
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView tag]== 400 && buttonIndex == 0){
        
        ViewControllerRegSeguridad *vcs = [[ViewControllerRegSeguridad alloc]init];
        [[self navigationController] pushViewController:vcs animated:YES];
    
    }
}

-(void)call{
    [request cancel];
    [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://cashapp.mx/kuCloudAppDev/index.php"]]];
    
    NSMutableDictionary *nameElements = [NSMutableDictionary dictionary];
    
    [nameElements setObject:[self.correoTextField text] forKey:@"email"];
    [nameElements setObject:[self.nombreTextField text] forKey:@"nombre"];
    [nameElements setObject:[self.apellidoTextField text] forKey:@"apellido"];
    NSString *fecha = [NSString stringWithFormat:@"%@-%@-%@" ,[self.anoTextField text], [self.mesTextField text], [self.diaTextField text]];
    [nameElements setObject:fecha forKey:@"fechaNas"];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:nameElements
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"DATA: %@", jsonString);
    
    [request setPostValue:@"2" forKey:@"ACCION"];
    [request setPostValue:jsonString forKey:@"DATA"];
    [request setTimeOutSeconds:20];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    [request setShouldContinueWhenAppEntersBackground:YES];
#endif
    
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(enrespuesta:)];
    [request startAsynchronous];
    
    self.validandoDialog = [[UIAlertView alloc] initWithTitle:@"Registrando usuario" message:@"cuenta hasta 10! ...1.2. \n\n\n\n"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:nil, nil];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(139.5, 95.5); // .5 so it doesn't blur
    self.validandoDialog.tag = 450;
    [self.validandoDialog addSubview:spinner];
    [spinner startAnimating];
    [self.validandoDialog show];
}

-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest{
    NSString *result = elrequest.responseString;
    NSError *error = nil;NSLog(@"respuesta es: %@",result);
  
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];

        

       
        NSLog(@"estatus: %@", [dataDictionary objectForKey:@"RESULTADO"]);
        if ([[dataDictionary objectForKey:@"RESULTADO"] isEqualToString:@"EXITO"] ) {
                  if ([self.validandoDialog isVisible]) [self.validandoDialog dismissWithClickedButtonIndex:-1 animated:YES];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registro exitoso!" message:@"Gracias por registrarte en Cashapp. recibirás un email de confirmación."delegate:self  cancelButtonTitle:@"Acepar"
                                                  otherButtonTitles:nil,nil];
            alert.tag = 400;
            [alert show];

             }else{
                 NSLog(@"textField"); // this will show which textField did end editing ...
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Registrado" message:@"Lo sentimos. Este correo no se registro intenta con otro o mas tarde."delegate:self  cancelButtonTitle:@"Acepar"
                                                       otherButtonTitles:nil,nil];
                 alert.tag = 4945;
                 [alert show];
             }
        

    

}



@end
