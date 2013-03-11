//
//  ZXTableViewDatasource.h
//  TestCustomView
//
//  Created by zhang andy on 13-3-10.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXTableViewCell;
@protocol ZXTableViewDatasource <NSObject>

- (int)numberOfRows;
- (ZXTableViewCell *)cellForRowAtRow:(int)rowIndex;
@end
