//
//  kuTableViewCell.m
//  kupay
//
//  Created by Codigo KU on 23/08/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import "kuTableViewCell.h"

@implementation kuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // Makes imageView get placed in the corner
    self.imageView.frame = CGRectMake( 0, 10, 80, 50 );
    
    // Get textlabel frame
    //self.textLabel.backgroundColor = [UIColor blackColor];
    CGRect textlabelFrame = self.textLabel.frame;
    
    // Figure out new width
    textlabelFrame.size.width = textlabelFrame.size.width + textlabelFrame.origin.x - 90;
    // Change origin to what we want
    textlabelFrame.origin.x = 90;
    
    
    CGRect datailtextlabelFrame = self.detailTextLabel.frame;
    
    // Figure out new width
    datailtextlabelFrame.size.width = datailtextlabelFrame.size.width + datailtextlabelFrame.origin.x - 90;
    // Change origin to what we want
    datailtextlabelFrame.origin.x = 90;
    
    // Assign the the new frame to textLabel
    self.textLabel.frame = textlabelFrame;
    self.detailTextLabel.frame = datailtextlabelFrame;
   
}

@end
