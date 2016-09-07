//
//  TransfFade.m
//  someTest
//
//  Created by 杨淑园 on 16/1/25.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "PushFadeTranst.h"
#import "MainTabBarController.h"
#import "ShowBigView.h"
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation PushFadeTranst

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    
//    MainTabBarController * maintabBarController = (MainTabBarController *)fromVC;
//    ShowBigViewController * bigVC = (ShowBigViewController *)toVC;
//   UIViewController * homeVC =  maintabBarController.childViewControllers[0];
    CGRect temp4 = self.fadeView.frame;
//    NSLog
//    (@" +++++ %f  %f  %f  %f",temp4.origin.x,temp4.origin.y,temp4.size.width,temp4.size.height);
//    UIView * snapShotView = self.fadeView;
    NSLog(@"%@",self.fadeView.superview);
//   CGRect rect = [self.fadeView convertRect:self.fadeView.frame toView:homeVC.view];
//    CGRect rect1 = [self.fadeView convertRect:self.fadeView.frame fromView:homeVC.view];
//    NSLog(@" ---- %f  %f  %f  %f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
//     NSLog(@" ---- %f  %f  %f  %f",rect1.origin.x,rect1.origin.y,rect1.size.width,rect1.size.height);
//    self.fadeView.frame = rect;
    
//    bigVC.

    //设置第二个controller 的位置 透明度
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0.0f;
    //把动画前后的两个controller加入容器中
    [containerView addSubview:self.fadeView];
    [containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.fadeView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        fromVC.view.alpha = 0.0f;
        toVC.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.fadeView.frame = temp4;
//        [self.fadeView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}



@end
