//
//  CommonLibary.h
//  SiderBarApp
//
//  Created by ignis2 on 27/06/14.
//  Copyright (c) 2014 ignis2. All rights reserved.
//

#import <Foundation/Foundation.h>

#define COLORMAKE(x,y,z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1]

@interface CommonLibary : NSObject
+(UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size;
+(UIImage *)imageWithImage:(UIImage *)image;
void showAlert(NSString * title,NSString * message);
@end
