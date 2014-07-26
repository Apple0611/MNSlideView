//
//  MNRootScrollView.h
//  WebViewTest
//
//  Created by downjoymac on 14-3-14.
//  Copyright (c) 2014年 Apple0611. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNTopScrollView.h"

@interface MNRootScrollView : UIView<UIScrollViewDelegate,MNTopScrollAdjustRootScrollDelegate>

@property(nonatomic,retain)UIScrollView *contentScrollView;

@property(nonatomic,retain)MNTopScrollView *topScrollView;

@property(nonatomic,retain)NSMutableArray *viewNameArr;

@property(nonatomic)float viewContentOffSet;


-(id)initWithViewFrame:(CGRect)rect topScrollViewFrame:(CGSize)topsize topScrollViewName:(NSMutableArray *)topName;

-(void)addSubViewsToScrollView:(NSMutableArray *)subViewArray;

-(void)setViewNameArr:(NSMutableArray *)viewNameArr;

-(void)adjustTopScrollViewButton:(UIScrollView *)scrollView;

-(NSInteger)getViewPageNum;

@end
