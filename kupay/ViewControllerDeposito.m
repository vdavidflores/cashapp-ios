//
//  ViewControllerDeposito.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 31/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerDeposito.h"
#import "ViewControllerCodigoOXXO.h"
#import "ViewControllerTarjetaNueva.h"
#import "iToast.h"

@interface ViewControllerDeposito ()

@end

@implementation ViewControllerDeposito
@synthesize segmentedControl;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    [self.view  setBackgroundColor:[[ UIColor alloc] initWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
    
    [self kuTopbar];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)kuTopbar{
    
    
    CGRect frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 55.0f);
    UIView *topBar = [[UIView alloc] initWithFrame:frame];
    topBar.backgroundColor =  [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
    
    
    //boton de navicon
    UIButton *navicon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // [navicon addTarget:self action:@selector(handlenavicon) forControlEvents:UIControlEventTouchUpInside];
    [navicon setBackgroundImage:[UIImage imageNamed:@"opciones"] forState:UIControlStateNormal];
    [navicon setFrame:CGRectMake(0, 3, 65, 50)];
    [navicon addTarget:self.navigationController.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside ];
    
    
    
    //saldo
    UILabel* titulo = [[UILabel alloc] init];
    titulo.frame = CGRectMake(0,0,150,50.0);
    titulo.textAlignment = NSTextAlignmentCenter;
    titulo.textColor = [UIColor whiteColor];
    titulo.numberOfLines = 0;
    titulo.backgroundColor =[UIColor clearColor];
    titulo.text = @"Deposito";
    titulo.font = [titulo.font fontWithSize:20.0];
    
    [topBar addSubview:titulo];
    [titulo setCenter:CGPointMake(topBar.center.x, topBar.center.y)];
    [topBar addSubview:navicon];
    
    [self.view addSubview:topBar];
    

    [segmentedControl addTarget:self
                         action:@selector(pickOne:)
               forControlEvents:UIControlEventValueChanged];
    
	   
}

- (IBAction)Aceptoar:(id)sender {
    
    if (segmentedControl.selectedSegmentIndex ==1){
    ViewControllerCodigoOXXO *codifgooxo = [[ViewControllerCodigoOXXO alloc]init];
    [[self navigationController] pushViewController:codifgooxo animated:YES];
    }else{
  
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selecciona la tarjeta a usar" message:@"click for submission \n\n\n\n "delegate:self  cancelButtonTitle:@"Acepar"
                                              otherButtonTitles:@"Añadir otra",nil];
        
       UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(10, 40, 264, 120)];
        table.delegate = self;
        table.dataSource = self;
        [alert addSubview:table];
        
        [alert show];

        
        /*  ViewControllerTarjetaNueva *listTarj = [[ViewControllerTarjetaNueva alloc]init];
        [[self navigationController] pushViewController:listTarj animated:YES];
*/
    }
    
}
-(void) pickOne:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
   
    [iToast makeText:[NSString stringWithFormat:@"seleccionado %@",[segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]]]];
}



//DElegado de listView para 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MyIdentifier";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self makeLensListCell: CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
       
    }

    cell.textLabel.text = @"Tarjeta N";
    cell.editingAccessoryView = self.editButtonItem;
    return cell;
}
- (UITableViewCell *)makeLensListCell: (NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 5;
    return numberOfRows;
}


@end
