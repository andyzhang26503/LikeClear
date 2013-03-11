//
//  ZXTableViewCell.h
//  LikeClear
//
//  Created by zhang andy on 13-3-9.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXLabel.h"
#import "ZXToDoItem.h"
@protocol ZXTableViewCellProtocol <NSObject>
- (void)deleteTheCell:(UITableViewCell *)cell;
- (void)finishTheCell:(UITableViewCell *)cell;
@end

@interface ZXTableViewCell : UITableViewCell<UIGestureRecognizerDelegate>
{
    CGPoint _oriCenter;
    CGPoint _transPoint;
    BOOL _shouldDelFlag;
    BOOL _shouldFinishFlag;
    ZXLabel *_zxLabel;
    CALayer *_finishGreenLayer;
    
    UILabel *_tickLabel;
    UILabel *_crossLabel;
    
    CGRect _oriFrame;
}

@property (nonatomic,weak)id<ZXTableViewCellProtocol> delegate;

@property (nonatomic,strong)ZXToDoItem *todoItem;
@end