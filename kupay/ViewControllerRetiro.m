//
//  ViewControllerRetiro.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 28/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerRetiro.h"

@interface ViewControllerRetiro ()

@end

@implementation ViewControllerRetiro


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self kuTopbar];
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)kuTopbar{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"opciones"] style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    
    
    [self.navigationItem setLeftBarButtonItem:button];
    [self.navigationItem setTitle:@"Retiro"];


}


@end
