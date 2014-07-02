//
//  WelcomePage.h
//  SiderBarApp
//
//  Created by ignis2 on 27/06/14.
//  Copyright (c) 2014 ignis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomePage : UITabBarController <UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (strong,nonatomic) UIView *backGroundTable;
@property (strong,nonatomic) UIView *frontView;
@property (strong,nonatomic) UITableView *tableView;

@end
