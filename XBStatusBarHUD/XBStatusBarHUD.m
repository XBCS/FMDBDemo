//
//  XBStatusBarHUD.m
//  JS - 网易新闻
//
//  Created by 李泽宇 on 16/3/17.
//  Copyright © 2016年 丶信步沧桑. All rights reserved.
//



#import "XBStatusBarHUD.h"


static UIWindow *_window;

#define XBSTATUSBARHEIGHT 20

// 字体大小
#define XBFONT [UIFont systemFontOfSize:12]

@implementation XBStatusBarHUD






+ (void)message:(NSString *)msg {
    
    [self message:msg image:nil];
}


+ (void)message:(NSString *)msg image:(UIImage *)image {
    
    [self message:msg image:image style:XBStatusBarStyleNormal];
}


+ (void)message:(NSString *)msg style:(XBStatusBarStyle)style {

    [self message:msg image:nil style:style];
}


+ (void)message:(NSString *)msg image:(UIImage *)image style:(XBStatusBarStyle)style {

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:msg forState:UIControlStateNormal];
    
    if (image) {
        
        [btn setImage:image forState:UIControlStateNormal];
        
 //       btn.font //NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
       
//        NS_DEPRECATED_IOS(_iosIntro, _iosDep, ...) CF_DEPRECATED_IOS(_iosIntro, _iosDep, __VA_ARGS__)
        
//        CF_DEPRECATED_IOS(_iosIntro, _iosDep, ...) __attribute__((availability(ios,introduced=_iosIntro,deprecated=_iosDep,message="" __VA_ARGS__)))
        
    } else {
        [btn setImage:[UIImage imageNamed:@"XBStatusBarHUD/"] forState:UIControlStateNormal];
    }
     btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    _window = [[UIWindow alloc]init];
    _window.backgroundColor = [UIColor grayColor];
    
    _window.frame = CGRectMake(0, -XBSTATUSBARHEIGHT, [UIScreen mainScreen].bounds.size.width, XBSTATUSBARHEIGHT);
    
    btn.frame = _window.bounds;
    
    
    
    
    // 默认为YES
    _window.hidden = NO;
    
    _window.windowLevel = UIWindowLevelAlert;
    
    /*
     UIKIT_EXTERN const UIWindowLevel UIWindowLevelNormal;
     UIKIT_EXTERN const UIWindowLevel UIWindowLevelAlert;     最高
     UIKIT_EXTERN const UIWindowLevel UIWindowLevelStatusBar  第二
     */
    
    [_window addSubview:btn];
    
    [UIApplication sharedApplication];
    

    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = _window.frame;
        frame.origin.y = 0;
        _window.frame = frame;
    } completion:^(BOOL finished) {
        
    [UIView animateWithDuration:0.5 delay:0.5 options:kNilOptions animations:^{
            CGRect frame = _window.frame;
            frame.origin.y = -XBSTATUSBARHEIGHT;
            _window.frame = frame;
            
        } completion:^(BOOL finished) {
            _window = nil;
        }];
        
        
        
    }];
    
    
    


}


+ (void)loading:(NSString *)msg {
    
    [self loading:msg image:nil];
}


+ (void)loading:(NSString *)msg image:(UIImage *)image {
    [self loading:msg image:image style:XBStatusBarStyleNormal];
}


+ (void)loading:(NSString *)msg image:(UIImage *)image style:(XBStatusBarStyle)style {
    if (_window) {
        return;
    }
    
    _window = [[UIWindow alloc]init];
    _window.backgroundColor = [UIColor grayColor];
    _window.frame = CGRectMake(0, -XBSTATUSBARHEIGHT, [UIScreen mainScreen].bounds.size.width, XBSTATUSBARHEIGHT);
    // 默认为YES
    _window.hidden = NO;
    
    _window.windowLevel = UIWindowLevelAlert;
    
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = msg;
    
    label.font = XBFONT;
    
    label.frame = _window.bounds;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.tintColor = [UIColor darkTextColor];
    [_window addSubview:label];
    
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    /*
     UIActivityIndicatorViewStyleWhiteLarge,
     UIActivityIndicatorViewStyleWhite,             //菊花
     UIActivityIndicatorViewStyleGray __TVOS_PROHIBITED,
     */
    
    
    [activityIndicatorView startAnimating];
    
    activityIndicatorView.frame = CGRectMake(0, 0, XBSTATUSBARHEIGHT, XBSTATUSBARHEIGHT);
    
    [_window addSubview:activityIndicatorView];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = _window.frame;
        frame.origin.y = 0;
        _window.frame = frame;
    }completion:^(BOOL finished) {
        _window = nil;
    }];
    
//    [UIApplication]
}


+ (BOOL)resolveInstanceMethod:(SEL)sel {

    return YES;
}





@end
