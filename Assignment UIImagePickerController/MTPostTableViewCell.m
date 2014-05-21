//
//  MTPostTableViewCell.m
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import "MTPostTableViewCell.h"
#import "MTPost.h"

@implementation MTPostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPost:(MTPost *)post
{
    _post = post;
    
    _userNameLabel.text = _post.userName;
    _titleLabel.text = _post.title;
    _contentLabel.text = _post.content;
    _timeStampLabel.text = [_post stringFromDate:_post.timeStamp];
    _pictureImageView.image = _post.picture;
    
    [[self titleLabel] setFont:[UIFont fontWithName:@"TrebuchetMS" size:15]];
    [[self titleLabel] setTextAlignment:NSTextAlignmentLeft];
    [[self titleLabel] setTextColor:[UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];
    
    [[self userNameLabel] setFont:[UIFont fontWithName:@"TrebuchetMS-Italic" size:11]];
    [[self userNameLabel] setTextAlignment:NSTextAlignmentLeft];
    [[self userNameLabel] setTextColor:[UIColor colorWithRed:80.0/255.0f green:80.0/255.0f blue:80.0/255.0f alpha:1.0f]];
    
    [[self timeStampLabel] setFont:[UIFont fontWithName:@"TrebuchetMS-Italic" size:11]];
    [[self timeStampLabel] setTextAlignment:NSTextAlignmentLeft];
    [[self timeStampLabel] setTextColor:[UIColor colorWithRed:200.0/255.0f green:200.0/255.0f blue:200.0/255.0f alpha:1.0f]];
    
    [[self contentLabel] setFont:[UIFont fontWithName:@"TrebuchetMS" size:12.5]];
    [[self contentLabel] setTextAlignment:NSTextAlignmentLeft];
    
    _pictureImageView.layer.cornerRadius = _pictureImageView.frame.size.width / 2.0;
    [_pictureImageView setClipsToBounds:YES];
//    [_pictureImageView.layer setMasksToBounds:YES];

}

@end
