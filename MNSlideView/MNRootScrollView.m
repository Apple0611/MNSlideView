//
//  MNRootScrollView.m
//  WebViewTest
//
//  Created by downjoymac on 14-3-14.
//  Copyright (c) 2014年 Apple0611. All rights reserved.
//

#import "MNRootScrollView.h"


@implementation MNRootScrollView{
}


//+(MNRootScrollView *)sharedMNRootScrollView{
//    static MNRootScrollView *_sharedMNRootScrollView;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedMNRootScrollView=[[self alloc]initWithFrame:CGRectMake(0, 50, 320, 400)];
//    });
//    return _sharedMNRootScrollView;
//}

-(void)dealloc{
    self.contentScrollView=nil;
    self.topScrollView=nil;
    self.viewNameArr=nil;
    [super dealloc];
}

-(id)initWithViewFrame:(CGRect)rect topScrollViewFrame:(CGSize)topsize topScrollViewName:(NSMutableArray *)topName{
    self=[super initWithFrame:rect];
    if (self) {
        _topScrollView=[[MNTopScrollView alloc]initWithTopScrollViewFrame:CGRectMake(0, 0, topsize.width, topsize.height)];
        [_topScrollView initWithButton:topName];
        [_topScrollView setTopDelegate:self];
        float height=rect.size.height-topsize.height;
        _contentScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, topsize.height, [UIScreen mainScreen].bounds.size.width, height)];
        _contentScrollView.delegate=self;
        _contentScrollView.contentOffset=CGPointMake(0, 0);
        _contentScrollView.pagingEnabled=YES;
        [self addSubview:_topScrollView];
        [self addSubview:_contentScrollView];
    }
    return self;
}

-(void)addSubViewsToScrollView:(NSMutableArray *)subViewArray{
    _contentScrollView.contentSize=CGSizeMake(_contentScrollView.frame.size.width*[subViewArray count], _contentScrollView.frame.size.height);
    for (int i=0; i<[subViewArray count]; i++) {
        UIView *view=[subViewArray objectAtIndex:i];
        [view setFrame:CGRectMake(i*_contentScrollView.frame.size.width, 0, _contentScrollView.frame.size.width, _contentScrollView.frame.size.height)];
        [_contentScrollView addSubview:view];
    }
}

-(void)setViewNameArr:(NSMutableArray *)viewNameArr{
    _viewNameArr=[[[NSMutableArray alloc]initWithArray:viewNameArr]autorelease];
}

-(void)adjustTopScrollViewButton:(UIScrollView *)scrollView{
    NSInteger currentPage=[self getViewPageNum];
    UIButton *button=(UIButton *)[_topScrollView viewWithTag:currentPage];
    [_topScrollView setButtonSelected:button];
    [_topScrollView setCurrentSelectedBtnTag:currentPage];
    [_topScrollView resetCurrentContentViewOffSet:button];
}

-(NSInteger)getViewPageNum{
    return (NSInteger)_contentScrollView.contentOffset.x/320;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self adjustTopScrollViewButton:scrollView];
}


-(void)scrollToCurrentPageContentOffset:(CGPoint)point animation:(BOOL)animation{
    [_contentScrollView setContentOffset:point animated:NO];
}

@end
