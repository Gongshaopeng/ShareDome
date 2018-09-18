//
//  ToolscreenShot.m
//  ToolscreenShot
//
//  Created by 巩小鹏 on 2018/9/4.
//  Copyright © 2018年 巩小鹏. All rights reserved.
//

#import "ToolscreenShot.h"
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "SGQRCodeTool.h"
#import "SecurityStrategy.h"
#import "UIImage+ImageCornerRadius.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "GShareView.h"

@interface ToolscreenShot ()
{
    UIImage * imageSS;
}


@end

@implementation ToolscreenShot

+(instancetype)screenShot{
    static ToolscreenShot *manager=nil;
    static dispatch_once_t once;
    dispatch_once(&once ,^
                  {
                      if (manager==nil)
                      {
                          manager=[[ToolscreenShot alloc]init];
                      }
                  });
    return manager;
}



-(void)screenShotsShareview:(UIView *)window url:(NSString *)url complete:(void (^)(UIImage * image))complete
{
    //截屏, 获取所截图片（imageWithScreenshot在后面实现）
    UIImage *imageScreenshot;
    //        image = [UIImage snapshotScreenInView:window];
    
    
    if (window != nil) {
        imageScreenshot =  [SecurityStrategy gsImagerview:window];
        
    }else{
        imageScreenshot =  [SecurityStrategy gsImager];
        
    }
    
    if (url != nil ) {
        [SGQRCodeTool setQRRequest:url image:^(UIImage *imageQr) {
            self->imageSS = [UIImage addImage:imageQr toImage:imageScreenshot];
        
        }];
        
        
    }else{
        //调用显示分享的页面
        imageSS = imageScreenshot;
        
    }
    
    
    complete(imageSS);
}

-(void)screenShotsShare:(NSString *)url complete:(void (^)(UIImage * image))complete
{
    [self screenShotsShareview:nil url:url complete:complete];
    
}

#pragma mark - 添加监听
-(void)addScreenShotNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShot) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}
#pragma mark - 移除监听
-(void)removeScreenShotNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationUserDidTakeScreenshotNotification
                                                  object:nil];
}
#pragma mark - 截屏代码
-(void)screenShot{
    NSLog(@"截屏");
    [self screenShotsShare:@"试试看吧" complete:^(UIImage * image) {
        [GShareView newShare].shareType = ShareScreenshotsType;
        [GShareView newShare].screenShotsImage.image = image;
        [[GShareView newShare] show];
    }];
    
}

@end
