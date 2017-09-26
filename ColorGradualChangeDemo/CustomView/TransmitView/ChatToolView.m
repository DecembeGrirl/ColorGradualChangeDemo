//
//  TransmitBottomView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "ChatToolView.h"
#import "UIView+Frame.h"
#import "Config.h"
@implementation ChatToolView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self CreatView];
        _frame = frame;
    }
    return  self;
}

-(void)CreatView
{
    [self setBackgroundColor:RGB_COLOR(@"#FAFAFA")];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:view];
    _meanWhileCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_meanWhileCommentBtn setFrame:CGRectMake(5, 0, 100, 25)];
    [_meanWhileCommentBtn setTitle:@"同时评论" forState:UIControlStateNormal];
    [_meanWhileCommentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_meanWhileCommentBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [_meanWhileCommentBtn addTarget:self action:@selector(HandleMeanWhileBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_meanWhileCommentBtn];
    
    UIButton *shareRangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareRangeBtn setFrame:CGRectMake(self.width - 105, 0, 100, 25)];
    [shareRangeBtn setTitle:@"分享范围" forState:UIControlStateNormal];
    [shareRangeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [shareRangeBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [shareRangeBtn addTarget:self action:@selector(HandleShareRangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:shareRangeBtn];
    
    CGFloat btnWidth =30;
    CGFloat grap = (self.width - (30 * 5))/6;
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageBtn setFrame:CGRectMake(grap, view.bottom, btnWidth, btnWidth)];
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"message_more_pic"] forState:UIControlStateNormal];
    [imageBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [imageBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [imageBtn addTarget:self action:@selector(HandleImageBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:imageBtn];
    
    //@ 按钮
    UIButton *atBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [atBtn setFrame:CGRectMake(imageBtn.right + grap, imageBtn.top, btnWidth, imageBtn.height)];
    [atBtn setBackgroundImage:[UIImage imageNamed:@"empty_at"] forState:UIControlStateNormal];
    [atBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [atBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [atBtn addTarget:self action:@selector(HandleAtBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:atBtn];
    
    //井号 按钮
    UIButton *hashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [hashBtn setFrame:CGRectMake(atBtn.right + grap, imageBtn.top, btnWidth, imageBtn.height)];
    [hashBtn setBackgroundImage:[UIImage imageNamed:@"message_topic"] forState:UIControlStateNormal];
    [hashBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [hashBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [hashBtn addTarget:self action:@selector(HandleHashBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hashBtn];
    
    //表情按钮
    UIButton *faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [faceBtn setFrame:CGRectMake(hashBtn.right + grap, imageBtn.top, btnWidth, imageBtn.height)];
    [faceBtn setImage:[UIImage imageNamed:@"message_emotion_background"] forState:UIControlStateNormal];
    [faceBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [faceBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [faceBtn addTarget:self action:@selector(HandleFaceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:faceBtn];
    
    //+ 按钮
    UIButton *plushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [plushBtn setFrame:CGRectMake(faceBtn.right+ grap, imageBtn.top, btnWidth, imageBtn.height)];
    [plushBtn setBackgroundImage:[UIImage imageNamed:@"message_add_background"] forState:UIControlStateNormal];
    [plushBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [plushBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [plushBtn addTarget:self action:@selector(HandlePlushBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plushBtn];
}

-(void)ChangeFrame:(CGRect)frame
{
    CGRect tempFrame = _frame;
    tempFrame.origin.y = _frame.origin.y -frame.size.height;
    [UIView animateWithDuration:0.05 animations:^{
        [self setFrame:tempFrame];
    }];
}

#pragma selectedBtn

-(void)HandleMeanWhileBtn:(UIButton *)btn
{
    self.selectedMeanWhileCommentBtnBlock(self,btn);
}


-(void)HandleShareRangeBtn:(UIButton *)btn
{

}

-(void)HandleImageBtn:(UIButton *)btn
{
//    __weak typeof (self)weakSelf= self;
    self.selectedImageBtnBlock(self,btn);
}

-(void)HandleAtBtn:(UIButton *)btn
{
    self.selectedAtBtnBlock(self,btn);
}


-(void)HandleHashBtn:(UIButton *)btn
{
    self.selectedTopicBtnBlock(self,btn);
}

-(void)HandleFaceBtn:(UIButton *)btn
{
    self.selectedFaceBtnBlock(self,btn);
}

-(void)HandlePlushBtn:(UIButton *)btn
{
    self.selectedPlusBtnBlock(self,btn);
}
@end
