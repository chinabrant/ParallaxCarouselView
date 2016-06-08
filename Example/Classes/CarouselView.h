//
//  CarouselView.h
//  TestSomething
//
//  Created by brant on 5/26/16.
//  Copyright © 2016 brant. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouselViewDataSource <NSObject>

- (NSInteger)numberOfItems;
- (NSString *)titleAtIndex:(int)index;
- (NSString *)imageNameAtIndex:(int)index;

@end

@protocol CarouselViewDelegate <NSObject>

- (void)didSelectItemAtIndex:(int)index;

@end

@interface CarouselView : UIScrollView

@property (nonatomic, weak) id <CarouselViewDataSource> dataSource;

@end
