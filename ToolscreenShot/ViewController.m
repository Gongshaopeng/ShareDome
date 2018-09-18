//
//  ViewController.m
//  ToolscreenShot
//
//  Created by 巩小鹏 on 2018/9/4.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "ViewController.h"
#import "ToolscreenShot.h"
#import "GShareView.h"
#import "GSLAlertView.h"

#define __kScreenWidth__ [[UIScreen mainScreen] bounds].size.width
#define __kScreenHeight__ [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()
@property (nonatomic,strong) UIImageView * imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareShow)];
    [_imageView addGestureRecognizer:tapGesturRecognizer];
    //截屏
    [[ToolscreenShot screenShot] addScreenShotNotification];
    
    
    
}

- (void) shareShow{
    
    [GShareView newShare].shareType = ShareViewType;
    [[GShareView newShare] show];
    [GShareView newShare].shareBlock = ^(ShareClickType shareClickType) {
        NSString * title;
        switch (shareClickType) {
            case QQ_ShareType:
                NSLog(@"QQ好友");
                title = @"分享到QQ";
                break;
            case error_ShareType:
                 NSLog(@"失败");
                title = @"分享失败";
                break;
            case Qzone_ShareType:
                 NSLog(@"QQ空间");
                 title = @"分享到QQ空间";
                break;
            case WechatTimeLine_ShareType:
                 NSLog(@"微信朋友圈");
                title = @"分享到微信朋友圈";
                break;
            case WechatSession_ShareType:
                 NSLog(@"微信好友");
                title = @"分享到微信好友";
                break;
            case Sina_ShareType:
                 NSLog(@"新浪微博");
                title = @"分享到新浪微博";
                break;
            default:
                break;
        }
        GSLAlertView * alertGs = [[GSLAlertView alloc] initWithTitle:@"提示" message:title sureBtn:@"知道了" cancleBtn:nil];
        alertGs.resultIndex = ^(NSInteger index) {
            
        };
        [alertGs showGSAlertView];
    };
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, __kScreenWidth__, __kScreenHeight__);
        _imageView.image = [UIImage imageNamed:@"Forever.jpg"];
        _imageView.userInteractionEnabled=YES;

    }
    return _imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
