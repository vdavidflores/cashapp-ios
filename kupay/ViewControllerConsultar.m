//
//  ViewControllerConsultar.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 12/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerConsultar.h"
#import "iToast.h"

@interface ViewControllerConsultar ()

@end

@implementation ViewControllerConsultar




- (NSString *)tabTitle
{
	return @"Consultas";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[[iToast makeText:[self.fruits objectAtIndex:[indexPath row]]] setDuration:2000] show];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
static NSString *CellIdentifier = @"Cell Identifier";
    
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

NSString *fruit = [self.fruits objectAtIndex:[indexPath row]];
  //  [cell setBackgroundColor:[UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
[cell.textLabel setText:fruit];
return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = [self.fruits count];
    return numberOfRows;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
    self.fruits = @[@"Apple", @"Pineapple", @"Orange", @"Banana", @"Pear", @"Kiwi", @"Strawberry", @"Mango", @"Walnut", @"Apricot", @"Tomato", @"Almond", @"Date", @"Melon", @"Water Melon", @"Lemon", @"Blackberry", @"Coconut", @"Fig", @"Passionfruit", @"Star Fruit"];
    
    //self.view.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
