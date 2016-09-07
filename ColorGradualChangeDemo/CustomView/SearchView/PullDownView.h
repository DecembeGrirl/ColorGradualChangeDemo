//
//  PullDownView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/11.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PullDownViewDelegate <NSObject>

-(void)SelectedPullDownViewBtn:(UIButton *)btn;

@end
@interface PullDownView : UIView

@property (nonatomic, weak)id<PullDownViewDelegate>delegate;
@end
