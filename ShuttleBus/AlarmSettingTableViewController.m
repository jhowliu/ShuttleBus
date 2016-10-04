//
//  AlarmSettingTableViewController.m
//  ShuttleBus
//
//  Created by jhow on 04/10/2016.
//  Copyright © 2016 Jhow. All rights reserved.
//

#import "AlarmSettingTableViewController.h"
#import "BusTableViewCell.h"
#import "JSONParser.h"
#import "Bus.h"

@interface AlarmSettingTableViewController ()

@property (strong, nonatomic) NSArray *busArray;

@end


@implementation AlarmSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadLocalization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.busArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusCell" forIndexPath:indexPath];
    
    Bus *bus = [self.busArray objectAtIndex:indexPath.row];
    
    if (cell == nil) cell = [[BusTableViewCell alloc] init];
    
    cell.busImg.image = bus.isPublic ? [UIImage imageNamed:@"Bus"] : [UIImage imageNamed:@"PoliceCar"];
    cell.busDepartTime.text = bus.depart;
    cell.busDescription.text = [NSString stringWithFormat:@"%@ To %@", bus.start, bus.arrival ];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Action

- (IBAction)didClickedSaveButton:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Localization

- (void)loadLocalization
{
    NSError *error;
    
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"bus" withExtension:@"json"];
   
    NSData *jsonData = [NSData dataWithContentsOfURL:filePath];
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    
    self.busArray = [JSONParser JsonArray2BusArray:jsonArray];
}
@end
