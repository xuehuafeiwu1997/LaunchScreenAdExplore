//
//  LaunchAdView.h
//  开屏广告的实现
//
//  Created by 许明洋 on 2020/11/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LaunchAdView : UIView

@property (nonatomic, copy) dispatch_block_t completeBlock;
- (instancetype)initWithBgImageUrl:(NSURL *)picUrl;

@end

NS_ASSUME_NONNULL_END
