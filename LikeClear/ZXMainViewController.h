//
//  ZXMainViewController.h
//  LikeClear
//
//  Created by zhang andy on 13-3-8.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXTableViewCell.h"
@interface ZXMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ZXTableViewCellProtocol>

@property (nonatomic,strong) NSMutableArray *todoArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
