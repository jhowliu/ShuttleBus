//
//  BusTableViewCell.h
//  ShuttleBus
//
//  Created by jhow on 04/10/2016.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *busImg;
@property (weak, nonatomic) IBOutlet UILabel *busDepartTime;
@property (weak, nonatomic) IBOutlet UILabel *busDescription;

@end
