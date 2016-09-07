//
//  PullDownView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/11.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "PullDownView.h"
#import "UIView+Frame.h"
#import "Config.h"
@implementation PullDownView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:RGB_COLOR(@"#C9C9C9")];
        [self CreatUI];
    }
    return  self;
}

-(void)CreatUI
{
    NSArray * array= @[@"搜全部",@"搜微博",@"搜人"];
    for(int i= 0;i< array.count;i++)
    {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(2, (1+i)* 2 + 25* i, self.width - 4, 25)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(HandelBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if(i == 0)
        {
            [btn setBackgroundColor:RGB_COLOR(@"#E4E4E4")];
        }
    }
    CGRect frame = self.frame;
    frame.size.height = (25 +2) * array.count +2;
    self.frame = frame;
}
-(void)HandelBtnSelected:(UIButton *)btn
{
    [self RecoveryBtn];
    [self.delegate SelectedPullDownViewBtn:btn];

}
-(void)RecoveryBtn
{
    for (UIButton * btn in self.subviews) {
        [btn setBackgroundColor:[UIColor clearColor]];
    }
}


@end
