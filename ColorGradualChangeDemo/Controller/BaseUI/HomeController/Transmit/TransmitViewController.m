//
//  TransmitViewController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/4.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "TransmitViewController.h"
#import "UIView+Frame.h"
#import "YSHYAssetPickerController.h"
#import "FaceView.h"
#import "GlobalHelper.h"
#import "AddImageView.h"
#import "MyLocationViewController.h"
@interface TransmitViewController ()<UITextViewDelegate,YSHYAssetPickerControllerDelegate,UINavigationControllerDelegate,AddImageViewDelegate,YSHYAssetPickerControllerDelegate>
{
    AddImageView * addImagesView;
}
@property (nonatomic, strong)NSMutableArray * imagesArray;
@end

@implementation TransmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CreatNavBar];
    [self CreatUI];
    [self ConfigBottomToolView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.type == REPORTTYPE)
    {
        [_reportsStatusView ConfigDataWith:self.obj];
    }else if(self.type == DEFULTTYPE)
    {
        _placehodlerLabel.text = @"分享新鲜事...";
        [self.customNav.titleLabel setText:@"发微博"];
        _reportsStatusView.hidden = YES;
        [_bottomToolView.meanWhileCommentBtn setTitle:@"你在哪儿?" forState:UIControlStateNormal];
        
    }
    else
    {
        _placehodlerLabel.text = @"写评论...";
        [self.customNav.titleLabel setText:@"发评论"];
        _reportsStatusView.hidden = YES;
         [_bottomToolView.meanWhileCommentBtn setTitle:@"同时评论?" forState:UIControlStateNormal];
    }
    [_textView becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}
-(void)CreatNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.customNav setNavTitle:@"转发微博"];
    
    UIButton *leftBtn =[CustomNavbar createNavButttonByTitle:@"取消" target:self action:@selector(HandelCancelBtn:)];
    UIButton *rightBtn = [CustomNavbar createNavButttonByTitle:@"发送" target:self action:@selector(HandelSendBtn:)];
    [self.customNav setLeftNavButton:leftBtn];
    [self.customNav setRightNavButton:rightBtn];
}
-(void)CreatUI
{
    _textView= [[UITextView alloc]initWithFrame:CGRectMake(5, self.customNav.bottom, self.view.width-10, 80)];
    _textView.showsVerticalScrollIndicator = NO;
    [_textView setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    _placehodlerLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 100, 25)];
    [_placehodlerLabel setText:@"说说分享心得"];
    [_placehodlerLabel setTextColor:[UIColor grayColor]];
    [_placehodlerLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [_textView addSubview:_placehodlerLabel];

    addImagesView = [[AddImageView alloc]initWithImags:self.imagesArray showAddBtn:NO];
    [addImagesView setFrame:CGRectMake(0, _textView.bottom , KScreenWidth, 85)];
    [self.view addSubview:addImagesView];
    addImagesView.delegate = self;
    __weak typeof(self) weakself = self;
    addImagesView.addImagesBlock = ^(NSArray * images)
    {
        weakself.imagesArray = [NSMutableArray arrayWithArray:images];
    };

    _reportsStatusView = [[ReportsStatusView alloc]initWithFrame:CGRectMake( 5, _textView.bottom + 50, self.view.width - 10, 60)];
    [self.view addSubview: _reportsStatusView];
    
    _bottomToolView = [[ChatToolView alloc]initWithFrame:CGRectMake(0, self.view.bottom- 60, self.view.width, 60)];
    [self.view addSubview:_bottomToolView];
    
    [self CreatFaceInputView];
}

-(void)CreatFaceInputView
{
    __block typeof(self)weakSelf = self;
    _faceInputView = [[FaceView alloc]init];
    _faceInputView.clickFaceImageBtnBlock = ^(NSString * faceName,UIImage * image)
    {
        // 在string的任意位置插入新的string/表情
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithAttributedString:weakSelf->_textView.attributedText];
        [string addAttribute:@"NSFontAttributeName" value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, string.length)];
        NSTextAttachment * atttachment = [[NSTextAttachment alloc]init];
        atttachment.image = image;
        // 修改 富文本图片的大小
        atttachment.bounds = CGRectMake(0, -4, 16, 16);
        NSAttributedString *temp = [NSAttributedString attributedStringWithAttachment:atttachment];
        //获取光标所在位置
        NSInteger location = [weakSelf->_textView offsetFromPosition:weakSelf->_textView.beginningOfDocument toPosition:weakSelf->_textView.selectedTextRange.start];
        [string insertAttributedString:temp atIndex:location];
        weakSelf->_textView.attributedText = string;
        [weakSelf textViewDidChange:weakSelf->_textView];
        
        //改变光标的位置   要在textViewDidChange 方法后调用才起作用
        weakSelf->_textView.selectedRange = NSMakeRange(location + temp.length , 0);
    };
    _faceInputView.deleteFaceImageBlock = ^(NSString * lastName)
    {

        // 删除任意位置的string字符/表情
        NSInteger location = [weakSelf->_textView offsetFromPosition:weakSelf->_textView.beginningOfDocument toPosition:weakSelf->_textView.selectedTextRange.start];
        if(location <= 0)
        {
            return ;
        }
        NSMutableAttributedString * atr = [[NSMutableAttributedString alloc]initWithAttributedString:weakSelf->_textView.attributedText];
        [atr deleteCharactersInRange:NSMakeRange(location-1, 1)];
        weakSelf->_textView.attributedText = atr;
        [weakSelf textViewDidChange:weakSelf->_textView];
        weakSelf->_textView.selectedRange = NSMakeRange(location-1,0);
    };
}

