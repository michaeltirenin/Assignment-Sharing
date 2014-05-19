//
//  UIColor+Manage.m
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import "UIColor+Manage.h"

@implementation UIColor (Manage)

// I added some constraints to keep within a palette and never go too dark or too light
+ (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0);
    if (hue > 0.75) {
        hue = hue / 1.75;
    } else if (hue < 0.4) {
        hue = hue * 1.75;
    }
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    if (saturation > 0.7) {
        saturation = saturation / 2.0;
    }
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    if (brightness < 0.4) {
        brightness = brightness * 1.5;
    } else if (brightness > 0.8) {
        brightness = brightness / 1.5;
    }
    //    NSLog(@"%f, %f, %f", hue, saturation, brightness);
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
    
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
