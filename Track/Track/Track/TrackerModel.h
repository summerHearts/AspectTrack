//
//  TrackerModel.h
//  Track
//
//  Created by Kenvin on 2016/11/10.
//  Copyright © 2016年 Kenvin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Data;

@interface TrackerModel : NSObject

@property (nonatomic, strong) NSArray<Data *> *data;

@end



@interface Data : NSObject

@property (nonatomic, copy) NSString *district;

@property (nonatomic, copy) NSString *deviceId;

@property (nonatomic, copy) NSString *os;

@property (nonatomic, copy) NSString *channel;

@property (nonatomic, copy) NSString *eventType;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *model;

@property (nonatomic, copy) NSString *dataName;

@property (nonatomic, copy) NSString *timeStamp;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, copy) NSString *packageName;

@end


