//
//  TransfFade.h
//  someTest
//
//  Created by 杨淑园 on 16/1/25.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PushFadeTranst : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong)UIView * fadeView;
@property (nonatomic, assign)CGRect frame;
@end