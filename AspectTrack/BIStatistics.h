//
//  BIAop.h
//  AspectTrack
//
//  Created by 佐毅 on 16/3/4.
//  Copyright © 2016年 上海乐住信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BIPVConst.h"
#define EventSelector       @"EventSelector"
#define EventHandlerBlock   @"EventHandlerBlock"

@interface BIStatistics : NSObject

/**
 *  初始化BI统计
 */

+ (void)setupBIStatistics;

@end
