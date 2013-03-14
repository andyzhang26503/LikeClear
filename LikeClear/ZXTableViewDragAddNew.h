//
//  ZXTableViewDragAddNew.h
//  LikeClear
//
//  Created by zhang andy on 13-3-14.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "ZXCustomTableView.h"
#import "ZXTableViewCell.h"
@interface ZXTableViewDragAddNew : ZXCustomTableView
{
    ZXTableViewCell *_placeholderCell;
    BOOL _pullDownInProgress;
}
@end
