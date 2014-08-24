//
//  ViewControllerCodigoOXXO.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 31/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerCodigoOXXO.h"

@interface ViewControllerCodigoOXXO ()

@end

@implementation ViewControllerCodigoOXXO

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
    [self kuTopbar];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self kuTopbar];
    // Dispose of any resources that can be recreated.
}

-(void)kuTopbar{
    
    [self.navigationItem setTitle:@"Tienda"];

}
- (IBAction)atras:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
