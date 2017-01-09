//
//  Track.h
//  Track
//
//  Created by Kenvin on 2016/03/10.
//  Copyright © 2016年 Kenvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogData.h"

@interface Tracker : NSObject

+ (id)sharedInstance;

/**
 *  @brief  设置UUID
 */
+ (void)setUUID:(NSString*)uuid;

- (void)addLog:(LogData*)logData;

- (void)exit;

@end
