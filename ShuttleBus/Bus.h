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
@property (strong, nonatomic) NSString *note;
@property (strong, nonatomic) NSString *depart;
@property (nonatomic) BOOL isSpecial;

// Initializing with a json file. 
- (Bus *)initWithDict:(NSDictionary *)busDict;

@end
