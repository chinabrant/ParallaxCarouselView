//
//  CarouselView.m
//  TestSomething
//
//  Created by brant on 5/26/16.
//  Copyright © 2016 brant. All rights reserved.
//

#import "CarouselView.h"

#define ImageWidth 50

@interface CarouselView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageViewOne;
@property (nonatomic, strong) UIImageView *imageViewTwo;
@property (nonatomic, strong) UIImageView *imageViewThree;

@property (nonatomic, strong) UIView *avatarBackView;

@property (nonatomic, strong) UILabel *labelOne;
@property (nonatomic, strong) UILabel *labelTwo;
@property (nonatomic, strong) UILabel *labelThree;

@end

@implementation CarouselView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100);
        self.pagingEnabled = YES;
//        self.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
        self.delegate = self;
        
//        [self setupView];
    }
    
    return self;
}

- (void)setDataSource:(id<CarouselViewDataSource>)dataSource {
    _dataSource = dataSource;
    
    [self setupView];
}

- (void)setupView {
    // 防止多次设置datasource
    NSArray *views = self.subviews;
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    
    _avatarBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 3, 50)];
    [self addSubview:_avatarBackView];
    
    NSInteger count = [self.dataSource numberOfItems];
    
    self.contentSize = CGSizeMake(self.frame.size.width * count, self.frame.size.height);
    
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2.0 * (i + 1) - ImageWidth / 2.0, 0, ImageWidth, ImageWidth)];
        imageView.image = [UIImage imageNamed:[self.dataSource imageNameAtIndex:i]];
        [_avatarBackView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 70, self.frame.size.width, 20)];
        titleLabel.text = [self.dataSource titleAtIndex:i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
    }
    
}

# pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat delta = scrollView.contentOffset.x / 2.0;
    
    [self setX:_avatarBackView x:delta];
}

- (void)setX:(UIView *)view x:(CGFloat)x {
    CGRect rect = view.frame;
    rect.origin.x = x;
    view.frame = rect;
}


@end
