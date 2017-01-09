//
//  Track.m
//  Track
//
//  Created by Kenvin on 2016/03/10.
//  Copyright © 2016年 Kenvin. All rights reserved.
//

#import "Tracker.h"
#import "Sender.h"


static NSString *s_uuid;

@interface Tracker()

@property (nonatomic, readonly) int threshold;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation Tracker

+ (id)sharedInstance{
    static Tracker* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)setUUID:(NSString*)uuid{
    s_uuid = uuid;
}

- (id)init {
    if (self = [super init]) {
        _threshold = 20;//for release
#ifdef DEBUG
        _threshold = 3;//for test, 20
#endif
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)addLog:(LogData*)logData {
    @synchronized(self) {
        LogData* newData = [logData append:[self getDefaultParams]];
        [self.dataArray addObject:newData.dictionary];
        if (self.dataArray.count >=self.threshold) {
            NSString* data = [Tracker arrayToJson:self.dataArray];
            [[Sender sharedInstance] addToSendingList:data];
            [self.dataArray removeAllObjects];
        }
    }
}

- (NSDictionary*)getDefaultParams{
    NSDictionary* commonDic = @{@"district" : @"view appear",
                                @"packageName" :  [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                @"timeStamp" : [NSString stringWithFormat:@"%lld",(long long)[[NSDate date]timeIntervalSince1970]],
                                @"deviceId" : @"122xsdsdssfsdk232323",
                                @"model" : @"Main",
                                @"os" : @"ios",
                                @"version" : [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                @"channel" : @"appstore",
                                @"userId"  :@"23245"
                                };
    return commonDic;
}

+ (NSString*)arrayToJson:(NSArray*)array{
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:NULL];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)exit {
    NSString* data = [Tracker arrayToJson:self.dataArray];
    [[Sender sharedInstance] addToSendingList:data];
    [[Sender sharedInstance] exit];
    [self.dataArray removeAllObjects];
}

@end
