//
//  MTPostsTableViewController.h
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTPostsTableViewController : UITableViewController

// Michael mentioned this should be a UIViewController
//@interface MTPostsTableViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *posts;

@end
