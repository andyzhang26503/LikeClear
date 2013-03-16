//
//  ZXTableViewPinchToAdd.h
//  LikeClear
//
//  Created by zhang andy on 13-3-15.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXCustomTableView.h"
#import "ZXTableViewCell.h"
@interface ZXTableViewPinchToAdd : NSObject
{
    ZXTableViewCell *_placeholderCell;
    ZXCustomTableView *_tableView;
    int _pointACellIndex;
    int _pointBCellIndex;
    BOOL _pinchInProgress;
}
- (id)initWithTableView:(ZXCustomTableView *)tableView;
@end
