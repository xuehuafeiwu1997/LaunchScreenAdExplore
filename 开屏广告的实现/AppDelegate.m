//
//  AppDelegate.m
//  开屏广告的实现
//
//  Created by 许明洋 on 2020/11/13.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <SDWebImage/SDWebImageDownloader.h>
#import "LaunchAdView.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    NSString *picStr = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=254509618,3726556670&fm=26&gp=0.jpg";
    [self showAdViewWithUrl:[NSURL URLWithString:picStr]];
//    NSString *userDefaultKey = @"adImage_key";
//    if ([[[NSUserDefaults standardUserDefaults] stringForKey:userDefaultKey] isEqualToString:@"1"]) {
//        //如果不是第一次打开
//        [self showAdViewWithUrl:[NSURL URLWithString:picStr]];
//    } else {
//        NSURL *picUrl = [NSURL URLWithString:picStr];
//        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:@"https://up.enterdesk.com/edpic_source/43/e1/c0/43e1c0e421c17efa4734be7080052134.jpg"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//                } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//                    NSLog(@"cacheType的类型为%ld",cacheType);
//        }];
//        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:picUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//                } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//                    if (error) {
//                        NSLog(@"下载图片时发生错误，错误为%@",error);
//                    }
//                    if (image) {
//                        [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"adImage_key"];
//                        //使用这种方式下载图片，必须自己写缓存到磁盘的方法，不然的话不会有缓存
//                        //参考https://github.com/SDWebImage/SDWebImage/blob/master/Docs/HowToUse.md
//                        [[SDImageCache sharedImageCache] storeImage:image forKey:picStr toDisk:YES completion:^{
//                            NSLog(@"存储图片到磁盘中成功");
//                                                }];
//                        [self showAdViewWithImage:image];
//                    }
//            }];
//        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:picUrl completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//            if (error) {
//                NSLog(@"下载图片时发生错误，错误为%@",error);
//            }
//            if (image) {
//                [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"adImage_key"];
//                [self showAdViewWithImage:image];
//            }
//        }];
//    }
    return YES;
}

- (void)showAdViewWithUrl:(NSURL *)picUrl {
    LaunchAdView *adView = [[LaunchAdView alloc] initWithBgImageUrl:picUrl];
    [[UIApplication sharedApplication].windows.lastObject addSubview:adView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([adView superview]) {
            [adView removeFromSuperview];
        }
    });
}

- (void)showAdViewWithImage:(UIImage *)image {
    LaunchAdView *adView = [[LaunchAdView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    adView.image = image;
    [[UIApplication sharedApplication].windows.lastObject addSubview:adView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([adView superview]) {
            [adView removeFromSuperview];
        }
    });
}

@end
