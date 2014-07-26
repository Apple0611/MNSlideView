//
//  MNTopScrollView.h
//  WebViewTest
//
//  Created by downjoymac on 14-3-14.
//  Copyright (c) 2014年 Apple0611. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MNTopScrollAdjustRootScrollDelegate;

@interface MNTopScrollView : UIScrollView<UIScrollViewDelegate>{
}

@property(nonatomic,assign)id <MNTopScrollAdjustRootScrollDelegate> topDelegate;

@property(nonatomic,retain)UIImageView *selectedBtnImage;

@property(nonatomic,retain)NSMutableArray *btnOrginXArr;

@property(nonatomic)NSInteger preSelectedBtnTag;

@property(nonatomic)NSInteger currentSelectedBtnTag;


-(id)initWithTopScrollViewFrame:(CGRect)frame;

-(void)initWithButton:(NSMutableArray *)arrName;

-(void)setSelectedIndex:(NSInteger )index;

-(void)setButtonSelected:(UIButton *)sender;

-(void)resetCurrentContentViewOffSet:(UIButton *)sender;

-(float)getBtnImageMidPosOriginX;

@end

@protocol MNTopScrollAdjustRootScrollDelegate <NSObject>

-(void)scrollToCurrentPageContentOffset:(CGPoint)point animation:(BOOL)animation;

@end