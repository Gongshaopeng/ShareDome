//
//  SecurityStrategy.h
//  VoteWhere
//
//  Created by WJ02047 mini on 14-12-9.
//  Copyright (c) 2014年 Touna Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SecurityStrategy : NSObject

//后台模糊效果
+(void)addBlurEffect;
+(void)removeBlurEffect;
+(UIImage *)blurImage;
//获取图片
+(UIImageView *)addGsImage:(NSInteger)tagNum;
+(void)removeGsImage:(NSInteger)tagNum;
+(UIImage *)gsImager;
+(UIImage *)gsImagerview:(UIView *)window;
//自定义截屏
+(UIImageView *)addGsImage:(NSInteger)tagNum view:(UIView *)window;


@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
