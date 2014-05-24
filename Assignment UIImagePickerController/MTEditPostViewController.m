//
//  MTEditPostViewController.m
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import "MTEditPostViewController.h"
#import "MTPost.h"
#import "UIImage+ImageEffects.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreImage/CoreImage.h>

@interface MTEditPostViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *editPictureImageView;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@end

@implementation MTEditPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _editUserNameTextField.text = _post.userName;
    _editTitleTextField.text = _post.title;
    _editContentTextField.text = _post.content;
    _editPictureImageView.image = _post.picture;
    
    _editUserNameTextField.delegate = self;
    _editTitleTextField.delegate = self;
    _editContentTextField.delegate = self;
    
    _editPictureImageView.layer.cornerRadius = _editPictureImageView.frame.size.width / 2.0;
    [_editPictureImageView setClipsToBounds:YES];
    
//    NSLog(@"%@", _postCell.contentView.backgroundColor);
}

// .delegate allows for keyboard resignation
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    _post.picture = _editPictureImageView.image;
    
//    [self.editPostDelegate updateTable];
    
    [self saveImageToLibrary:_post.picture];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)cancelEditPost:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Camera"]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Photo Library"]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Add B&W Photo Effect"]) {
        [self applyCIFilter:_editPictureImageView.image];
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Delete Photo"]) {
        _editPictureImageView.image = nil;
    }
}

- (IBAction)showEditImagePicker:(UIBarButtonItem *)sender {
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    
    if (_editPictureImageView.image == nil) {
        // no image, camera and photo library available
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Photo Source"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Cancel"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"Photo Library", @"Camera", nil];
            [actionSheet showFromBarButtonItem:sender animated:YES];
        // no image, NO camera only photo library available
        } else {
            _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:_imagePicker animated:YES completion:nil];
        }
        
    } else {
        // with image, camera and photo library available
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Replace Photo, Add Filter, or Delete Photo"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Cancel" //cancel isn't working correclty?
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"Photo Library", @"Camera", @"Add B&W Photo Effect", @"Delete Photo", nil];
            [actionSheet showFromBarButtonItem:sender animated:YES];
        // with image, NO camera only photo library available
        } else {
            _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Replace Photo, Add Filter, or Delete Photo"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Cancel" //cancel isn't working correclty?
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"Photo Library", @"Add B&W Photo Effect", @"Delete Photo", nil];
            [actionSheet showFromBarButtonItem:sender animated:YES];
        }
    }
}

- (void)saveImageToLibrary:(UIImage *)editedImage
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary writeImageToSavedPhotosAlbum:editedImage.CGImage
                                    orientation:ALAssetOrientationUp
                                completionBlock:^(NSURL *assetURL, NSError *error) {
//                                    NSLog(@"Asset URL: %@", assetURL);
                                }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        //        editedImage = [editedImage applyTintEffectWithColor:[UIColor lightGrayColor]]; //example from John
        _editPictureImageView.image = editedImage;
        // creates circle "mask"
        _editPictureImageView.layer.cornerRadius = _editPictureImageView.frame.size.width / 2.0;
        [_editPictureImageView setClipsToBounds:YES];
//        [self saveImageToLibrary:editedImage];
    }];
}

- (void)applyCIFilter:(UIImage *)image
{
    CIContext *context = [CIContext contextWithOptions:nil];               // 1
    CIImage *newCIImage = [CIImage imageWithCGImage:image.CGImage];        // 2
    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectMono"];     // 3
    [filter setValue:newCIImage forKey:kCIInputImageKey];
    //    [filter setValue:@0.8f forKey:kCIInputIntensityKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];              // 4
    CGRect extent = [result extent];
    CGImageRef cgImage = [context createCGImage:result fromRect:extent];   // 5
    
    UIImage *filteredImage = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage); // added by Michael due to leak
    
    _editPictureImageView.image = filteredImage;
//    [self saveImageToLibrary:filteredImage];
}

@end
