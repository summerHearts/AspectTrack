//
//  BIAop.m
//  AspectTrack
//
//  Created by 佐毅 on 16/3/4.
//  Copyright © 2016年 上海乐住信息技术有限公司. All rights reserved.
//

#import "BIStatistics.h"
#import "BIPVBase.h"
#import "MOAspects.h"
@implementation BIStatistics

+ (void)setupBIStatistics{
    
    [self setupWithConfiguration:[BIPVBase statisticsBIPVBase]];

}


+ (void)setupWithConfiguration:(NSDictionary *)configs{
    
    for (NSString *className in configs) {
        Class class = NSClassFromString(className);
        for (NSDictionary *event in configs[className]) {
            SEL selector = NSSelectorFromString(event[EventSelector]);
            id block = event[EventHandlerBlock];
            [MOAspects hookInstanceMethodForClass:class
                                         selector:selector
                                  aspectsPosition:MOAspectsPositionBefore
                                        hookRange:MOAspectsHookRangeAll
                                       usingBlock:block];
        }
    }
}

@end
