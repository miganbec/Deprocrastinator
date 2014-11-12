//
//  ViewController.m
//  Deprocrastinator
//
//  Created by miganbec on 12/11/14.
//  Copyright (c) 2014 miganbec. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property NSMutableArray *rowsArray;
@property (weak, nonatomic) IBOutlet UITextField *textFieldRow;
- (IBAction)onAddButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableViewRows;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rowsArray = [NSMutableArray arrayWithObjects:@"Fila 1", @"Fila 2", @"Fila 3", @"Fila 4", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"rowCellId" forIndexPath:indexPath];
    cell.textLabel.text = [self.rowsArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAddButtonPressed:(id)sender {
    NSLog(@"Botón presionado");
    [self.rowsArray addObject:self.textFieldRow.text];
    [self.tableViewRows reloadData];
}
@end
