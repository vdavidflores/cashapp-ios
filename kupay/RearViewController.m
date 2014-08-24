
#import "RearViewController.h"
#import "RevealController.h"
#import "ViewControllerMain.h"
#import "ViewControllerRetiro.h"
#import "ViewControllerLLaveKu.h"
#import "ViewControllerDeposito.h"
#import "ViewControllerDesenlaze.h"
#import "ViewControllerInfo.h"
#import "kuTableViewCell.h"
#import "KuBDD.h"

@interface RearViewController()
@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;

#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        cell = (kuTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    } else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    
    if (cell == nil) {
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
            cell = [[kuTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];

	
	if (indexPath.row == 0)
	{
		cell.textLabel.text = @"Inicio";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}
	else if (indexPath.row == 1)
	{
		cell.textLabel.text = @"Deposito";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}
	else if (indexPath.row == 2)
	{
		cell.textLabel.text = @"Retiro";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}else if (indexPath.row == 3)
	{
		cell.textLabel.text = @"Código de Acceso";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}else if (indexPath.row == 4)
	{
		cell.textLabel.text = @"Desenlazar";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}else if (indexPath.row == 5)
	{
		cell.textLabel.text = @"Info Cashapp";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}
    /*else if (indexPath.row == 5)
	{
		cell.textLabel.text = @"Soporte";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}else if (indexPath.row == 6)
	{
		cell.textLabel.text = @"Desenlazar equipo";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}*/

	return cell;
}

-(UITableViewCell *)makeLensListCell: (NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
	RevealController *revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;

	// Here you'd implement some of your own logic... I simply take for granted that the first row (=0) corresponds to the "FrontViewController".
	if (indexPath.row == 0)
	{
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
		if (![revealController.frontViewController isKindOfClass:[ViewControllerMain class]])
		{
			ViewControllerMain *frontViewController = [[ViewControllerMain alloc] init];
			[revealController setFrontViewController:frontViewController animated:NO];
			
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}
	// ... and the second row (=1) corresponds to the "MapViewController".
	else if (indexPath.row == 1)
	{
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
      
        if (![revealController.frontViewController.navigationController.presentedViewController isKindOfClass:[ViewControllerDeposito class]])
		{
            
            NSLog(@"cargando el deposito");
            ViewControllerDeposito *frontViewController = [[ViewControllerDeposito alloc] init];
            UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:
                                           frontViewController ];
            
            
			[nc setNavigationBarHidden:YES];
          
			[revealController setFrontViewController:nc animated:YES];
			
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
      
	}
	else if (indexPath.row == 2)
	{
        
        
        if (![revealController.frontViewController isKindOfClass:[ViewControllerRetiro class]])
		{
            ViewControllerRetiro *retiro =[[ViewControllerRetiro alloc] init];
            [revealController setFrontViewController:retiro animated:YES];
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}
	else if (indexPath.row == 3)
	{
        if (![revealController.frontViewController isKindOfClass:[ViewControllerLLaveKu class]])
		{
            ViewControllerLLaveKu *frontViewController =[[ViewControllerLLaveKu alloc] init];
            
            
            
            [revealController setFrontViewController:frontViewController animated:YES];
            
			
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}else if (indexPath.row == 4)
	{
        if (![revealController.frontViewController isKindOfClass:[ViewControllerDesenlaze class]])
		{
			ViewControllerDesenlaze *frontViewController = [[ViewControllerDesenlaze alloc] init];
			[revealController setFrontViewController:frontViewController animated:NO];
			
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}else if (indexPath.row == 5)
	{
        if (![revealController.frontViewController isKindOfClass:[ViewControllerInfo class]])
		{
			ViewControllerInfo *frontViewController = [[ViewControllerInfo alloc] init];
			[revealController setFrontViewController:frontViewController animated:NO];
			
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}/*else if (indexPath.row == 6)
	{
        if (![revealController.frontViewController isKindOfClass:[ViewControllerDesenlaze class]])
		{
			ViewControllerDesenlaze *frontViewController = [[ViewControllerDesenlaze alloc] init];
			[revealController setFrontViewController:frontViewController animated:NO];
			
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}*/
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void)viewDidLoad{
    [super viewDidLoad];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.rearTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    KuBDD *bdd = [[KuBDD alloc] init];
    [bdd abrirBDDenPath:@"database.kupay"];
    self.displayUSR.text = [bdd obtenerDatoConKey:@"id" deLaTabla:@"USR"];
    [bdd cerrarBdd];

}

@end