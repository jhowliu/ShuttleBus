//
//  AlarmSettingTableViewController.h
//  ShuttleBus
//
//  Created by jhow on 04/10/2016.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmSettingTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

-(IBAction)didClickedSaveButton:(UIBarButtonItem *)sender;

@end
