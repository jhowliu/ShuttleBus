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

@property (strong, nonatomic) NSMutableArray *busArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.apb-shuttle.info/now" ]];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(leftSwiping)];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(rightSwiping)];
    
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    
    [self sendURLRequest:request];
}

- (NSMutableArray *)busArray
{
    if (!_busArray) _busArray = [[NSMutableArray alloc] init];
    
    return _busArray;
}

static int count = 0;

- (void)sendURLRequest:(NSURLRequest *)requestObj
{
    [RequestHandler PerformRequestHandler:requestObj withCompletionHandler:^(NSDictionary *data, NSError *error) {
        
        if (!error) {
            count++;
            
            bus = [JSONParser JSON2Bus:data];
            // Add the bus object into the array.
            [self.busArray addObject: bus];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                [self updateUI];
            }];
        } else {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

- (void)leftSwiping
{
    NSLog(@"Swipe left !");
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.apb-shuttle.info/next/%d", count]]];
    
    [self sendURLRequest:request];
}

// Send the request for the next bus
- (void)rightSwiping
{
    if (count > 1) {
        NSLog(@"Swipe right !");
        count--;
        [self.busArray removeLastObject];
        bus = [self.busArray lastObject];
        [self updateUI];
    }
}

- (void)updateUI
{
    // The spacing style font
    NSDictionary *titleAttributes = @{
                                      NSKernAttributeName: @10.0f
                                     };
    NSDictionary *attributes = @{
                                 NSKernAttributeName: @5.0f
                                };
    
    //self.busName.text = bus.name;
    //self.busTime.text = bus.depart;
    //self.busType.text = bus.note;
    
    
    self.busName.attributedText = [[NSMutableAttributedString alloc] initWithString:bus.name attributes:titleAttributes];
    self.busTime.attributedText = [[NSMutableAttributedString alloc] initWithString:bus.depart attributes:titleAttributes];
    self.busType.attributedText = [[NSMutableAttributedString alloc] initWithString:bus.note attributes:attributes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
