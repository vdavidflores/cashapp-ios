//
//  ViewControllerQR.h
//  kupay
//
//  Created by Codigo KU on 23/07/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerQR : UIViewController{
    NSString *operacion;
 
}


@property (weak, nonatomic) IBOutlet UIImageView *imageFrame;
-(void)cargarQRconoperacion:(NSString *)qr;
@end