-(void)ConfigBottomToolView
{
    __block typeof(self)weakSelf = self;
    _bottomToolView.selectedMeanWhileCommentBtnBlock =^(ChatToolView * toolView,UIButton * btn)
    {
        if([btn.titleLabel.text isEqualToString:@"你在哪儿?"])
        {
            [weakSelf presentViewController:[[MyLocationViewController alloc]init] animated:YES completion:nil];
        }
        else
        {
        
        }
    };
    
    _bottomToolView.selectedImageBtnBlock=^(ChatToolView * toolView,UIButton * btn)
    {
        YSHYAssetPickerController *picker = [[YSHYAssetPickerController alloc]initWithNumber:5 andHasSelectedImags:weakSelf.imagesArray];//最多只能选5张
        picker.assetsFilter = [ALAssetsFilter allPhotos];
        picker.showEmptyGroups = NO;
        picker.pickerDelegate = weakSelf;
        picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,NSDictionary *bindings){
            if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
                NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
                return duration >= 5;
            }else{
                return  YES;
            }
        }];
        [weakSelf presentViewController:picker animated:YES completion:^{
             [weakSelf.view endEditing:YES];
//            picker.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
        }];


    };
    _bottomToolView.selectedAtBtnBlock=^(ChatToolView * toolView,UIButton * btn)
    {
        NSLog(@"点击了 @ 按钮");
    };
    _bottomToolView.selectedTopicBtnBlock=^(ChatToolView * toolView,UIButton * btn)
    {
        NSLog(@"点击了 # 按钮");
    };
    _bottomToolView.selectedFaceBtnBlock=^(ChatToolView * toolView,UIButton * btn)
    {
        if([btn.imageView.image isEqual:[UIImage imageNamed:@"message_emotion_background"]])
        {
            [btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"]forState:UIControlStateNormal];
            weakSelf->_textView.inputView = weakSelf->_faceInputView;
            [weakSelf->_textView reloadInputViews];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"message_emotion_background"] forState:UIControlStateNormal];
            weakSelf->_textView.inputView = nil;
            [weakSelf->_textView reloadInputViews];
        }
        NSLog(@"点击了表情按钮");
    };
    _bottomToolView.selectedPlusBtnBlock=^(ChatToolView * toolView,UIButton * btn)
    {
        NSLog(@"点击了 + 按钮");
    };
}

#pragma mark - AddImageViewDelegate-----
-(void)addImage:(NSMutableArray *)images
{
    self.imagesArray = images;
}
-(void)deletImage:(NSMutableArray *)images
{
    self.imagesArray = images;
}

#pragma mark - ZYQAssetPickerControllerDelegate
-(void)assetPickerController:(YSHYAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    self.imagesArray = [assets mutableCopy];
    [addImagesView configImages:self.imagesArray];
    NSLog(@"finishPicking");
}

#pragma  HandleBtnAction
-(void)HandelCancelBtn:(UIButton *)sender
{
    [self ResignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)HandelSendBtn:(UIButton *)sender
{
    [self ResignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ResignFirstResponder
{
    [_textView resignFirstResponder];
}
#pragma UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    UIView * view = textView.subviews[1];
    view.hidden =textView.attributedText.length > 0?YES:NO;
    NSLog(@"光标的位置改变了");
}


//- (void)textViewDidChangeSelection:(UITextView *)textView
//{
//    NSLog(@"---- %@   %@",textView.selectedTextRange.start ,textView.selectedTextRange.end);
//}

#pragma KeyBoardNotifications
-(void)KeyboardWasShown:(NSNotification *)notification
{
    NSDictionary * info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [_bottomToolView ChangeFrame:CGRectMake(0, 0, keyboardSize.width, keyboardSize.height)];
}
@end
