//
//  main.m
//  ShuttleBus
//
//  Created by jhow on 7/19/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RequestHandler.h"

int main(int argc, char * argv[]) {
    
    // For test
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.apb-shuttle.info/now" ]];
    
    [RequestHandler PerformRequestHandler:request withCompletionHandler:^(NSDictionary *data, NSError *error) {
        if (!error) {
            NSLog(@"%@", data);
        } else {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
