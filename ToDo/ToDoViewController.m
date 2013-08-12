//
//  ToDoViewController.m
//  ToDo
//
//  Created by Mohtashim Khan on 8/12/13.
//  Copyright (c) 2013 YAHOO. All rights reserved.
//

#import "ToDoViewController.h"
#import "ToDoObj.h"
#import "ToDoCell.h"

#define kCellIdentifier     @"Cell"

@interface ToDoViewController ()

@property (strong, nonatomic) NSMutableArray* todoList;
@property (assign, nonatomic) NSUInteger editingRowIndex;

-(void)addMoreToDoItem;

@end

@implementation ToDoViewController

@synthesize todoList;
@synthesize editingRowIndex;

#pragma Mark - Private Methods

// Method called when the +(add) bar button is clicked
-(void)addMoreToDoItem
{
    self.editingRowIndex = 0;
    ToDoObj *newTodoObj = [[ToDoObj alloc] initWithTitle:@"" andEditMode:YES];
    [self.todoList insertObject:newTodoObj atIndex:0];
    [self.tableView insertRowsAtIndexPaths: @[ [NSIndexPath indexPathForRow:0 inSection:0] ]
                          withRowAnimation: UITableViewRowAnimationTop];
}


#pragma Mark - ViewController Methods

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Display an Edit button at the left in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Add a plus button on the right of the navigation bar to add an item to the ToDo list
    self.navigationItem.rightBarButtonItem =
                [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                              target:self
                                                              action:@selector(addMoreToDoItem)];
    
    // Set the Title
    self.title = NSLocalizedString(@"To Do List", @"Root Title");
    
    // Initialize the todoList
    if (self.todoList == nil ){
        self.todoList = [NSMutableArray array];
    }
    
    // Index of the current row being edited
    self.editingRowIndex = 0;
    
     // Register Custom Table Cell for reuse identifier
    [self.tableView registerClass:[ToDoCell class]
           forCellReuseIdentifier:kCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - Public Methods

// Return the existing todo list to save to disk in case application enters background/quits
-(NSArray*) getTodoList
{
    return [NSArray arrayWithArray:self.todoList];
}

// Load the todo list from saved file when the application starts
-(void) setTodoListOnLoad : (NSArray*) aTodoList
{
    self.todoList = [NSMutableArray arrayWithArray:aTodoList];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.todoList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                            forIndexPath:indexPath];
    ToDoCell *todoCell = (ToDoCell*)cell;
    
    // Add the textfield delegate if not done previously
    if (todoCell.titleText.delegate == nil){
        todoCell.titleText.delegate = self;
    }
    
    // Get the ToDo Object
    ToDoObj *todo = self.todoList[indexPath.row];

    // Configure the cell...
    todoCell.titleText.text = todoCell.titleLabel.text = todo.title;
    
    if ( todo.isEditMode ) {
        [todoCell switchToEditMode];
        [todoCell.titleText becomeFirstResponder];
    } else {
        [todoCell switchToReadOnly];
    }

    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.todoList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    ToDoObj *from = self.todoList[fromIndexPath.row];
    ToDoObj *to = self.todoList[toIndexPath.row];
    [self.todoList replaceObjectAtIndex:fromIndexPath.row withObject:to];
    [self.todoList replaceObjectAtIndex:toIndexPath.row withObject:from];
}


// Support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for ( ToDoObj *todoObj in self.todoList ){
        if (todoObj.isEditMode){
            todoObj.isEditMode = NO;
        }
    }
    
    self.editingRowIndex = indexPath.row;
    ToDoObj *todoObj = self.todoList[indexPath.row];
    todoObj.isEditMode = YES;
    ToDoCell *cell = (ToDoCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell switchToEditMode];
    [cell.titleText becomeFirstResponder];
}

#pragma MArk - TextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString* str = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ( [str isEqualToString:@""] ){
        [self.todoList removeObjectAtIndex:self.editingRowIndex];
    } else {
        ToDoObj* todoObj = self.todoList[self.editingRowIndex];
        todoObj.title = textField.text;
        todoObj.isEditMode = NO;
    }
    
    [self.view endEditing:YES];
    [self.tableView reloadData];
    return YES;
}

@end
