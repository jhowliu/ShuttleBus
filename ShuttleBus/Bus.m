//
//  Bus.m
//  ShuttleBus
//
//  Created by jhow on 7/20/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import "Bus.h"

@implementation Bus

- (Bus *)initWithDict:(NSDictionary *)busDict
{
    self = [super init];
    
    if (self) {
        self.name = [busDict objectForKey:@"bus"];
        self.depart = [busDict objectForKey:@"time"];
        self.start = [busDict objectForKey:@"start"];
        self.arrival = [busDict objectForKey:@"arrival"];
        self.isAdditional = [[busDict objectForKey:@"additional"] boolValue];
        self.isPublic = [self.name isEqualToString:@"亞通巴士"] ? YES : NO;
    }
    
    return self;
}

@end
