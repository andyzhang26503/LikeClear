//
//  ZXCustomTableView.h
//  TestCustomView
//
//  Created by zhang andy on 13-3-10.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXTableViewDatasource.h"


@interface ZXCustomTableView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSMutableSet *_reuseCellSet;
    Class _cellClass;
}
@property (nonatomic,weak) id<ZXTableViewDatasource> dataSource;
@property (nonatomic,strong)NSArray *visibleCells;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,weak) id<UIScrollViewDelegate> delegate;

- (void)registerClassForCells:(Class)cellClass;
- (ZXTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)aIdentifier;
- (void)refreshData;
- (void)reloadData;
@end
