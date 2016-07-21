//
//  ViewController.h
//  ShuttleBus
//
//  Created by jhow on 7/19/16.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bus.h"

@interface ViewController : UIViewController {
    Bus *bus;
}

@property (weak, nonatomic) IBOutlet UILabel *busName;
@property (weak, nonatomic) IBOutlet UILabel *busTime;
@property (weak, nonatomic) IBOutlet UILabel *busType;

@end

