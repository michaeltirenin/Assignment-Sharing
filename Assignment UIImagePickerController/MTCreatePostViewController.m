//
//  MTCreatePostViewController.m
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import "MTCreatePostViewController.h"
#import "MTPost.h"

@interface MTCreatePostViewController () <UITextFieldDelegate>

@end

@implementation MTCreatePostViewController

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
    // Do any additional setup after loading the view.
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
    
    _createUserNameTextField.delegate = self;
    _createTitleTextField.delegate = self;
    _createContentTextField.delegate = self;
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

- (IBAction)publishNewPost:(id)sender
{
    MTPost *post = [[MTPost alloc] init];
    post.userName = _createUserNameTextField.text;
    post.title = _createTitleTextField.text;
    post.content = _createContentTextField.text;
    post.timeStamp = [NSDate date];
    
    [self.createPostDelegate addObject:post];
}

- (IBAction)cancelNewPost:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
