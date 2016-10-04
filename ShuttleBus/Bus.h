//
//  Bus.h
//  ShuttleBus
//
//  Created by jhow on 7/20/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bus : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *depart;
@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *arrival;
@property (nonatomic) BOOL isPublic;
@property (nonatomic) BOOL isAdditional;

// Initializing with a json file. 
- (Bus *)initWithDict:(NSDictionary *)busDict;

@end
