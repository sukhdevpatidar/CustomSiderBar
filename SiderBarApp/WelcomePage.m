//
//  WelcomePage.m
//  SiderBarApp
//
//  Created by ignis2 on 27/06/14.
//  Copyright (c) 2014 ignis2. All rights reserved.
//

#import "WelcomePage.h"
#import "CommonLibary.h"

@interface WelcomePage ()
{
    NSMutableArray * contentArray;
    BOOL isOpen;
    __block CGFloat lastPosition,viewLst;
}
@end

@implementation WelcomePage
@synthesize frontView;
@synthesize backGroundTable;
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    contentArray=[[NSMutableArray alloc]init];
    isOpen=NO;
    [self customizeView];
    //Put Contents in array
    
    [contentArray addObject:@"Contents"];
}
-(void)customizeView
{
    [self.tabBar removeFromSuperview];
    
    //Customize Background view
    
    backGroundTable=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 212, CGRectGetHeight(self.view.frame))];
    
    backGroundTable.backgroundColor=[UIColor grayColor];
    UILabel * tabTitleView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(backGroundTable.frame), 40.0f)];
    tabTitleView.textAlignment=NSTextAlignmentCenter;
    tabTitleView.backgroundColor= COLORMAKE(59, 51, 48);
    tabTitleView.attributedText=[[NSAttributedString alloc]initWithString:@"SIDE BAR TITLE" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [backGroundTable addSubview:tabTitleView];
    // Set inner tableview
    
    [tableView addSubview:tabTitleView];
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(backGroundTable.frame.origin.x, backGroundTable.frame.origin.y+40, CGRectGetWidth(backGroundTable.frame), CGRectGetHeight(backGroundTable.frame))];
    tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [backGroundTable addSubview:tableView];

    [self.view addSubview:backGroundTable];
    
    //Customize FrontView view
   
    frontView=[[UIView alloc]initWithFrame:self.view.frame];
    frontView.backgroundColor=[UIColor blackColor];
    UIView * menuBar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frontView.frame), 40.0f)];
    menuBar.backgroundColor=COLORMAKE(161, 194, 63);
    UIButton * menuButton=[[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [menuButton addTarget:self action:@selector(menuButtonPress:) forControlEvents:UIControlEventTouchDown];
    CALayer * btLayer=menuButton.layer;
    btLayer.cornerRadius=15.0f;
    btLayer.borderColor=[UIColor blackColor].CGColor;
    btLayer.borderWidth=0.5f;
    btLayer.backgroundColor=[UIColor whiteColor].CGColor;
    UIImageView * imag=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    [imag setImage:[CommonLibary imageWithImage:[UIImage imageNamed:@"menu.png"] convertToSize:CGSizeMake(20, 20)]];
    [menuButton addSubview:imag];
    [menuBar addSubview:menuButton];
    [frontView addSubview:menuBar];
    [self.view addSubview:frontView];
   
    
    // Add long press gesture
    UIPanGestureRecognizer * panGesRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [panGesRecognizer setMinimumNumberOfTouches:1];
    [panGesRecognizer setMaximumNumberOfTouches:1];
    [frontView addGestureRecognizer:panGesRecognizer];
    
    
    
    /*
    UISwipeGestureRecognizer * rswipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
    [rswipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [frontView addGestureRecognizer:rswipeGesture];
    
    UISwipeGestureRecognizer * lswipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe)];
    [lswipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [frontView addGestureRecognizer:lswipeGesture];
     */

}
-(void)menuButtonPress:(id)sender
{
    [UIView animateKeyframesWithDuration:0.5f delay:0.01f options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        frontView.center=CGPointMake(isOpen?self.view.center.x:self.view.center.x+212,self.view.center.y);

    } completion:^(BOOL finished) {
        isOpen=!isOpen;
    }];
}
-(void)longPress:(id)sender
{
    
    UIPanGestureRecognizer * lngRec=(UIPanGestureRecognizer *)sender;
    UIGestureRecognizerState state=lngRec.state;
    CGPoint touchPoint=[lngRec locationInView:self.view];
    if (frontView.frame.origin.x <= 212  && frontView.frame.origin.x >= 0) {
        switch (state) {
            case UIGestureRecognizerStateBegan:
                viewLst=frontView.frame.origin.x;
                lastPosition=touchPoint.x;
                break;
            case UIGestureRecognizerStateChanged:
                @try {
                
                    if (touchPoint.x > lastPosition) {
                        if (touchPoint.x - lastPosition < 212 && frontView.frame.origin.x < 212) {
                            frontView.center=CGPointMake(self.view.center.x+(touchPoint.x -lastPosition),self.view.center.y);
                        }
                    }
                    else
                    {
                        if (self.view.center.x-(lastPosition - touchPoint.x) <= 212 && frontView.frame.origin.x > 0) {
                            frontView.center=CGPointMake(self.view.center.x-(lastPosition - touchPoint.x)+(( viewLst==212)?212:0),self.view.center.y);
                        }
                    }

                    NSLog(@"Frame Position: (%f,%f) : %f",touchPoint.x,lastPosition,frontView.frame.origin.x);
                
                }
                @catch (NSException *exception) {
                    NSLog(@"Exception %@",exception);
                }
                break;
            case UIGestureRecognizerStateEnded:
                if (frontView.frame.origin.x < 90)
                {
                    frontView.center=CGPointMake(self.view.center.x,self.view.center.y);
                    isOpen=NO;
                }
                else
                {
                    frontView.center=CGPointMake(self.view.center.x+212,self.view.center.y);
                    isOpen=YES;
                }
                NSLog(@"Frame Position: %f",frontView.frame.origin.x);
                break;
            default:
                break;
        }
    }else
    {
        if(state==UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled){
            if(frontView.frame.origin.x < 90)
            {
                frontView.center=CGPointMake(self.view.center.x,self.view.center.y);
                isOpen=NO;
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark - table delegate methods

-(UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[_tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableCell"];
    }
    /**
     *  Put whatever cell you want to put
     *
     */

    cell.backgroundColor=[UIColor darkGrayColor];
    cell.textLabel.attributedText=[[NSAttributedString alloc]initWithString:[contentArray objectAtIndex:indexPath.row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contentArray.count;
}

@end
