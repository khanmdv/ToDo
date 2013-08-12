//
//  ToDoCell.h
//  ToDo
//
//  Created by Mohtashim Khan on 8/12/13.
//  Copyright (c) 2013 YAHOO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *titleText;

-(void) switchToReadOnly;
-(void) switchToEditMode;

@end
