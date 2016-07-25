//
//  ViewController.h
//  ShuttleBus
//
//  Created by jhow on 7/19/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bus.h"

@interface ViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
    Bus *bus;
    BOOL isLoading;
}

@end

