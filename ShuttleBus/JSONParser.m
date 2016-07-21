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
    Bus *bus = [[Bus alloc] initWithDict:[jsonDict objectForKey:@"bus"]];
    NSLog(@"%@, %@", bus.name, bus.note);
    return bus;
}

+ (NSDictionary *)Bus2JSON:(Bus *)bus
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:bus.name forKey:@"name"];
    [dict setObject:bus.note forKey:@"note"];
    [dict setObject:bus.depart forKey:@"depart"];
    
    [dict setObject:[NSNumber numberWithBool:bus.isSpecial] forKey:@"special"];
    
    return dict;
}
@end
