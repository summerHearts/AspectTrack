//
//  Sender.m
//  Track
//
//  Created by Kenvin on 2016/03/10.
//  Copyright © 2016年 Kenvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sender.h"
#import "TrackRequest.h"

static dispatch_once_t onceToken;

@interface Sender()

@property (strong, nonatomic) dispatch_queue_t sendQueue;
@property (nonatomic, assign) BOOL running;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@end

@implementation Sender

+ (id)sharedInstance{
    static Sender* sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Sender alloc] init];
    });
    return sharedInstance;
}

- (id)init{
    if (self = [super init]) {
        self.semaphore = dispatch_semaphore_create(0);
        self.dataArray = [self loadFromFile];
        self.sendQueue = dispatch_queue_create("sendQueue", NULL);
        self.running = YES;
        dispatch_async(self.sendQueue, ^{
            [self performSelector:@selector(executeLoop)];
        });
    }
    return self;
}

- (void)executeLoop{
    while(self.running){
        @synchronized(self) {
            if([self.dataArray count] > 0){
                NSString* data = [self.dataArray objectAtIndex:0];
       
                [TrackRequest sendTrackOTSDataSync:data];
            
                BOOL sendResult = [TrackRequest sendTrackDataSync:data];
                if(sendResult){
                    [self.dataArray removeObjectAtIndex:0];
                }else{
                    [self.dataArray addObject:data];
                    [self.dataArray removeObjectAtIndex:0];
                }
            }
        }
        sleep(1);
        if([self.dataArray count] == 0){
            dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60.0 * NSEC_PER_SEC));
            dispatch_semaphore_wait(self.semaphore, timeout);
        }
        NSLog(@"%@", @"in loop~~~~~~");
    }
}

- (NSMutableArray*)loadFromFile{
    NSString* path = [Sender getSaveFilePath];
    NSMutableArray* dataArray = [NSMutableArray arrayWithContentsOfFile:path];
    if(dataArray == nil){
        dataArray = [NSMutableArray array];
    }
    return dataArray;
}

- (void)saveToFile{
    NSString* path = [Sender getSaveFilePath];
    @synchronized(self) {
        [self.dataArray writeToFile:path atomically:YES];
    }
}

- (void)addToSendingList:(NSString*)data {
    @synchronized(self) {
        [self.dataArray addObject:data];
    }
    dispatch_semaphore_signal(self.semaphore);
}

- (void)exit{
    [self saveToFile];
    self.running = NO;
    onceToken = 0;
}

//获取存储文件路径
+ (NSString*)getSaveFilePath{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* sandBoxPath = [paths objectAtIndex:0];
    NSString* dataPath = [sandBoxPath stringByAppendingPathComponent:@"track_data"];
    NSFileManager* fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:dataPath]){
        [fm createFileAtPath:dataPath contents:nil attributes:nil];
    }
    return dataPath;
}

@end
