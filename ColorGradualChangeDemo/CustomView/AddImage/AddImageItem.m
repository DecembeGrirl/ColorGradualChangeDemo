//
//  AddImageItem.m
//  移动物美
//
//  Created by 杨淑园 on 2016/12/23.
//  Copyright © 2016年 赵永生. All rights reserved.
//

#import "AddImageItem.h"

@implementation AddImageItem

-(instancetype)initWithSize:(CGSize)size IsEdit:(BOOL)isEdit
{
    if(self = [super init])
    {
        _myImageView = [[UIImageView alloc]init];
        [self addSubview:_myImageView];
        CGFloat width = !isEdit?size.width:size.width -10;
        CGFloat height = !isEdit?size.height:size.height-10;
        CGFloat top = !isEdit?0:10;
        [_myImageView setFrame:CGRectMake(0, top, width, height)];
//        [_myImageView makeConstraints:^(MASConstraintMaker *make) {
//            make.left.offset(0);
//            if(!isEdit)
//            {
//                make.width.offset(size.width);
//                make.height.offset(size.height);
//                make.top.offset(0);
//            }else
//            {
//                make.width.offset(size.width -10);
//                make.height.offset(size.height -10);
//                make.top.offset(10);
//            }
//        }];
        if(isEdit){
            UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [deleteBtn setImage:[UIImage imageNamed:@"icon_writeDifferDelete"] forState:UIControlStateNormal];
            [deleteBtn addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:deleteBtn];
//            [deleteBtn makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(_myImageView).offset(9);
//                make.width.offset(18);
//                make.height.offset(18);
//                make.top.equalTo(_myImageView).offset(-9);
//            }];
        }
    }
    return self;
}

-(void)deleteImage
{
    [self removeFromSuperview];
    [self. delegate deleteImage:self];
}
@end
