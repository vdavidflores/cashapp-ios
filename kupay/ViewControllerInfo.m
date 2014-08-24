//
//  ViewControllerInfo.m
//  kupay
//
//  Created by Codigo KU on 19/07/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import "ViewControllerInfo.h"

@interface ViewControllerInfo ()

@end

@implementation ViewControllerInfo
@synthesize textview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view  setBackgroundColor:[[ UIColor alloc] initWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
        textview.textColor =  [UIColor whiteColor];
        textview.backgroundColor = [UIColor clearColor];
        
        [self kuTopbar];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [self.navigationItem setTitle:@"Información de Cashapp"];
    
    
}

@end
