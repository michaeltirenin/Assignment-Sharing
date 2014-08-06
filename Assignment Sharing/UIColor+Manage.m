//
//  UIColor+Manage.m
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import "UIColor+Manage.h"

@implementation UIColor (Manage)

+ (UIColor *)randomColor
{
    CGFloat r = arc4random() % 256 / 256.0;
    CGFloat g = arc4random() % 256 / 256.0;
    CGFloat b = arc4random() % 256 / 256.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

+ (UIColor *)theOtherColor
{
    CGFloat r = arc4random() % 256 / 256.0;
    CGFloat g = arc4random() % 256 / 256.0;
    CGFloat b = arc4random() % 256 / 256.0;
        
    return [UIColor colorWithRed:r green:g blue:b alpha:0.25];
}

+ (UIColor *)lightenColor:(UIColor *)color byAmount:(CGFloat)amount
{
    CGFloat hue, saturation, brightness, alpha;
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
    {
        brightness += (amount-1.0);
        brightness = MAX(MIN(brightness, 1.0), 0.0);
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    }
    
    CGFloat white;
    if ([color getWhite:&white alpha:&alpha])
    {
        white += (amount-1.0);
        white = MAX(MIN(white, 1.0), 0.0);
        return [UIColor colorWithWhite:white alpha:alpha];
    }
    
    return nil;
}

@end
