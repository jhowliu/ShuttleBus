//
//  ViewController.m
//  ShuttleBus
//
//  Created by jhow on 7/19/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import "ViewController.h"
#import "RequestHandler.h"
#import "JSONParser.h"
#import "Bus.h"

#define HOSTNAME "https://api.apb-shuttle.info"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.apb-shuttle.info/now" ]];
    
    [RequestHandler PerformRequestHandler:request withCompletionHandler:^(NSDictionary *data, NSError *error) {
        
        if (!error) {
            bus = [JSONParser JSON2Bus:data];
            [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                [self updateUI];
            }];
        } else {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

- (void)updateUI
{
    // The spacing style font
    NSDictionary *attributes = @{
                                 NSKernAttributeName: @10.0f
                                 };
    
    //self.busName.text = bus.name;
    //self.busTime.text = bus.depart;
    //self.busType.text = bus.note;
    
    self.busName.attributedText = [[NSMutableAttributedString alloc] initWithString:bus.name attributes:attributes];
    self.busTime.attributedText = [[NSMutableAttributedString alloc] initWithString:bus.depart attributes:attributes];
    self.busType.attributedText = [[NSMutableAttributedString alloc] initWithString:bus.note attributes:attributes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
