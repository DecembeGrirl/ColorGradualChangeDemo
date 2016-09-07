//
//  FaceView.m
//  OneRoad
//
//  Created by ibokan on 14-10-18.
//  Copyright (c) 2014年 杨淑园. All rights reserved.
//

#import "FaceView.h"

#import "Config.h"


//#define faceKeyBoardHeight 150

@interface ShowFace ()

-(id)initWithName:(NSString *)name andImage:(UIImage *)image;

@property (strong, nonatomic) NSString *name ;
@property (strong, nonatomic) UIImage *image;

@end

@implementation ShowFace

-(id)initWithName:(NSString *)name andImage:(UIImage *)image
{
    if(self ==[super init])
    {
        
        self.name = name;
        self.image = image;
    }
    return self;
    
}

@end




@implementation FaceView

-(FaceView*)init
{
    self = [super init];
    if (self) {
        _space = 10;
        _btnwidth = (KScreenWidth -(8*10)) / 7;
        _faceKeyBoardHeight = 4 * _space + 3 * _btnwidth;
        self.frame = CGRectMake(0, (KScreenHeight - _faceKeyBoardHeight) , KScreenWidth , _faceKeyBoardHeight );
        self.backgroundColor = [UIColor  colorWithRed:244.0/255.0 green:244.0/255.0 blue:239.0/255.0 alpha:1.0];
        //        self.backgroundColor = [UIColor redColor];
        [self creatFaceView:self.frame];
        
        
    }
    
    
    return self;
}

-(void)BelongChatToolBar:(ChatToolBar *)chatToolBar
{
    self.chatToolBar = chatToolBar;
}

-(NSMutableArray *)showFaceNameArr
{
    
    if(_showFaceNameArr == nil)
    {
        _showFaceNameArr = [[NSMutableArray alloc]initWithCapacity:5];
        
    }
    return _showFaceNameArr;
}



-(void)creatFaceView:(CGRect)frame
{
    
    NSString *plistStr = [[NSBundle mainBundle]pathForResource:@"expression" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:plistStr];
    
    NSArray *arr = [dic allKeys];
    int page = arr.count / 21;
    if(arr.count % 21)
    {
        page ++;
    }
    
    //scrolView
    self.scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width ,_faceKeyBoardHeight )];
    self.scrolView.scrollEnabled = YES;
    self.scrolView.pagingEnabled = YES;
    self.scrolView.delegate = self;
    //滚动条不可见
    [self.scrolView setShowsHorizontalScrollIndicator:NO];
    [self.scrolView setShowsVerticalScrollIndicator:NO];
    
    self.scrolView.contentSize = CGSizeMake(page * frame.size.width , _faceKeyBoardHeight );
    [self addSubview:self.scrolView];
    
    //pageControl
    self.pageControl =  [[UIPageControl alloc]initWithFrame:CGRectMake(frame.size.width/2-20, _faceKeyBoardHeight - 10 , 30 ,10 )];
    self.pageControl.numberOfPages = page;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self addSubview:self.pageControl];
    
    
    int tag = 0;
    int btnSum =0;
    for (int i = 0; i < page; i ++)
    {
        for (int j = 0; j < 3; j ++)
        {
            for (int k = 0; k < 7; k ++)
            {
                if (tag > arr.count)
                {
                    break;
                }
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btnSum++;
                
                if(btnSum % 21==0){
                    [btn setImage:[UIImage imageNamed:@"DeleteEmoticonBtn_ios7"] forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(deletFaceImage:) forControlEvents:UIControlEventTouchUpInside];
                    
                }else{
                    NSString *imageName = dic[arr[tag]];
                    btn.tag = tag ++;
                    
                    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(getFaceImage:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                btn.frame = CGRectMake((_btnwidth * k + (k+1) *_space + i * KScreenWidth ) ,
                                       j * _btnwidth+(j+1)*_space ,
                                       _btnwidth ,
                                       _btnwidth ) ;
                [self.scrolView addSubview:btn];
            }
        }
    }
    self.faceArr =arr;
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //改变PageControl的当前点
    CGPoint point = scrollView.contentOffset;
    CGRect rect = scrollView.bounds;
    [ self.pageControl setCurrentPage:point.x/rect.size.width ];
}


#pragma mark - 获取点击表情
- (void) getFaceImage:(UIButton *)sender
{
    NSString *name =self.faceArr[sender.tag];
    self.lastFaceName = name;
    
    //记录点击的表情名字
    ShowFace *showFace  = [[ShowFace alloc]initWithName:name andImage:sender.imageView.image];
    [self.showFaceNameArr addObject:showFace];
    
    self.clickFaceImageBtnBlock(name,sender.imageView.image);
}


#pragma mark -删除表情
-(void)deletFaceImage:(UIButton *)sender
{
    
    
    self.deleteFaceImageBlock(self.lastFaceName);
//        MyTextView *textView = self.chatToolBar.subviews[1];
//    
//        if(textView.sendText.length > 0)
//        {
//    
//            NSRange range = NSMakeRange(textView.sendText.length - self
//                                        .lastFaceName.length-1, self.lastFaceName.length+1);
//            //    NSLog(@"sendtext.length:%lu", (unsigned long)textView.sendText.length);
//    //            NSLog(@"sendtext   %@", textView.sendText);
//            textView.sendText = [textView.sendText stringByReplacingCharactersInRange:range withString:@""];
//    //
//    //            NSLog(@"删除后的sendtext   %@", textView.sendText);
//            NSAttributedString * attr = [[NSAttributedString alloc]initWithString:textView.tempText];
//    
//            [self.showFaceNameArr removeLastObject];
//            if(self.showFaceNameArr.count > 0)
//            {
//                ShowFace *showFace =self.showFaceNameArr[self.showFaceNameArr.count-1];
//                self.lastFaceName = showFace.name;
//    
//            }
//    
//    
//            for(int i = 0;i < self.showFaceNameArr.count;i++)
//            {
//                ShowFace *showFace = self.showFaceNameArr[i];
//                NSAttributedString *string = [ConverToExpression ConverToExpression:attr andImage:showFace.image];
//                attr = string;
//            }
//            textView.attributedText = attr;
//    
//    
//            if (textView.sendText.length==0){
//                textView.tempText = @"";
//                textView.sendText = @"";
//                textView.text = @"";
//            }
//            [textView textViewDidChange:textView];
//            
//            return;
//        }

}








@end
