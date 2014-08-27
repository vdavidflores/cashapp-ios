//
//  KUSoket.h
//  kupay
//
//  Created by Codigo KU on 20/06/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import	"ASIFormDataRequest.h"
@protocol KUSoketDelegate <NSObject>
@required
- (void) processCompletedWhitResult:(NSDictionary*)result inAcction:(NSNumber*)acction;
@end
// Protocol Definition ends here
@interface KUSoket : NSObject

{
    // Delegate to respond back
    id <KUSoketDelegate> _delegate;
    
}
@property (nonatomic,strong) id delegate;
@property (nonatomic, retain) ASIFormDataRequest *request;
-(void)startRequestForAction:(NSString*)action andData:(NSMutableDictionary*)data; // Instance method
-(void)stopRequest;
@end