//
//  ViewControllerRegSeguridad.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 10/11/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerRegSeguridad.h"

@interface ViewControllerRegSeguridad ()

@end

@implementation ViewControllerRegSeguridad

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
   // [self addtop];
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
    
    UIImage *img1 = [UIImage imageNamed:@"datos"];
    UIImageView* img1View = [[UIImageView alloc] initWithImage:img1];
    img1View.frame = CGRectMake(20, 5, 50, 50);
    UILabel *lb1= [[UILabel alloc] initWithFrame:CGRectMake(20, 58, 50, 10)];
    lb1.text=@"datos";
    lb1.font = [UIFont systemFontOfSize:12];
    lb1.textAlignment = NSTextAlignmentCenter;
    lb1.textColor= [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
    [topBar addSubview:lb1];
    [topBar addSubview:img1View];
    
    UIImage *img2 = [UIImage imageNamed:@"seguridadS"];
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

@end
