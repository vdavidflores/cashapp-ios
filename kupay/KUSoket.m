//
//  KUSoket.m
//  kupay
//
//  Created by Codigo KU on 20/06/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import "KUSoket.h"
@interface KUSoket ()
-(IBAction)enrespuesta:(ASIFormDataRequest *) elrequest;
@end
@implementation KUSoket
@synthesize request;
-(id) init
{
    if (self = [super init])
    {
        
    }
    return self;
}
-(void)startRequestForAction:(NSString*)action andData:(NSMutableDictionary*)data{
  /*
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self.delegate
                                   selector:@selector(processCompleted) userInfo:nil repeats:NO];*/
    
    [request cancel];
    [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://cashapp.mx/kuCloudAppDev/index.php"]]];
    
  //  NSMutableDictionary *nameElements = [NSMutableDictionary dictionary];
    NSMutableDictionary *nameElements = data;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:nameElements
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"DATA: %@", jsonString);
    
    [request setPostValue:action forKey:@"ACCION"];
    [request setPostValue:jsonString forKey:@"DATA"];
    

    request.shouldPresentCredentialsBeforeChallenge = YES;
    [request addBasicAuthenticationHeaderWithUsername:@"cashapp"
                                          andPassword:@"@Ganimedes648722883456995328"];
    
    [request setTimeOutSeconds:20];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    [request setShouldContinueWhenAppEntersBackground:YES];
#endif
    request.tag = [action integerValue];
    
    [request setDelegate:self];
    
    
    [request setDidFinishSelector:@selector(enrespuesta:)];
    [request startAsynchronous];
    
}
-(void)enrespuesta:(ASIFormDataRequest *)elrequest{
    NSString *result = elrequest.responseString;
    NSError *error = nil;NSLog(@"respuesta es: %@, - tag %ld",result, (long)[elrequest tag]);
    NSNumber * o = [NSNumber numberWithInt:[elrequest tag]];

    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    if (error == nil) {

        [self.delegate performSelector:@selector(processCompletedWhitResult:inAcction:) withObject:dataDictionary withObject:o];
    }else{
        NSDictionary * errorRES = [[NSDictionary init] alloc];
        [errorRES setValue:@"FALLA" forKey:@"RESULTADO"];
        [errorRES setValue:@"MENSAJE" forKey:@"Error de conexion"];
         [self.delegate performSelector:@selector(processCompletedWhitResult:inAcction:) withObject:errorRES withObject:o];
        
    }
    
 
    
    
    
}


-(void)stopRequest{
    if ([request isExecuting]) {
        [request cancel];
    }
    
    
  }

@end
