//
//  ViewController.h
//  ShuttleBus
//
//  Created by jhow on 7/19/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bus.h"

@interface ViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
{
    NSDateFormatter *formatter;
    Bus *bus;
}

typedef NS_ENUM(NSInteger, PageCurrentState)
{
    PREVIOUS_PAGE_STATE = 0,
    NEXT_PAGE_STATE
};

@end

