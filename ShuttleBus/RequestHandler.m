//
//  RequestHandler.m
//  ShuttleBus
//
//  Created by jhow on 7/19/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import "RequestHandler.h"

@implementation RequestHandler

+ (void)PerformRequestHandler:(NSURLRequest *)request withCompletionHandler:(void (^)(NSDictionary *, NSError *))completionHandler
{
    NSURLSession *session = [NSURLSession sharedSession];
   
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            
            // Convert NSData to NSDictionary
            NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers error:&error];
            
            completionHandler(responseData, error);
        } else {
            completionHandler(nil, error);
        }
    }];
    
    [dataTask resume];
}

@end