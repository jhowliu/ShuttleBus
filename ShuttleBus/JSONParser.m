//
//  JSONParser.m
//  ShuttleBus
//
//  Created by jhow on 7/20/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import "JSONParser.h"
#import "Bus.h"

@implementation JSONParser

+ (NSDictionary *)Data2JSON:(NSData *)data
{
    NSError *error = nil;
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingMutableContainers error:&error];
    
    return !error ? result : nil;
}

+ (NSData *)JSON2Data:(NSDictionary *)dict
{
    NSError *error = nil;
    
    NSData *result = [NSJSONSerialization dataWithJSONObject:@[dict] options:kNilOptions error:&error];
    
    return !error ? result : nil;
}

+ (Bus *)JSON2Bus:(NSDictionary *)jsonDict
{
    Bus *bus = [[Bus alloc] initWithDict:jsonDict];
    
    return bus;
}

+ (NSDictionary *)Bus2JSON:(Bus *)bus
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:bus.name forKey:@"bus"];
    [dict setObject:bus.depart forKey:@"time"];
    [dict setObject:bus.start forKey:@"start"];
    [dict setObject:bus.arrival forKey:@"arrival"];
    [dict setObject:[NSString stringWithFormat:@"%@", (bus.isAdditional) ? @"true":@"false"]
             forKey:@"additional"];
    
    return dict;
}

# pragma mark - JsonArray to bus array
+ (NSArray *)JsonArray2BusArray:(NSArray *)jsonArray {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    
    for (NSDictionary *bus in jsonArray) [tmp addObject:[self JSON2Bus:bus]];
    
    return [tmp copy];
}

@end
