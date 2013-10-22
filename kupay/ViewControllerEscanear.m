//
//  ViewControllerEscanear.m
//  kupay
//
//  Created by Ma. Cristina Gonzalez Mayorga on 10/10/13.
//  Copyright (c) 2013 ku. All rights reserved.
//

#import "ViewControllerEscanear.h"


@interface ViewControllerEscanear ()

@end

@implementation ViewControllerEscanear
@synthesize reader,ecaneando;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"dsfds");


    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  //  [self scan];
    self.view.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];

    NSLog(@"cargando vista por primera vez");
    if ([self init_camera]) {
        self.ecaneando = YES;
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"abriendo escaneo");
    if (self.ecaneando){
        NSLog(@"el escaner esta cargado");
    }else{
        NSLog(@"el escaner NO esta cargado");
        [self.reader start];
    }
    
}

- (void) viewDidDisappear:(BOOL)animated{
    NSLog(@"escaneo cerrado");
    self.ecaneando = NO;
    [self.reader stop];
}
- (void) readerView:(ZBarReaderView *)readerView didReadSymbols: (ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol * s = nil;
    for (s in symbols)
    {
       //aqui va la deteccion del QR
        NSLog(s.data);
    }
}



- (BOOL) init_camera {
    self.reader = [ZBarReaderView new];
    ZBarImageScanner * scanner = [ZBarImageScanner new];
    [scanner setSymbology: 0
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    [scanner setSymbology: ZBAR_QRCODE
                   config: ZBAR_CFG_ENABLE
                       to: 1];
    [self.reader initWithImageScanner:scanner];
    [self.reader setTrackingColor:[[UIColor alloc] initWithRed:197.0/255.0
                                                         green:30.0/255.0
                                                          blue:79.0/255.0
                                                         alpha:1.0]];
    self.reader.readerDelegate = self;
    
    const float h = [UIScreen mainScreen].bounds.size.height;
    const float w = [UIScreen mainScreen].bounds.size.width;

    CGRect reader_rect = CGRectMake(0.0, 0.0,
                                    w , h );
    self.reader.frame = reader_rect;
    self.reader.backgroundColor = [UIColor colorWithRed:179.0/255.0 green:30.0/255.0 blue:79.0/255.0 alpha:1.0];
    [self.reader start];
    
    [self.view addSubview: self.reader];
    return YES;
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)tabImageName
{
	return @"comp.png";
}

@end
