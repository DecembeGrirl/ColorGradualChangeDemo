//
//  BlurEffectMenu.m
//  joinup_iphone
//
//  Created by shen_gh on 16/2/1.
//  Copyright © 2016年 com.joinup. All rights reserved.
//

#import "BlurEffectMenu.h"

@implementation BlurEffectMenuItem

@end


@interface BlurEffectMenu ()

@end

@implementation BlurEffectMenu

- (instancetype)initWithMenus:(NSArray *)menus{
    self=[super init];
    if (self) {
        self.menuItemArr=menus;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    //手势
    [self gesture];
    
    //布局View
    [self setUpView];
}

- (void)gesture{
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapOnBackground)]];
    
    UISwipeGestureRecognizer *swipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didTapOnBackground)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipeGesture];
}

#pragma mark - setUpView
- (void)setUpView{
    //毛玻璃
    UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [visualEffectView setFrame:self.view.bounds];
    [self.view addSubview:visualEffectView];
    
    //三列
    NSInteger totalloc=3;
    CGFloat appvieww=80;
    CGFloat appviewh=80;
    CGFloat margin=(self.view.frame.size.width-totalloc*appvieww)/(totalloc+1);
    
    for (NSInteger i= self.menuItemArr.count-1; i>=0; i--) {
        NSInteger row=i/totalloc;//行号
        NSInteger loc=i%totalloc;//列号
        row= row == 0?1:0;
        CGFloat appviewx=margin+(margin+appvieww)*loc;
        CGFloat appviewy=self.view.frame.size.height - 200-(50+appviewh)*row;
        //button
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(appviewx, self.view.frame.size.height + 300, appvieww, appviewh)];
        [button setTag:i];
        [button addTarget:self action:@selector(itemBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        //label
        UILabel *label=[[UILabel alloc]init];
        [label setFrame:CGRectMake(appviewx, button.frame.origin.y+button.bounds.size.height+5, appvieww, 25)];
        [label setTextColor:[UIColor grayColor]];
        [label setFont:[UIFont systemFontOfSize:14.0]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTag:i];
        [self.view addSubview:label];
        
        BlurEffectMenuItem *item=self.menuItemArr[i];
        item.index = i;
        [button setImage:item.icon forState:UIControlStateNormal];
        [label setText:item.title];
        
        //Spring Animation
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
            [UIView animateWithDuration:1.f delay:(0.2-0.02*i) usingSpringWithDamping:1.0f initialSpringVelocity:15.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                button.frame = CGRectMake(appviewx, appviewy, appvieww,appviewh);
                [label setFrame:CGRectMake(appviewx, button.frame.origin.y+button.bounds.size.height+5, appvieww, 25)];
            } completion:^(BOOL finished) {
            }];
        });
    }
    
   _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    [_bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_bottomView];
    _myCancleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_myCancleImageView setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"]];
    [_myCancleImageView setCenter:CGPointMake(self.view.center.x, _bottomView.center.y)];
    [self.view addSubview:_myCancleImageView];
}

#pragma mark - Event
- (void)didTapOnBackground{
    //点击空白处，dismiss
//    [self customTopAnimation];
    [self cancleImageAnimal];
    [self customBottomAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        if (_delegate&&[_delegate respondsToSelector:@selector(blurEffectMenuDidTapOnBackground:)]) {
            [_delegate blurEffectMenuDidTapOnBackground:self];
        }
    });
}

- (void)itemBtnClicked:(UIButton *)sender{
    //点击按钮缩放代码
    [UIView animateWithDuration:0.25 animations:^{
        sender.transform=CGAffineTransformMakeScale(1.7,1.7);
    }];
    //button dismiss动画  Spring Animation
//    [self customTopAnimation];
    [self cancleImageAnimal];
    [self customBottomAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(blurEffectMenu:didTapOnItem:)]) {
            [_delegate blurEffectMenu:self didTapOnItem:self.menuItemArr[sender.tag]];
        }
    });
}

#pragma mark - UIView animation
//Spring Animation
- (void)customTopAnimation{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn=(UIButton *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
                [UIView animateWithDuration:1.f delay:0.02*(btn.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    btn.frame = CGRectMake(btn.frame.origin.x, -300, btn.frame.size.width,btn.frame.size.height);
                } completion:^(BOOL finished) {
                }];
            });
        }
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label=(UILabel *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
                [UIView animateWithDuration:1.f delay:0.02*(label.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [label setTextColor:[UIColor clearColor]];
                } completion:^(BOOL finished) {
                }];
            });
        }
    }
}

- (void)customBottomAnimation{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn=(UIButton *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                //UIView animate动画:仿微博弹出添加按钮,从底部弹到指定位置
                [UIView animateWithDuration:1.f delay:0.02*(btn.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    btn.frame = CGRectMake(btn.frame.origin.x,self.view.frame.size.height, btn.frame.size.width,btn.frame.size.height);
                } completion:^(BOOL finished) {
                }];
            });
        }
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label=(UILabel *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                //UIView animate动画:仿微博弹出添加按钮,从底部弹到指定位置
                [UIView animateWithDuration:1.f delay:0.02*(label.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [label setTextColor:[UIColor clearColor]];
                } completion:^(BOOL finished) {
                }];
            });
        }
    }
}
-(void)cancleImageAnimal
{
    [UIView animateWithDuration:0.3 animations:^{
        _myCancleImageView.transform =CGAffineTransformMakeRotation(-M_PI_2);
        [_bottomView setBackgroundColor:[UIColor clearColor]];
    }];
}
@end
