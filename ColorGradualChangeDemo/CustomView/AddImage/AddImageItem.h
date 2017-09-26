//
//  AddImageItem.h
//  移动物美
//
//  Created by 杨淑园 on 2016/12/23.
//  Copyright © 2016年 赵永生. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddImageItem;

@protocol AddImageItemDelegate <NSObject>


-(void)deleteImage:(AddImageItem *)item;

@end

@interface AddImageItem : UIView

//-(instancetype)initIsEdit:(BOOL)isEdit;
-(instancetype)initWithSize:(CGSize)size IsEdit:(BOOL)isEdit;
@property (nonatomic, strong) UIImageView * myImageView;
@property (nonatomic, strong)id<AddImageItemDelegate>delegate;
@end
