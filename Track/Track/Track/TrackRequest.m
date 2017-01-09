//
//  TrackRequest.m
//  Track
//
//  Created by Kenvin on 2016/03/10.
//  Copyright © 2016年 Kenvin. All rights reserved.
//

#import "TrackRequest.h"
#import "MJExtension.h"
#import "TrackerModel.h"
#import <AVOSCloud/AVOSCloud.h>
#define APP_STATISTICS_URL     @"xxxxxxxxx"

@implementation TrackRequest

+(BOOL)sendTrackDataSync:(NSString *)data{
    NSArray* dataArray = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    if(dataArray == nil || ![dataArray isKindOfClass:[NSArray class]]){
        return NO;
    }
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:dataArray, @"data", nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    TrackerModel *trackerModel = [TrackerModel mj_objectWithKeyValues:jsonString];

    for (Data *data in trackerModel.data) {
        AVObject *testObject = [AVObject objectWithClassName:@"TrackerModel"];
        [testObject setObject:data.district forKey:@"district"];
        [testObject setObject:data.deviceId forKey:@"deviceId"];
        [testObject setObject:data.os forKey:@"os"];
        [testObject setObject:data.channel forKey:@"channel"];
        [testObject setObject:data.eventType forKey:@"eventType"];
        [testObject setObject:data.userId forKey:@"userId"];
        [testObject setObject:data.model forKey:@"model"];
        [testObject setObject:data.dataName forKey:@"dataName"];
        [testObject setObject:data.timeStamp forKey:@"timeStamp"];
        [testObject setObject:data.version forKey:@"version"];
        [testObject setObject:data.packageName forKey:@"packageName"];
        [testObject save];
    }
    return YES;
}

+(BOOL)sendTrackOTSDataSync:(NSString *)data{
    NSArray* dataArray = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    if(dataArray == nil || ![dataArray isKindOfClass:[NSArray class]]){
        return NO;
    }
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:dataArray, @"data", nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"baseUrl", @"sys/viewevent"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    return result != nil;
}

@end
