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
        self.name = [busDict objectForKey:@"name"];
        self.note = [busDict objectForKey:@"note"];
        self.depart = [busDict objectForKey:@"depart"];
        self.isSpecial = [busDict objectForKey:@"special"];
    }
    
    return self;
}

@end
