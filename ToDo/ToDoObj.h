//
//  ToDoObj.h
//  ToDo
//
//  Created by Mohtashim Khan on 8/12/13.
//  Copyright (c) 2013 YAHOO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoObj : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) BOOL isEditMode;

-(id) initWithTitle : (NSString*) title andEditMode: (BOOL) isEditMode;

@end
