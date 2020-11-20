//
//  STTableViewController.m
//  AutoLayout
//
//  Created by stone on 2020/11/18.
//

#import "STTableViewController.h"

@interface STTableViewCell : UITableViewCell

@end

@implementation STTableViewCell

@end

@interface STTableViewController ()

@property (nonatomic, strong) NSArray *array;

@end

@implementation STTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[STTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.array = @[@"111111111111111111111111111111111111111111111",
                   @"2222222222",
                   @"333333333333333",
                   @"44444444444444444444",
                   @"55555555555",
                   @"666666666666666666666666666666",
                   @"777777777777777777777777777777777777",
                   @"888888",
                   @"999999999999999999999999999999999999999",
                   @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                   @"bbbbbbbbbbbbbbbb",
                   @"ccccc",
                   @"ddd",
                   @"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                   @"ffffffffffffffffff",
                   @"gggggg"];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = self.array[indexPath.row];
    cell.detailTextLabel.text = self.array[indexPath.row];
    cell.detailTextLabel.numberOfLines = 0;
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


@end
