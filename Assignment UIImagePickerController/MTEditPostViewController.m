//
//  MTEditPostViewController.m
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import "MTEditPostViewController.h"
#import "MTPost.h"

@interface MTEditPostViewController () <UITextFieldDelegate>

@end

@implementation MTEditPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _editUserNameTextField.text = _post.userName;
    _editTitleTextField.text = _post.title;
    _editContentTextField.text = _post.content;
    
//    NSLog(@"%@", _postCell.contentView.backgroundColor);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// .delegate allows for keyboard resignation
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _editUserNameTextField.delegate = self;
    _editTitleTextField.delegate = self;
    _editContentTextField.delegate = self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// UITextFieldDelegate protocol method; resigns keyboard when "return" is tapped
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)saveEditPost:(UIBarButtonItem *)sender
{
    _post.userName = _editUserNameTextField.text;
    _post.title = _editTitleTextField.text;
    _post.content = _editContentTextField.text;
    
    [self.editPostDelegate updateTable];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)cancelEditPost:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
