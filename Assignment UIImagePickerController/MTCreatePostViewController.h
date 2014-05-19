//
//  MTCreatePostViewController.h
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPost.h"

@protocol MTCreatePostViewControllerDelegate <NSObject>

@optional

- (void)addObject:(MTPost *)post;

@end

@interface MTCreatePostViewController : UIViewController

@property (nonatomic, unsafe_unretained) id <MTCreatePostViewControllerDelegate> createPostDelegate;

@property (weak, nonatomic) IBOutlet UITextField *createUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *createTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *createContentTextField;

- (IBAction)publishNewPost:(id)sender;

- (IBAction)cancelNewPost:(UIBarButtonItem *)sender;

@end
