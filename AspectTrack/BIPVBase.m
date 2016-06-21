//
//  BIPVBase.m
//  AspectTrack
//
//  Created by 佐毅 on 16/3/4.
//  Copyright © 2016年 上海乐住信息技术有限公司. All rights reserved.
//

#import "BIPVBase.h"
#import "BIStatistics.h"
#import "BIPVConst.h"
#import "ViewController.h"
@implementation BIPVBase

+ (NSDictionary *)statisticsBIPVBase{
    return @{@"ViewController":@[
                     @{
                         EventSelector: @"viewWillAppear:",
                         EventHandlerBlock: ^(ViewController *controller,
                                              BOOL animated ) {
                             NSLog(@"埋雷了，小心!");
                        }
                         },
                     
                     ]};
}
@end
