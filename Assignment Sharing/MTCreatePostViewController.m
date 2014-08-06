//
//  MTCreatePostViewController.m
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import "MTCreatePostViewController.h"
#import "MTPost.h"
#import "UIImage+ImageEffects.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreImage/CoreImage.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
//#import <MobileCoreServices/MobileCoreServices.h>

@interface MTCreatePostViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *createPictureImageView;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (strong, nonatomic) UITapGestureRecognizer *tapBehavior;

@end

@implementation MTCreatePostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    _createPictureImageView.userInteractionEnabled = YES;
    [_createPictureImageView addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// .delegate allows for keyboard resignation
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _createUserNameTextField.delegate = self;
    _createTitleTextField.delegate = self;
    _createContentTextField.delegate = self;
}

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
    post.picture = _createPictureImageView.image;
 
    [self saveImageToLibrary:post.picture];
   
    [self.createPostDelegate addObject:post];
}

- (IBAction)cancelNewPost:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        //        editedImage = [editedImage applyTintEffectWithColor:[UIColor lightGrayColor]]; //example from John
        _createPictureImageView.image = editedImage;
        // creates circle "mask"
        _createPictureImageView.layer.cornerRadius = _createPictureImageView.frame.size.width / 2.0;
        [_createPictureImageView setClipsToBounds:YES];
        //        [self saveImageToLibrary:editedImage];
    }];
}

#pragma mark - UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Camera"] || [[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Replace using Camera"]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Photo Library"] || [[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Replace from Photo Library"]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Add B&W Photo Effect"]) {
        [self applyCIFilter:_createPictureImageView.image];
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Delete Photo"]) {
        _createPictureImageView.image = nil;
    }
}

// Selection via bar button item
- (IBAction)showImagePicker:(UIBarButtonItem *)sender
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    
    if (_createPictureImageView.image == nil) {
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
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Photo Options"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Cancel"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"Replace from Photo Library", @"Replace using Camera", @"Add B&W Photo Effect", @"Delete Photo", nil];
            [actionSheet showFromBarButtonItem:sender animated:YES];
            
        // with image, NO camera only photo library available
        } else {
            _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Photo Options"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Cancel"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"Replace from Photo Library", @"Add B&W Photo Effect", @"Delete Photo", nil];
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
    _createPictureImageView.image = filteredImage;
    
    CGImageRelease(cgImage);  // added by Michael due to leak
//    [self saveImageToLibrary:filteredImage];
}

// Selection via image tap
-(void)tapDetected
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    
    if (_createPictureImageView.image) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Photo Options"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Replace from Photo Library", @"Replace using Camera", @"Add B&W Photo Effect", @"Delete Photo", nil];
//        [actionSheet showFromToolbar:self.navigationController.toolbar];
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    [actionSheet showInView:window];

    }
}

- (IBAction)postToTwitter:(UIBarButtonItem *)sender
{
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];

    [tweetSheet setInitialText:_createContentTextField.text];
    [tweetSheet addURL:[NSURL URLWithString:@"http://www.stickwork.net"]];
    [tweetSheet addImage:_createPictureImageView.image];

    [self presentViewController:tweetSheet animated:YES completion:nil];
}

- (IBAction)postToFacebook:(UIBarButtonItem *)sender
{
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
    [controller setInitialText:_createContentTextField.text];
    [controller addURL:[NSURL URLWithString:@"http://www.stickwork.net"]];
    [controller addImage:_createPictureImageView.image];

    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)postToIMessage:(UIBarButtonItem *)sender
{
    MFMessageComposeViewController *messageComposer = [[MFMessageComposeViewController alloc] init];
    messageComposer.messageComposeDelegate = self;
    
    NSMutableString *messageBody = [NSMutableString string];
    [messageBody appendString:_createContentTextField.text];
    [messageBody appendString:@"\n\nhttp://www.stickwork.net"];
    
    [messageComposer setBody:messageBody];
        
    [messageComposer addAttachmentData:UIImagePNGRepresentation(_createPictureImageView.image) typeIdentifier:@"public.data" filename:[NSString stringWithFormat:@"%@blogimage.png", _createTitleTextField.text]];
    
    [self presentViewController:messageComposer animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Message cancelled");
            break;
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send message!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
        case MessageComposeResultSent:
            NSLog(@"Message sent");
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)postToEmail:(UIBarButtonItem *)sender
{
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:_createTitleTextField.text];
    
    NSMutableString *mailBody = [NSMutableString string];
    [mailBody appendString:_createContentTextField.text];
    [mailBody appendString:@"\n\nhttp://www.stickwork.net"];
    
    [mailComposer setMessageBody:mailBody isHTML:NO];

    [mailComposer addAttachmentData:UIImagePNGRepresentation(_createPictureImageView.image) mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@blogimage.png", _createTitleTextField.text]];
    
    [self presentViewController:mailComposer animated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
