#import "LogData.h"

@interface LogData()

@end

@implementation LogData

-(instancetype)init{
    self = [super init];
    if (self) {
        self.dictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (LogData*)create {
    return [[LogData alloc] init];
}

- (LogData*)pv:(NSString*)pv{
    [self append:@"eventType" withString:@"1"];
    [self append:@"dataName" withString:pv];
    return self;
}

- (LogData*)event:(NSString*)event{
    [self append:@"eventType" withString:@"2"];
    [self append:@"dataName" withString:event];
    return self;
}

- (LogData*)append:(NSDictionary*)dictionary{
    [self.dictionary addEntriesFromDictionary:dictionary];
    return self;
}

- (LogData*)append:(NSString *)key withString:(NSString *)value {
    //空数据无任何意义
    if (value!=nil && value.length!=0) {
        [self.dictionary setValue:value forKey:key];
    }
    return self;
}

- (LogData*)append:(NSString *)key withLong:(long)value {
    
    [self.dictionary setValue:[NSString stringWithFormat:@"%ld",value] forKey:key];
    return self;
}

- (LogData*)append:(NSString *)key withLongLong:(long long)value {
    [self.dictionary setValue:[NSString stringWithFormat:@"%lld",value] forKey:key];
    return self;
}

- (LogData*)append:(NSString *)key withInt:(int)value {
    [self.dictionary setValue:[NSString stringWithFormat:@"%d",value] forKey:key];
    return self;
}

- (LogData*)append:(NSString *)key withFloat:(float)value {
    [self.dictionary setValue:[NSString stringWithFormat:@"%f",value] forKey:key];
    return self;
}

- (LogData*)append:(NSString *)key withDouble:(double)value {
    [self.dictionary setValue:[NSString stringWithFormat:@"%f",value] forKey:key];
    return self;
}

- (LogData*)append:(NSString *)key withBool:(bool)value {
    [self.dictionary setValue:(value?@"1":@"0") forKey:key];
    return self;
}

@end
