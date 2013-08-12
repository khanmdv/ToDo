//
//  AppDelegate.m
//  ToDo
//
//  Created by Mohtashim Khan on 8/12/13.
//  Copyright (c) 2013 YAHOO. All rights reserved.
//

#import "AppDelegate.h"
#import "ToDoObj.h"

@implementation AppDelegate

@synthesize todoViewController;

-(NSString*) getDcumentsFolderLocation
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

-(void) saveTodoListToDisk
{
    NSArray *todoListObjs = [self.todoViewController getTodoList];
    if ([todoListObjs count] > 0 ){
        NSMutableArray* todoList = [NSMutableArray arrayWithCapacity:[todoListObjs count]];
        for ( ToDoObj *obj in todoListObjs ){
            [todoList addObject:obj.title];
        }
        NSString *todoFile = [NSString stringWithFormat:@"%@/todo.plist", [self getDcumentsFolderLocation]];
        [todoList writeToFile:todoFile atomically:YES];
    }
}

-(void) loadTodoListFromDisk
{
    NSString *todoFile = [NSString stringWithFormat:@"%@/todo.plist", [self getDcumentsFolderLocation]];
    if ( [[NSFileManager alloc] fileExistsAtPath:todoFile] ){
        NSArray *todoList = [NSArray arrayWithContentsOfFile:todoFile];
        
        NSMutableArray *todoListObjs = [NSMutableArray arrayWithCapacity:[todoList count]];
        if ( [todoList count] > 0 ){
            for ( NSString* title in todoList ){
                [todoListObjs addObject:[[ToDoObj alloc] initWithTitle:title andEditMode:NO]];
            }
        }
        [self.todoViewController setTodoListOnLoad:[NSArray arrayWithArray:todoListObjs]];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Add the ToDo View Controller as Root wrapped by a UINav Controller
    self.todoViewController = [[ToDoViewController alloc] init];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:self.todoViewController];
    
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self saveTodoListToDisk];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Save the TODO list when app goes in background
    [self saveTodoListToDisk];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self loadTodoListFromDisk];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveTodoListToDisk];
}

@end
