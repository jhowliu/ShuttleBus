//
//  JSONParser.h
//  ShuttleBus
//
//  Created by jhow on 7/20/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bus.h"

@interface JSONParser : NSObject

+ (NSDictionary *)Data2JSON:(NSData *)data;
+ (NSData *)JSON2Data:(NSDictionary *)dict;

+ (Bus *)JSON2Bus:(NSDictionary *)jsonDict;
+ (NSDictionary *)Bus2JSON:(Bus *)bus;

+ (NSArray *)JsonArray2BusArray:(NSArray *)jsonArray;

@end
