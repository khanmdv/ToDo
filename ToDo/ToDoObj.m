//
//  ToDoObj.m
//  ToDo
//
//  Created by Mohtashim Khan on 8/12/13.
//  Copyright (c) 2013 YAHOO. All rights reserved.
//

#import "ToDoObj.h"

@implementation ToDoObj

@synthesize title=_title, isEditMode=_isEditMode;

-(id) initWithTitle : (NSString*) title andEditMode: (BOOL) isEditMode
{
    if ( self = [super init] ){
        self.title = title;
        self.isEditMode = isEditMode;
    }
    return self;
}

@end
