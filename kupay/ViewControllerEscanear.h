//
//  ViewControllerEscanear.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 10/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import	"ASIFormDataRequest.h"
@interface ViewControllerEscanear : UIViewController <ZBarReaderViewDelegate>{
    ZBarReaderView * _reader;
}

@property (strong, nonatomic) ZBarReaderView * reader;
@property Boolean ecaneando;
@property (strong, nonatomic) UIAlertView *transfiriendoDialog;
@property (nonatomic, retain) ASIFormDataRequest *request;
@property (strong,nonatomic) NSString *pin;
@property (strong, nonatomic) UIAlertView * pinalert ;
@property (strong,nonatomic) NSString *qr;


@end
