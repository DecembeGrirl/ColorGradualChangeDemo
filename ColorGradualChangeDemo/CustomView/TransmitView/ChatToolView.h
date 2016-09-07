//
//  TransmitBottomView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatToolView;

typedef void(^SelectedImageBtnBlock)(ChatToolView *toolView,UIButton * btn);
typedef void(^SelectedAtBtnBlock)(ChatToolView *toolView,UIButton * btn);
typedef void(^SelectedTopicBtnBlock)(ChatToolView *toolView,UIButton * btn);
typedef void(^SelectedFaceBtnBlock)(ChatToolView *toolView,UIButton * btn);
typedef void(^SelectedPlusBtnBlock)(ChatToolView *toolView,UIButton * btn);

@interface ChatToolView : UIView
{
    CGRect _frame;
}

@property (nonatomic, copy)SelectedImageBtnBlock selectedImageBtnBlock;
@property (nonatomic, copy)SelectedAtBtnBlock selectedAtBtnBlock;
@property (nonatomic, copy)SelectedTopicBtnBlock selectedTopicBtnBlock;
@property (nonatomic, copy)SelectedFaceBtnBlock selectedFaceBtnBlock;
@property (nonatomic, copy)SelectedPlusBtnBlock selectedPlusBtnBlock;



-(void)ChangeFrame:(CGRect)frame;
@end
