//
//  CommonLibary.m
//  SiderBarApp
//
//  Created by ignis2 on 27/06/14.
//  Copyright (c) 2014 ignis2. All rights reserved.
//

#import "CommonLibary.h"

@implementation CommonLibary
+(UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}
+(UIImage *)imageWithImage:(UIImage *)image
{
    return [self imageWithImage:image convertToSize:CGSizeMake(100,100)];
}

void showAlert(NSString * title,NSString * message)
{
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}
@end
