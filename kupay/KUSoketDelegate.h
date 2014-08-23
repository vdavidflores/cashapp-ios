//
//  KUSoketDelegate.h
//  kupay
//
//  Created by Codigo KU on 20/06/14.
//  Copyright (c) 2014 ku. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol KUSoketDelegate <NSObject>
@required
- (void) processCompleted;
@end
@interface KUSoketDelegate : NSObject

{
    // Delegate to respond back
    id <KUSoketDelegate> _delegate;	
    
}
@property (nonatomic,strong) id delegate;

-(void)startSampleProcess; // Instance method

@end