//
//  ZXMainViewController.h
//  LikeClear
//
//  Created by zhang andy on 13-3-8.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXTableViewCell.h"
#import "ZXTableViewDatasource.h"
#import "ZXCustomTableView.h"
#import "ZXTableViewDragAddNew.h"
#import "ZXTableViewPinchToAdd.h"
@interface ZXMainViewController : UIViewController<ZXTableViewCellProtocol,ZXTableViewDatasource>
{
    float _editingOffset;
    ZXTableViewDragAddNew *_dragAddNew;
    ZXTableViewPinchToAdd *_pinchAddNew;
}
@property (nonatomic,strong) NSMutableArray *todoArray;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ZXCustomTableView *tableView;

@end
