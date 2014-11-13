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
@property (weak, nonatomic) IBOutlet UITableView *tableViewRows;
@property NSIndexPath *lastIndexPath;
@property NSMutableArray *checkedIndexPaths;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rowsArray = [NSMutableArray arrayWithObjects:@"Fila 1", @"Fila 2", @"Fila 3", @"Fila 4", nil];
    self.checkedIndexPaths = [[NSMutableArray alloc] init];
    for (int i= 0; i < self.rowsArray.count; i++) {
        [self.checkedIndexPaths addObject:[NSNumber numberWithBool:NO]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"rowCellId" forIndexPath:indexPath];
    cell.textLabel.text = [self.rowsArray objectAtIndex:indexPath.row];
    //if ([indexPath compare:self.lastIndexPath] == NSOrderedSame) {
    if ([self.checkedIndexPaths objectAtIndex:indexPath.row] == [NSNumber numberWithBool:YES]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        [self.checkedIndexPaths replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
    } else {
        [self.checkedIndexPaths replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
    }
    [self.tableViewRows reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.rowsArray removeObjectAtIndex:indexPath.row];
        [self.tableViewRows deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableViewRows reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAddButtonPressed:(id)sender {
    NSLog(@"Botón agregar presionado");
    [self.checkedIndexPaths addObject:[NSNumber numberWithBool:NO]];
    [self.rowsArray addObject:self.textFieldRow.text];
    [self.tableViewRows reloadData];
    self.textFieldRow.text = @"";
    [self.textFieldRow resignFirstResponder];
}

- (IBAction)onEditButtonPressed:(UIButton *)sender {
    NSLog(@"Botón editar presionado");
    if (self.tableViewRows.editing) {
        [self.editButton setTitle:@"Editar" forState:UIControlStateNormal];
        [self.tableViewRows setEditing:NO animated:YES];
    } else {
        [self.editButton setTitle:@"Hecho" forState:UIControlStateNormal];
        [self.tableViewRows setEditing:YES animated:YES];
    }
}
@end
