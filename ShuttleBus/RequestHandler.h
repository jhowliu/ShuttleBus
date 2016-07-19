//
//  RequestHandler.h
//  ShuttleBus
//
//  Created by jhow on 7/19/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestHandler : NSObject


// Return the dictionary-type data
+ (void)PerformRequestHandler: (NSURLRequest *)request
        withCompletionHandler:(void (^)(NSDictionary *data, NSError *error)) completionHandler;

@end
