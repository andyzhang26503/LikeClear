//
//  ZXCustomTableView.h
//  TestCustomView
//
//  Created by zhang andy on 13-3-10.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXTableViewDatasource.h"
@interface ZXCustomTableView : UIView
{
    UIScrollView *_scrollView;
}
@property (nonatomic,weak) id<ZXTableViewDatasource> dataSource;
@end
