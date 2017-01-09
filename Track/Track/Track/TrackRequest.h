//
//  TrackRequest.h
//  Track
//
//  Created by Kenvin on 2016/03/10.
//  Copyright © 2016年 Kenvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackRequest : NSObject

#pragma mark - 发送Track数据

/**
 *  发送给BI Track数据
 *
 *
 */

+(BOOL)sendTrackDataSync:(NSString *)data;


/**
 *  发送给OTS Track数据
 *
 *
 */

+(BOOL)sendTrackOTSDataSync:(NSString *)data;

@end
