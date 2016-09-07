//
//  PopFadeTranst.m
//  someTest
//
//  Created by 杨淑园 on 16/1/26.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "PopFadeTranst.h"
#import "MainTabBarController.h"
#import "WBViewControll.h"
@implementation PopFadeTranst
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    
    MainTabBarController * maintabBarController = (MainTabBarController *)toVC;
    WBViewControll * homeVC =  maintabBarController.childViewControllers[0];
    UIView * snapShotView = self.fadeView;
    
    CGRect rect = [self.fadeView convertRect:self.fadeView.frame toView:homeVC.view];
//    CGRect rect1 = [self.fadeView convertRect:self.fadeView.frame fromView:homeVC.view];
     NSLog(@" pop_+_+_+_+_ %f  %f  %f  %f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
//    NSLog(@" pop_+_+_+_+_ %f  %f  %f  %f",rect1.origin.x,rect1.origin.y,rect1.size.width,rect1.size.height);
    //设置第二个controller 的位置 透明度
    toVC.view.frame = [transitionContext finalFrameForViewController:fromVC];
    toVC.view.alpha = 0.0f;
    //把动画前后的两个controller加入容器中
    [containerView addSubview:snapShotView];
    [containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        snapShotView.frame = [containerView convertRect:self.frame fromView:toVC.view];
//        snapShotView.frame = CGRectMake(10, 10, 100, 100);
//        snapShotView.frame = rect;
//        snapShotView.frame = self.frame;
        fromVC.view.alpha = 0.0f;
        toVC.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}



@end
