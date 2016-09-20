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

@property (strong, nonatomic) NSArray *busArray;
@property (strong, nonatomic) NSMutableArray *pages;
@property (strong, nonatomic) ContentPageViewController *page;
@property (strong, nonatomic) UIPageViewController *pageViewVC;

@end

@implementation ViewController

PageCurrentState pageState;

static int count = 1;
static int pageIndex = 0;
static int closestBusIndex = -1;


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.apb-shuttle.info/now" ]];
    
    //[self sendURLRequest:request];

    self.pageViewVC.dataSource = self;
    self.pageViewVC.delegate = self;
    
    ContentPageViewController *page = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentPageViewController"];
   
    // Set first content page
    self.page = page;
    
    [self.pageViewVC setViewControllers:@[page] direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO completion:nil];
    
    [self.pages addObject:page];
    [self addChildViewController:self.pageViewVC];
    [self.view addSubview:self.pageViewVC.view];
    
    [self loadLocalization];
    [self updatePageUI];
}

- (UIPageViewController *)pageViewVC
{
    if (!_pageViewVC) _pageViewVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    
    return _pageViewVC;
}

- (NSArray *)busArray
{
    if (!_busArray) _busArray = [[NSArray alloc] init];
    
    return _busArray;
}

- (NSMutableArray *)pages
{
    if (!_pages) _pages = [[NSMutableArray alloc] init];
    
    return _pages;
}

// You cannot initalize it because you will get nothing when you call it. (I'm not sure why it happened, because i forgot the ! mark)
- (ContentPageViewController *)page
{
    if (!_page) _page = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentPageViewController"];
    
    return _page;
}

/*
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
 */

- (void)updatePageUI
{
    NSString *body = [NSString stringWithFormat:@"%@ To %@", bus.start, bus.arrival];
    
    // The spacing style font
    NSDictionary *attributes = @{
                                 NSKernAttributeName: @5.0f
                                };
    
    
    self.page = [self.pages objectAtIndex:pageIndex];
    //NSLog(@"Updated %@", self.page);
    
    self.page.busName.attributedText = [[NSMutableAttributedString alloc] initWithString:bus.name
                                                                              attributes:attributes];
    self.page.busTime.attributedText = [[NSMutableAttributedString alloc] initWithString:bus.depart
                                                                              attributes:attributes];
    self.page.busBody.attributedText = [[NSMutableAttributedString alloc] initWithString:body
                                                                              attributes: attributes];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewController datasource 

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    pageState = NEXT_PAGE_STATE;
    
    pageIndex++;
    closestBusIndex = (closestBusIndex+1) == [self.busArray count] ? 0 : closestBusIndex+1;
    //NSLog(@"%d, %d", pageIndex, count);
    
    if (pageIndex == count) {
        ContentPageViewController *page = [self.storyboard
                               instantiateViewControllerWithIdentifier:@"ContentPageViewController"];
        [self.pages addObject:page];
        
        bus = [self.busArray objectAtIndex:closestBusIndex];
        
        // the page IBOutlet will be null, because they've not be presented yet.
        //[self updatePageUI];
        count++;
    }
    
    return [self.pages objectAtIndex:pageIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (pageIndex == 0) return nil;
    
    pageState = PREVIOUS_PAGE_STATE;
    
    pageIndex--;
    closestBusIndex = (closestBusIndex-1 < 0) ? (int)[self.busArray count]-1 : closestBusIndex-1;
   
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
    //NSLog(@"Animation finished :%d, completed :%d", finished, completed);
    if (finished) self.view.userInteractionEnabled = YES;
    
    if (!completed) {
        // Stay the current page if the user don't turn the page.
        // 0 = PREVIOUS, 1 = NEXT
        pageIndex = pageState ? pageIndex - 1 : pageIndex + 1;
    } else {
        return (count == pageIndex+1) ? [self updatePageUI] : nil;
    }
}

# pragma mark - Load localization

- (void)loadLocalization {
    NSError *error;
    
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"bus" withExtension:@"json"];
   
    NSData *jsonData = [NSData dataWithContentsOfURL:filePath];
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    
    self.busArray = [JSONParser JsonArray2BusArray:jsonArray];
    
    closestBusIndex = [self findClosestTime];
    
    bus = [self.busArray objectAtIndex:closestBusIndex];
}

- (int)findClosestTime {
    NSDate *now = [NSDate date];
    
    int indexOfClosestTime = -1;
    int currentTimeToSeconds = [self timeToSeconds:[formatter stringFromDate:now]];
    
    [self timeToSeconds:bus.depart];
    for (Bus *bus in self.busArray) {
        int tmp = [self timeToSeconds:bus.depart];
        int diff = currentTimeToSeconds - tmp;
        indexOfClosestTime +=1;
        
        if (diff < 0) break;
    }
    
    return indexOfClosestTime == -1 ? 0 : indexOfClosestTime;
}

- (int)timeToSeconds: (NSString *)time {
    int seconds = 0;
    
    NSArray *splitedStrings = [time componentsSeparatedByString:@":"];
    
    seconds += [[splitedStrings objectAtIndex:0] intValue] * 60 * 60;
    seconds += [[splitedStrings objectAtIndex:1] intValue] * 60;
    
    return seconds;
}

@end
