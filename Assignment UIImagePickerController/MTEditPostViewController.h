//
//  MTEditPostViewController.h
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPost.h"

@protocol MTEditPostViewControllerDelegate <NSObject>

@optional

- (void)updateTable;

@end

@interface MTEditPostViewController : UIViewController

@property (nonatomic, unsafe_unretained) id <MTEditPostViewControllerDelegate> editPostDelegate;

@property (weak, nonatomic) IBOutlet UITextField *editUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *editTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *editContentTextField;

@property (nonatomic, strong) MTPost *post;

- (IBAction)saveEditPost:(UIBarButtonItem *)sender;

- (IBAction)cancelEditPost:(UIBarButtonItem *)sender;

@end
