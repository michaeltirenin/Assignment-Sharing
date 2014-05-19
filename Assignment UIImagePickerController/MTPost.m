//
//  MTPost.m
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import "MTPost.h"

@implementation MTPost

- (NSString *)stringFromDate:(NSDate *)sender
{
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    
    return dateString;
}

@end
