//
//  FaceView.h
//  爱语OneRoad
//
//  Created by ibokan on 14-10-18.
//  Copyright (c) 2014年 杨淑园. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ChatToolBar;



@interface ShowFace : NSObject
@property (strong, nonatomic) NSString *abcde;
@end




typedef void(^ClickFaceImageBtnBlock)(NSString * faceName,UIImage * image);
typedef void(^DeleteFaceImageBlock)(NSString * lastFaceName);

@interface FaceView : UIView<UIScrollViewDelegate>
{
    CGFloat  _faceKeyBoardHeight;
    CGFloat _space;
    CGFloat _btnwidth;
    
}
@property (strong, nonatomic) UIScrollView *scrolView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSArray *faceArr;
@property (strong, nonatomic) ChatToolBar *chatToolBar;
@property (strong, nonatomic) NSString *lastFaceName;
@property (strong, nonatomic) NSMutableArray *showFaceNameArr;

@property (copy, nonatomic)ClickFaceImageBtnBlock clickFaceImageBtnBlock;
@property (copy, nonatomic)DeleteFaceImageBlock deleteFaceImageBlock;


- (void) getFaceImage:(UIButton *)sender;

-(void)BelongChatToolBar:(ChatToolBar *)chatToolBar;


@end
