//
//  ToDoCell.m
//  ToDo
//
//  Created by Mohtashim Khan on 8/12/13.
//  Copyright (c) 2013 YAHOO. All rights reserved.
//

#import "ToDoCell.h"

@implementation ToDoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialize the Elements
        self.titleText = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 231, 30)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 231, 21)];
        
        // Set Font
        [self.titleText setFont:[UIFont boldSystemFontOfSize:17.0]];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        
        // Set autoresizing mask
        [self.titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self.titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        
        // Add Main Label,textfield to Content View
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.titleText];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) switchToReadOnly
{
    self.titleLabel.text = self.titleText.text;
    [self.titleLabel setHidden:NO];
    [self.titleText setHidden:YES];
}

-(void) switchToEditMode
{
    self.titleText.text = self.titleLabel.text;
    [self.titleLabel setHidden:YES];
    [self.titleText setHidden:NO];
}

@end
