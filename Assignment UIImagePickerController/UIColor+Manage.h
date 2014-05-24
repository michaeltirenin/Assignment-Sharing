//
//  UIColor+Manage.h
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Manage)

// somehow doesn't work ... something in the term "randomColor"?
+ (UIColor *)randomColor;

+ (UIColor *)theOtherColor;

+ (UIColor *)lightenColor:(UIColor *)color byAmount:(CGFloat)amount;

@end
