//
//  ContentPageViewController.h
//  ShuttleBus
//
//  Created by jhow on 7/25/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentPageViewController : UIViewController

@property NSUInteger pageIndex;

@property (weak, nonatomic) IBOutlet UILabel *busName;
@property (weak, nonatomic) IBOutlet UILabel *busTime;
@property (weak, nonatomic) IBOutlet UILabel *busBody;

@end
