#import <Foundation/Foundation.h>

@interface LogData : NSObject

@property (nonatomic, strong) NSMutableDictionary *dictionary;

+ (LogData*)create;

- (LogData*)pv:(NSString*)pv;

- (LogData*)event:(NSString*)event;

- (LogData*)append:(NSDictionary*)dictionary;

- (LogData*)append:(NSString*)key withString:(NSString*)value;

- (LogData*)append:(NSString *)key withInt:(int)value;

- (LogData*)append:(NSString *)key withBool:(bool)value;

- (LogData*)append:(NSString *)key withFloat:(float)value;

- (LogData*)append:(NSString *)key withDouble:(double)value;

- (LogData*)append:(NSString *)key withLong:(long)value;

- (LogData*)append:(NSString *)key withLongLong:(long long)value;

@end
