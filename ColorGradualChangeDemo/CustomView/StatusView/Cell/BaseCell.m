//
//  BaseCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/12.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "BaseCell.h"
#import "TransmitViewController.h"
#define headImageWidth  30
@implementation BaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.imageViewArray = [[NSMutableArray alloc]initWithCapacity:3];
        self.layer.drawsAsynchronously = YES;
        [self initViews];
        self.opaque = YES;
    }
    return  self;
}

-(void)initViews
{
    _headImageView = [[UIImageView alloc]init];
    _headImageView.userInteractionEnabled = YES;
//    [_headImageView setBackgroundColor:[UIColor whiteColor]];
    _headImageView.opaque = YES;
    [self.contentView addSubview:_headImageView];
    
    _nickNameLabel = [[YYLabel alloc]init];
    [_nickNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    _nickNameLabel.userInteractionEnabled = YES;
    _nickNameLabel.textColor = RGB_COLOR(@"#FFB669");
//    [_nickNameLabel setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_nickNameLabel];
    
    _contentTextLabel = [[YYLabel alloc]init];
    [_contentTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:16.0]];
    _contentTextLabel.numberOfLines =0;
    _contentTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    [_contentTextLabel setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_contentTextLabel ];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreBtn setImage:[UIImage imageNamed:@"message_toolbar_popover_arrow"] forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(ClickMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
    
    _bottomView = [[BottomToolView alloc]init];
    _bottomView.delegate = self;
    [self.contentView addSubview:_bottomView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HandleTapGesture)];
    tap.delegate = self;
    [_headImageView addGestureRecognizer:tap];
    [_nickNameLabel addGestureRecognizer:tap];
}

-(void)setSubviewsFrame
{
    
    [_headImageView setFrame:CGRectMake(5, 5,ceilf(headImageWidth) , ceilf(headImageWidth))];
    
    CGSize nickNameSize = self.statusObj.nameSize;
    [_nickNameLabel setFrame:CGRectMake(_headImageView.right + 2, _headImageView.top + 8, nickNameSize.width, nickNameSize.height)];
    
    CGSize contentTextSize = self.statusObj.statusContentTextSize;
    [_contentTextLabel setFrame:CGRectMake(5, _headImageView.bottom + 2, contentTextSize.width ,contentTextSize.height )];
    
    [_moreBtn setFrame:CGRectMake(KScreenWidth - 40, _headImageView.top, 35, 35)];
    [_bottomView setFrame:CGRectMake(0,_contentTextLabel.bottom + 2, KScreenWidth, BottomToolViewHeight)];
}

-(void)ConfigCellWithIndexPath:(NSIndexPath *)indexPath Data:(id)data cellType:(CellType)cellType
{
    self.statusObj= (Statuses *)data;
    __block typeof(self)weakself = self;
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:self.statusObj.user.profile_image_url] options:SDWebImageDelayPlaceholder progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if(!error)
        {
            UIImage *tempImage = [[GlobalHelper ShareInstance]ClipCirCleImage:image size:CGSizeMake(ceilf(headImageWidth), ceilf(headImageWidth))];
            [weakself->_headImageView setImage:tempImage];
        }
    }];
    
    _nickNameLabel.text = self.statusObj.user.name;
    _contentTextLabel.attributedText = self.statusObj.contextAtr;
    [_bottomView ConfigBtnData:self.type];
    
    if(cellType == cellTypeOfDetails)
    {
      [self  setMoreBtnImageWithImage];
    }
    
    [self setSubviewsFrame];
}

-(CGFloat)cellHeight
{
    if(self.type == COMMENTDETAILSTYPE)
    {
        return _contentTextLabel.bottom;
    }
    return _bottomView.bottom;
}

-(void)SelectLink
{
    [GlobalHelper ShareInstance].selectedYYLabelRangeTextBlock=^(UIView * containerView, NSAttributedString * text, NSRange range, CGRect rect)
    {
        NSString * str = [[text string] substringWithRange:range];
        NSLog(@"%@",str);
        BaseCell * cell;
        if([[containerView superview] isKindOfClass:[RetweetedStatusView class]])
            cell = (BaseCell *)[[[containerView superview]superview]superview];
        else
            cell = (BaseCell *)[[containerView superview]superview];
        if([str hasPrefix:@"http://"])
        {
            [cell.delegate SelectedURL:str];
        }
        else if([str hasPrefix:@"@"])
        {
            if([[containerView superview] isKindOfClass:[RetweetedStatusView class]])
                [cell.delegate SelectedUserName:cell.statusObj.retweeted_status];
            else /*if([containerView isKindOfClass:[BaseCell class]])*/
                 [cell.delegate SelectedUserName:cell.statusObj];
        }
        else if([str hasPrefix:@"#"])
            NSLog(@"%@",str);
    };
}

#pragma mark -BottomToolViewDelegate
-(void)SelectedBottomViewBtn:(UIButton *)btn btnType:(CommentType)type
{
    [self.delegate SelectedCellBtn:self btnType:type];
}
-(void)HandleTapGesture
{
    [self.delegate SelectedNameOrHeader:self.statusObj];
}
-(void)setHeadImageUserInterActionEnable:(BOOL)userInaterActionEnable
{
    _headImageView.userInteractionEnabled = userInaterActionEnable;
    _nickNameLabel.userInteractionEnabled = userInaterActionEnable;
}
-(void)ClickMoreBtn:(UIButton *)btn
{
    [self.delegate SelectedMoreBtn:self];
}
-(void)setMoreBtnImageWithImage
{    if(self.statusObj.favorited)
    {
        [_moreBtn setImage:[UIImage imageNamed:@"more_icon_collection"] forState:UIControlStateNormal];
    }
    else{
        [_moreBtn setImage:[UIImage imageNamed:@"more_icon_collection_selected"] forState:UIControlStateNormal];
    }
}
@end
