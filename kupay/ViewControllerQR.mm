//
//  ViewControllerQR.m
//  kupay
//
//  Created by Codigo KU on 23/07/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import "ViewControllerQR.h"
#import "QREncoder.h"
@interface ViewControllerQR ()

@end

@implementation ViewControllerQR
@synthesize operacion;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
          [self.view  setBackgroundColor:[[ UIColor alloc] initWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0]];
        
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    int qrcodeImageDimension = 250;
    
    //the string can be very long
    NSString* aVeryLongURL = [NSString stringWithFormat:@"https://cashapp.mx/kuCloudAppDev/pagoenlinea/?qr=%@",operacion];
    
    //first encode the string into a matrix of bools, TRUE for black dot and FALSE for white. Let the encoder decide the error correction level and version
    DataMatrix* qrMatrix = [QREncoder encodeWithECLevel:QR_ECLEVEL_AUTO version:QR_VERSION_AUTO string:aVeryLongURL];
    
    //then render the matrix
    UIImage* qrcodeImage = [QREncoder renderDataMatrix:qrMatrix imageDimension:qrcodeImageDimension];
    
   
    
    //put the image into the view
    UIImageView* qrcodeImageView = [[UIImageView alloc] initWithImage:qrcodeImage];
    CGRect parentFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBarController.tabBar.frame;
    
    //center the image
    CGFloat x = (parentFrame.size.width - qrcodeImageDimension) / 2.0;
    CGFloat y = (parentFrame.size.height - qrcodeImageDimension - tabBarFrame.size.height) / 2.0;
    CGRect qrcodeImageViewFrame = CGRectMake(x, y, qrcodeImageDimension+20, qrcodeImageDimension+20);

    [qrcodeImageView setFrame:qrcodeImageViewFrame];
    [qrcodeImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [qrcodeImageView.layer setBorderWidth:2.0];
    //[qrcodeImageView setBackgroundColor:[UIColor whiteColor]];
    //and that's it!
    [self.view addSubview:qrcodeImageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
