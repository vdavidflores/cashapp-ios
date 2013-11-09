
#import "RearViewController.h"
#import "RevealController.h"
#import "ViewControllerMain.h"
#import "ViewControllerRetiro.h"
#import "ViewControllerLLaveKu.h"
#import "ViewControllerDeposito.h"
#import "ViewControllerPerfil.h"
#import "ViewControllerSoporte.h"
#import "ViewControllerDesenlaze.h"

@interface RearViewController()
@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;

#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [self makeLensListCell: cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];

	
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
		cell.textLabel.text = @"llave-Ku";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}else if (indexPath.row == 4)
	{
		cell.textLabel.text = @"Perfil";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}else if (indexPath.row == 5)
	{
		cell.textLabel.text = @"Soporte";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}else if (indexPath.row == 6)
	{
		cell.textLabel.text = @"Desenlazar equipo";
        cell.imageView.image = [UIImage imageNamed:@"mdm"];
	}




		
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
        if (![revealController.frontViewController isKindOfClass:[ViewControllerPerfil class]])
		{
			ViewControllerPerfil *frontViewController = [[ViewControllerPerfil alloc] init];
			[revealController setFrontViewController:frontViewController animated:NO];
			
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}else if (indexPath.row == 5)
	{
        if (![revealController.frontViewController isKindOfClass:[ViewControllerSoporte class]])
		{
			ViewControllerSoporte *frontViewController = [[ViewControllerSoporte alloc] init];
			[revealController setFrontViewController:frontViewController animated:NO];
			
		}
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}else if (indexPath.row == 6)
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
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end