//
//  Sender.h
//  Track
//
//  Created by Kenvin on 2016/03/10.
//  Copyright © 2016年 Kenvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sender : NSObject

+ (id)sharedInstance;

- (void)addToSendingList:(NSString*)data;

- (void)exit;

@end

