//
//  ViewController.m
//  MNSlideView
//
//  Created by downjoymac on 14-7-18.
//  Copyright (c) 2014年 Apple0611. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)dealloc{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *topArray=[[NSMutableArray alloc]initWithObjects:@"111",@"222",@"333",@"444",@"555",@"666",@"777", nil];
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-44)];
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(320*1, 0, 320, self.view.frame.size.height-44)];
    [view2 setBackgroundColor:[UIColor greenColor]];
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(320*2, 0, 320, self.view.frame.size.height-44)];
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(320*3, 0, 320, self.view.frame.size.height-44)];
    [view4 setBackgroundColor:[UIColor redColor]];
    UIView *view5=[[UIView alloc]initWithFrame:CGRectMake(320*4, 0, 320, self.view.frame.size.height-44)];
    UIView *view6=[[UIView alloc]initWithFrame:CGRectMake(320*5, 0, 320, self.view.frame.size.height-44)];
    [view6 setBackgroundColor:[UIColor purpleColor]];
    UIView *view7=[[UIView alloc]initWithFrame:CGRectMake(320*6,0, 320, self.view.frame.size.height-44)];
    NSMutableArray *viewArr=[[NSMutableArray alloc]initWithObjects:view1,view2,view3,view4,view5,view6,view7, nil];
    MNRootScrollView *rootScrollView=[[MNRootScrollView alloc]initWithViewFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) topScrollViewFrame:CGSizeMake(320, 44) topScrollViewName:topArray];
    [rootScrollView addSubViewsToScrollView:viewArr];
    [self.view addSubview:rootScrollView];
    [topArray release];
    [rootScrollView release];
    [viewArr release];
    [view1 release];
    [view2 release];
    [view3 release];
    [view4 release];
    [view5 release];
    [view6 release];
    [view7 release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
