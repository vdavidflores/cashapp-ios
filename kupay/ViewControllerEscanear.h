//
//  ViewControllerEscanear.h
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 10/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
@interface ViewControllerEscanear : UIViewController <ZBarReaderDelegate>{
    ZBarReaderView * _reader;
}

@property (strong, nonatomic) ZBarReaderView * reader;
@property Boolean ecaneando;

@end
