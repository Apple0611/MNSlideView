//
//  MNTopScrollView.m
//  WebViewTest
//
//  Created by downjoymac on 14-3-14.
//  Copyright (c) 2014年 Apple0611. All rights reserved.
//

#import "MNTopScrollView.h"

//第一个button距离控件最左边的间隙
#define FIRST_BUTTON_INTERVAL 16
//相邻button之间间隙
#define BUTTON_INTERVAL 32
//每个button的宽度
#define BUTTON_WIDTH 32
//每个button的高度
#define BUTTON_HEIGHT 41
//控件frame
#define SLIDE_FRAME CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width-45, 44)
//被选中button底部蓝色宽度
#define BUTTON_BOTTOM_WIDTH 32
//被选中button底部蓝色高度
#define BUTTON_BOTTOM_HIGHT 3


@implementation MNTopScrollView{
    
}

//static CGRect frame;
//
//+(MNTopScrollView *)sharedMNTopScrollView:(CGRect)viewFrame{
//    static MNTopScrollView *_sharedMNTopScrollView;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken,^{
//        frame=viewFrame;
//        _sharedMNTopScrollView=[[self alloc]initWithFrame:frame];
//    });
//    return _sharedMNTopScrollView;
//}

-(void)dealloc{
    self.selectedBtnImage=nil;
    self.btnOrginXArr=nil;
    [super dealloc];
}

-(id)initWithTopScrollViewFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.delegate=self;
        _preSelectedBtnTag=0;
        _currentSelectedBtnTag=0;    //初始选中的按钮为编号0
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        self.pagingEnabled=YES;
        [self setBackgroundColor:[UIColor colorWithRed:0xed/255.0 green:0xed/255.0 blue:0xed/255.0 alpha:1.0]];
        [self initWithFrame:frame];
        _btnOrginXArr=[[NSMutableArray alloc]init];
        UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 43.5, 320, 0.5)];
        [lineImageView setBackgroundColor:[UIColor colorWithRed:0xcc/255.0 green:0xcc/255.0 blue:0xcc/255.0 alpha:1.0]];
        [self addSubview:lineImageView];
        
    }
    return self;
}

-(void)initWithButton:(NSMutableArray *)arrName{
    for (int i=0; i<[arrName count]; i++) {
        UIButton *button=[[[UIButton alloc]init] autorelease];
        [button setTag:i];
        button.frame=CGRectMake(FIRST_BUTTON_INTERVAL+i*(BUTTON_WIDTH+BUTTON_INTERVAL), 0, BUTTON_WIDTH, BUTTON_HEIGHT);
        [button setTitle:[arrName objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitle:[arrName objectAtIndex:i] forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setTitleColor:[UIColor colorWithRed:0x00/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0x00/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(setButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_btnOrginXArr addObject:@(FIRST_BUTTON_INTERVAL+i*(BUTTON_WIDTH+BUTTON_INTERVAL))];
        [self addSubview:button];
    }
    float contentSizeWidth=[[_btnOrginXArr objectAtIndex:[arrName count]-1] floatValue]+BUTTON_WIDTH+FIRST_BUTTON_INTERVAL;
    [self setContentSize:CGSizeMake(contentSizeWidth, SLIDE_FRAME.size.height)];
    _selectedBtnImage=[[UIImageView alloc]initWithFrame:CGRectMake(FIRST_BUTTON_INTERVAL, BUTTON_HEIGHT, BUTTON_BOTTOM_WIDTH, BUTTON_BOTTOM_HIGHT)];
    [_selectedBtnImage setBackgroundColor:[UIColor colorWithRed:0x00/255.0 green:0x72/255.0 blue:0xff/255.0 alpha:1.0]];
    [self addSubview:_selectedBtnImage];
     
}

-(void)setButtonSelected:(UIButton *)sender{
    if (sender.tag!=_preSelectedBtnTag) {
        _currentSelectedBtnTag=sender.tag;
        [UIView animateWithDuration:0.2 animations:^{
            [_selectedBtnImage setFrame:CGRectMake([[_btnOrginXArr objectAtIndex:sender.tag] floatValue], BUTTON_HEIGHT, BUTTON_BOTTOM_WIDTH, BUTTON_BOTTOM_HIGHT)];
        } completion:^(BOOL finish){
            if (_topDelegate && [_topDelegate respondsToSelector:@selector(scrollToCurrentPageContentOffset:animation:)]) {
                [_topDelegate scrollToCurrentPageContentOffset:CGPointMake(sender.tag*[UIScreen mainScreen].bounds.size.width, 0) animation:YES];
            }
            _preSelectedBtnTag=sender.tag;
        }];
        UIButton *btn=(UIButton *)[self viewWithTag:sender.tag];
        [self resetCurrentContentViewOffSet:btn];
    }
}

-(void)setSelectedIndex:(NSInteger )index
{
    UIButton *button=(UIButton *)[self viewWithTag:index];
    [self setButtonSelected:button];
}

-(void)resetCurrentContentViewOffSet:(UIButton *)sender{
    float midPosX=[self getBtnImageMidPosOriginX];
    float originX=[[_btnOrginXArr objectAtIndex:_currentSelectedBtnTag]floatValue];
    if (originX<=midPosX) {
        [self scrollRectToVisible:self.frame animated:YES];
    }else if (originX>midPosX && originX<self.contentSize.width-midPosX){
        [self scrollRectToVisible:CGRectMake(originX-midPosX, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    }else{
        [self scrollRectToVisible:CGRectMake(self.contentSize.width-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    }
}

-(float)getBtnImageMidPosOriginX{
    float midPosX=self.frame.size.width/2-BUTTON_WIDTH/2;
    return midPosX;
}


@end
