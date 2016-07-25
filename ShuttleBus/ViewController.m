//
//  ViewController.m
//  ShuttleBus
//
//  Created by jhow on 7/19/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import "ContentPageViewController.h"
#import "ViewController.h"
#import "RequestHandler.h"
#import "JSONParser.h"
#import "Bus.h"

#define HOSTNAME "https://api.apb-shuttle.info"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *busArray;
@property (strong, nonatomic) NSMutableArray *pages;
@property (strong, nonatomic) UIPageViewController *pageViewVC;


@end

@implementation ViewController

static int count = 1;
static int pageIndex = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.apb-shuttle.info/now" ]];
    
    [self sendURLRequest:request];

    self.pageViewVC.dataSource = self;
    self.pageViewVC.delegate = self;
    
    ContentPageViewController *page = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentPageViewController"];
    
    [self.pageViewVC setViewControllers:@[page] direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO completion:nil];
    
    [self.pages addObject:page];
   
    [self addChildViewController:self.pageViewVC];
    [self.view addSubview:self.pageViewVC.view];
}

- (UIPageViewController *)pageViewVC
{
    if (!_pageViewVC) _pageViewVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    
    return _pageViewVC;
}

- (NSMutableArray *)busArray
{
    if (!_busArray) _busArray = [[NSMutableArray alloc] init];
    
    return _busArray;
}

- (NSMutableArray *)pages
{
    if (!_pages) _pages = [[NSMutableArray alloc] init];
    
    return _pages;
}

- (void)sendURLRequest:(NSURLRequest *)requestObj
{
    isLoading = YES;
    [RequestHandler PerformRequestHandler:requestObj withCompletionHandler:^(NSDictionary *data, NSError *error) {
        
        if (!error) {
            bus = [JSONParser JSON2Bus:data];
            // Add the bus object into the array.
            [self.busArray addObject: bus];
            [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                [self updatePageUI];
                isLoading = NO;
            }];
        } else {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

- (void)updatePageUI
{
    NSLog(@"updateuI %d", pageIndex);
    // The spacing style font
    NSDictionary *titleAttributes = @{
                                      NSKernAttributeName: @10.0f
                                     };
    NSDictionary *attributes = @{
                                 NSKernAttributeName: @5.0f
                                };
    
    
    ContentPageViewController *page = [self.pages objectAtIndex:pageIndex];
    
    page.busName.attributedText = [[NSMutableAttributedString alloc] initWithString:bus.name
                                                                 attributes:titleAttributes];
    page.busTime.attributedText = [[NSMutableAttributedString alloc] initWithString:bus.depart
                                                                 attributes:titleAttributes];
    page.busType.attributedText = [[NSMutableAttributedString alloc] initWithString:bus.note
                                                                 attributes:attributes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewController datasource 

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    // Check the if the download task is done
    if (isLoading) return nil;
    
    pageIndex++;
    NSLog(@"%d, %d", pageIndex, count);
    
    if (pageIndex == count) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL
                                       URLWithString:[NSString stringWithFormat:@"https://api.apb-shuttle.info/next/%d", count]]];
        ContentPageViewController *page = [self.storyboard
                               instantiateViewControllerWithIdentifier:@"ContentPageViewController"];
        [self sendURLRequest:request];
        [self.pages addObject:page];
        count++;
    }
    
    
    return [self.pages objectAtIndex:pageIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (pageIndex == 0) return nil;
    
    pageIndex--;
    NSLog(@"%d", pageIndex);
   
    return [self.pages objectAtIndex:pageIndex];
}

# pragma mark - UIPageViewController delegate

- (void)pageViewController:(UIPageViewController *)pageViewController
    willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    NSLog(@"Animation Start");
    self.view.userInteractionEnabled = NO;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed && finished) self.view.userInteractionEnabled = YES;
}

@end
