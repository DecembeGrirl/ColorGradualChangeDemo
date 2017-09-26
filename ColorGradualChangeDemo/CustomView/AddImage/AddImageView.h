//
//  AddImageView.h
//  移动物美
//
//  Created by 杨淑园 on 2016/12/23.
//  Copyright © 2016年 赵永生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddImageItem.h"
//#define imageViewWidth 67

typedef void(^AddImagesBlock)(NSArray * images);
@protocol AddImageViewDelegate <NSObject>

@optional
-(void)addImage:(NSMutableArray*)images;
-(void)deletImage:(NSMutableArray *)images;

@end

@interface AddImageView : UIView<AddImageItemDelegate>
{
    CGFloat imageViewWidth;
}

@property (nonatomic, strong)NSMutableArray * items;
@property (nonatomic, strong)NSMutableArray * images;
@property (nonatomic, strong)UIButton * addbtn;
@property (nonatomic, strong)id<AddImageViewDelegate>delegate;
@property (nonatomic, strong)AddImagesBlock addImagesBlock;
@property (nonatomic, assign)BOOL isEdit;

-(instancetype)initWithImags:(NSArray *)array showAddBtn:(BOOL)isShow;

-(void)configImages:(NSArray *)array;

@end
