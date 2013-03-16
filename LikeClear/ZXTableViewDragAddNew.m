//
//  ZXTableViewDragAddNew.m
//  LikeClear
//
//  Created by zhang andy on 13-3-14.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "ZXTableViewDragAddNew.h"

@implementation ZXTableViewDragAddNew

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        _placeholderCell = [[ZXTableViewCell alloc] init];
//        _placeholderCell.backgroundColor = [UIColor redColor];
//        
//    }
//    return self;
//}
- (id)initWithTableView:(ZXCustomTableView *)tableView
{
    self = [super init];
    if (self) {
        _tableView = tableView;
        _placeholderCell = [[ZXTableViewCell alloc] init];
        _placeholderCell.backgroundColor = [UIColor redColor];
        
        _tableView.delegate = self;
        
    }
    return self;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGPoint p = scrollView.contentOffset;
    //NSLog(@"p.y==%f",p.y);
    if(p.y<=0){
       _pullDownInProgress = YES;
//        _placeholderCell.frame = CGRectMake(0, -cellHeight, self.frame.size.width, cellHeight);
//        _placeholderCell.alpha = 0.5;
        [_tableView insertSubview:_placeholderCell atIndex:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //[super scrollViewDidScroll:scrollView];
    CGPoint p = scrollView.contentOffset;
    if (_pullDownInProgress && p.y<=0.0f) {
        _placeholderCell.frame = CGRectMake(0,-p.y-cellHeight, _tableView.frame.size.width, cellHeight);
        if (-p.y >=cellHeight) {
            _placeholderCell.zxLabel.text = @"Release to add";
        }else{
            _placeholderCell.zxLabel.text = @"Pull to Add";
        }
        
        _placeholderCell.alpha = MIN(1, -p.y/cellHeight) ;
    }else{
        _pullDownInProgress=NO;
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"endDragging");
    //[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    CGPoint p = scrollView.contentOffset;
    if (_pullDownInProgress&& p.y<=-cellHeight) {

        [_tableView.dataSource inserItemAtIndex:0];
        //[_tableView refreshData];
    }
    _pullDownInProgress=NO;
    //!!!remove
    [_placeholderCell removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
