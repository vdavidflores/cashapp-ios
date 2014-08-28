//
//  ViewControllerRetiro.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 28/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerRetiro.h"
#import "iToast.h"
#import "ViewControllerVerTarjetas.h"

@interface ViewControllerRetiro ()

@end

@implementation ViewControllerRetiro
@synthesize BTNacepar,clabe1,clabe2,monto, destino, clabeLabel, distanciaBTNAceparDeMonto;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view  setBackgroundColor:[[ UIColor alloc] initWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
    [destino addTarget:self
                  action:@selector(pickOne:)
        forControlEvents:UIControlEventValueChanged];
    [self kuTopbar];
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickOne:(id)sender{
    NSLog(@"piker: %ld",(long)[destino selectedSegmentIndex]);
    
    if ([destino selectedSegmentIndex]==0) {
        [clabeLabel setHidden:YES];
        [clabe1 setHidden:YES];
        [clabe2 setHidden:YES];
        distanciaBTNAceparDeMonto.constant = 38.0;
      
    }else if ([destino selectedSegmentIndex]==1){
        [clabeLabel setHidden:NO];
        [clabe1 setHidden:NO];
        [clabe2 setHidden:NO];
        distanciaBTNAceparDeMonto.constant = 138.0;

    }
}

-(void)kuTopbar{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"opciones"] style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    
    
    [self.navigationItem setLeftBarButtonItem:button];
    [self.navigationItem setTitle:@"Retiro"];


}


- (IBAction)onAceptar:(id)sender {
    if (![[monto text] isEqualToString:@""]) {
        monto.backgroundColor = [UIColor whiteColor];
        
        
        if (destino.selectedSegmentIndex == 0) {
            ViewControllerVerTarjetas *tarjetas =  [[ViewControllerVerTarjetas alloc]init];
            [tarjetas setMonto:[self.monto text]];
            [tarjetas setDeposito:NO];
            [[self navigationController] pushViewController:tarjetas animated:YES];
            
        }else{
            
        }
        
        
    }else{
        [[[iToast makeText:@"Cantidad vacia"]setDuration:2000] show] ;
        [monto becomeFirstResponder];
        monto.backgroundColor = [UIColor yellowColor];
        
        
    }
    
    
    
}
@end
