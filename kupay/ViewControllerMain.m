//
//  ViewController.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 12/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerMain.h"


#import "ViewControllerEscanear.h"
#import "ViewControllerTransferir.h"
#import "ViewControllerConsultar.h"
#import "ViewControllerCobrar.h"
#import "KuBDD.h"

@interface ViewControllerMain ()
-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest;
+(void)cambiarSaldo:(NSString *)saldo;
@end


@implementation ViewControllerMain
@synthesize saldo,referscar, saldoRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //se añaden los views controlers a el tabbar
        
      
        
        ViewControllerEscanear *escanear = [[ViewControllerEscanear alloc]  initWithNibName:@"ViewControllerEscanear" bundle:nil];
        ViewControllerTransferir *transferir = [[ViewControllerTransferir alloc]  initWithNibName:@"ViewControllerTransferir" bundle:nil];
        ViewControllerConsultar *consultar = [[ViewControllerConsultar alloc]  initWithNibName:@"ViewControllerConsultar" bundle:nil];
        ViewControllerCobrar *cobrar = [[ViewControllerCobrar alloc] initWithNibName:@"ViewControllerCobrar" bundle:nil];
        [cobrar.tabBarItem setTitle:@"cobrar"];
        [consultar.tabBarItem setTitle:@"consultar"];
        [escanear.tabBarItem setTitle:@"escanear"];
        [transferir.tabBarItem setTitle:@"transferir"];
        [escanear.tabBarItem setImage:[UIImage imageNamed:@"scanerLogoUnselected"]];
        [escanear.tabBarItem  setSelectedImage:[UIImage imageNamed:@"scanerLogoSelected"]];
        [consultar.tabBarItem setImage:[UIImage imageNamed:@"historyLogoUnselected"]];
        [consultar.tabBarItem setSelectedImage:[UIImage imageNamed:@"historyLogoSelected"]];
        [transferir.tabBarItem setImage:[UIImage imageNamed:@"transferLogoUnselected"]];
        [transferir.tabBarItem setSelectedImage:[UIImage imageNamed:@"transferLogoSelected"]];
        [cobrar.tabBarItem setImage:[UIImage imageNamed:@"transferLogoUnselected"]];
        [cobrar.tabBarItem setSelectedImage:[UIImage imageNamed:@"transferLogoSelected"]];
        self.tabBarController.selectedIndex = 2;  //tabbar inicia en el elemento 3
        NSArray* controlers = [NSArray arrayWithObjects:escanear,transferir,cobrar,consultar,nil];
        [self setViewControllers:controlers];
        
        
        //Se da estilo al tabbar
        [self.tabBarController.tabBar setTranslucent:NO];
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor clearColor]];
        [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selectedTab"]];
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
        [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabhostbg"]];
        [[UITabBarItem appearance] setTitleTextAttributes:
        [NSDictionary dictionaryWithObjectsAndKeys:
        [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0], UITextAttributeTextColor,
          [UIFont fontWithName:@"ProximaNova-Semibold" size:0.0], UITextAttributeFont,
          nil]forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:
        [NSDictionary dictionaryWithObjectsAndKeys:
        [UIColor whiteColor], UITextAttributeTextColor,
        [UIFont fontWithName:@"ProximaNova-Semibold" size:0.0], UITextAttributeFont,
          nil]forState:UIControlStateSelected];
        [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
        
        
        
        UIBarButtonItem *buttonRigth = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh"] style:UIBarButtonItemStyleBordered target:self action:@selector(handlereferscar)];
        
        
        [self.navigationItem setRightBarButtonItem:buttonRigth];

        
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"opciones"] style:UIBarButtonItemStyleBordered target:self.parentViewController action:@selector(revealToggle:)];
        
        
        [self.navigationItem setLeftBarButtonItem:button];

        [self handlereferscar];
 

    }
    return self;
}

- (void) handlereferscar
{
    KuBDD *bdd = [[KuBDD alloc] init];
    [bdd abrirBDDenPath:@"database.kupay"];
    NSString *imei = [bdd obtenerDatoConKey:@"kuPrivKey" deLaTabla:@"USR"];
    NSString *usr = [bdd obtenerDatoConKey:@"id" deLaTabla:@"USR"];
    [bdd cerrarBdd];
    NSLog(@"DATOS EN BDD %@, %@", imei, usr);
    
    NSMutableDictionary *nameElements = [NSMutableDictionary dictionary];
    
   [nameElements setObject:usr forKey:@"emisor"];
   [nameElements setObject:imei forKey:@"imei"];
   
    saldoRequest = [[KUSoket alloc] init];
    saldoRequest.delegate = self;
    [saldoRequest startRequestForAction:@"5" andData:nameElements];

    

}

- (void) handlenavicon
{
    
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
      //[v release];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest{
     NSString *result = elrequest.responseString;
     NSError *error = nil;NSLog(@"respuesta es: %@",result);
     NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    if ([dataDictionary[@"RESULTADO"] isEqualToString:@"ACTUALIZACION_CC_EXITOSA"]){
        switch (elrequest.tag) {
            case 390:
                NSLog(@"actualizando SALDO....");
                self.saldo.text=[NSString stringWithFormat:@"$%@",[dataDictionary[@"DATOS"] objectForKey:@"SALDO"]];
                break;
                
            default:
                break;
        }
    }
   

}
-(void)actualizarSaldo{
    [self handlereferscar];
}
-(void)cambiarSaldo:(NSString *)saldoN{
    self.navigationItem.title = [NSString stringWithFormat:@"$%@",saldoN];
}
-(void)processCompletedWhitResult:(NSDictionary *)result inAcction:(NSNumber *)acction{
    if ([acction integerValue]==5) {
        if ([[result objectForKey:@"RESULTADO"] isEqualToString:@"ACTUALIZACION_CC_EXITOSA"]) {
             self.navigationItem.title=[NSString stringWithFormat:@"$%@",[result[@"DATOS"] objectForKey:@"SALDO"]];
        }
    }
}
@end
