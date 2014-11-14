//
//  ViewController.m
//  Deprocrastinator
//
//  Created by miganbec on 12/11/14.
//  Copyright (c) 2014 miganbec. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIAlertViewDelegate>
@property NSMutableArray *rowsArray;
@property (weak, nonatomic) IBOutlet UITextField *textFieldRow;
@property (weak, nonatomic) IBOutlet UITableView *tableViewRows;
@property NSMutableArray *checkedIndexPaths;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property NSIndexPath *alertIndexPath;
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
    self.alertIndexPath = indexPath;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"¿Estás seguro?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Sí", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.rowsArray removeObjectAtIndex:self.alertIndexPath.row];
        [self.tableViewRows deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.alertIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableViewRows reloadData];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)swipegesture {
    CGPoint location = [swipegesture locationInView:self.tableViewRows];
    NSIndexPath *indexPath = [self.tableViewRows indexPathForRowAtPoint:location];
    if (indexPath) {
        UITableViewCell *cell = [self.tableViewRows cellForRowAtIndexPath:indexPath];
        if (cell.tag == 0) {
            cell.backgroundColor = [UIColor greenColor];
            cell.tag++;
        } else if(cell.tag == 1) {
            cell.backgroundColor = [UIColor yellowColor];
            cell.tag++;
        } else if (cell.tag == 2) {
            cell.backgroundColor = [UIColor redColor];
            cell.tag++;
        } else if (cell.tag == 3) {
            cell.backgroundColor = [UIColor whiteColor];
            cell.tag = 0;
        }
    }
}

@end
