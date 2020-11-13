//
//  LaunchAdView.m
//  开屏广告的实现
//
//  Created by 许明洋 on 2020/11/13.
//

#import "LaunchAdView.h"
#import <SDWebImage/SDWebImageManager.h>
#import "SDImageCache.h"
#import "SDWebImage.h"
#import "Masonry.h"

@interface LaunchAdView()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) NSURL *picUrl;
@property (nonatomic, strong) UIButton *skipAdButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSInteger secondsCount;

@end

@implementation LaunchAdView

- (instancetype)initWithBgImageUrl:(NSURL *)picUrl {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.picUrl = picUrl;
        [self setup];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.secondsCount = 5;//默认倒计时为5秒
    self.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.skipAdButton];
    [self.bgImageView sd_setImageWithURL:self.picUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //图片加载完成
        NSLog(@"图片的来源为%ld",(long)cacheType);
        [self.skipAdButton setTitle:[NSString stringWithFormat:@"跳过%ld",(long)self.secondsCount] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf launchAdCountDown];
        }];
    }];
}

- (void)skipAdButtonClicked {
    NSLog(@"跳过开屏广告");
    if (self.timer) {
        [self.timer invalidate];
    }
    if (self.completeBlock) {
        self.completeBlock();
    }
}

#pragma mark - lazy load
- (UIImageView *)bgImageView {
    if (_bgImageView) {
        return _bgImageView;
    }
    _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.layer.masksToBounds = YES;
    return _bgImageView;
}

- (UIButton *)skipAdButton {
    if (_skipAdButton) {
        return _skipAdButton;
    }
    _skipAdButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 13 - 52, 20, 52, 25)];
    _skipAdButton.layer.cornerRadius = 25/2.0f;
    [_skipAdButton setClipsToBounds:YES];
    _skipAdButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    _skipAdButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_skipAdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _skipAdButton.userInteractionEnabled = YES;
    [_skipAdButton addTarget:self action:@selector(skipAdButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    return _skipAdButton;
}

- (void)launchAdCountDown {
    if (self.secondsCount < 1) {
        if (self.completeBlock) {
            self.completeBlock();
        }
        [self.timer invalidate];
        return;
    }
    self.secondsCount--;
    [self.skipAdButton setTitle:[NSString stringWithFormat:@"跳过%ld",(long)self.secondsCount] forState:UIControlStateNormal];
}

- (void)dealloc {
    [self.timer invalidate];
    NSLog(@"执行了释放方法");
}

@end
