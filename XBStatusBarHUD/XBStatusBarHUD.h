//
//  XBStatusBarHUD.h
//  JS - 网易新闻
//
//  Created by 李泽宇 on 16/3/17.
//  Copyright © 2016年 丶信步沧桑. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <objc/runtime.h>


typedef NS_ENUM(NSInteger, XBStatusBarStyle) {
    
    XBStatusBarStyleNormal,
    XBStatusBarStyleLeft,
    XBStatusBarStyleD,
    
};




@interface XBStatusBarHUD : NSObject


+ (void)message:(NSString *)msg;

//+ (void)showError:(NSString *)msgError;
//
//+ (void)showLogin:(NSString *)msg;

+ (void)message:(NSString *)msg style:(XBStatusBarStyle)style;

//+ (void)showError:(NSString *)msgError style:(XBStatusBarStyle)style;
//
//+ (void)showLogin:(NSString *)msg style:(XBStatusBarStyle)style;


+ (void)message:(NSString *)msg image:(UIImage *)image;

//+ (void)showError:(NSString *)msgError image:(NSString *)imageName;
//
//+ (void)showLogin:(NSString *)msg image:(NSString *)imageName;


+ (void)message:(NSString *)msg image:(UIImage *)image style:(XBStatusBarStyle)style;
//
//+ (void)showError:(NSString *)msgError image:(NSString *)imageName style:(XBStatusBarStyle)style;
//

+ (void)loading:(NSString *)msg;

+ (void)loading:(NSString *)msg image:(UIImage *)image;

+ (void)loading:(NSString *)msg image:(UIImage *)image style:(XBStatusBarStyle)style;

//+ (void)showLogin:(NSString *)msg image:(NSString *)imageName style:(XBStatusBarStyle)style;
//+ (void)regist;


@end
