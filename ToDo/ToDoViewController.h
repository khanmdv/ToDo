//
//  ToDoViewController.h
//  ToDo
//
//  Created by Mohtashim Khan on 8/12/13.
//  Copyright (c) 2013 YAHOO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoViewController : UITableViewController <UITextFieldDelegate>

-(NSArray*) getTodoList;
-(void) setTodoListOnLoad : (NSArray*) todoList;

@end
