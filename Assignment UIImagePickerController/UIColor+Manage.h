//
//  UIColor+Manage.h
//  Assignment UIImagePickerController
//
//  Created by Michael Tirenin on 5/18/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Manage)

+ (UIColor *)randomColor;

+ (UIColor *)lightenColor:(UIColor *)color byAmount:(CGFloat)amount;

@end
