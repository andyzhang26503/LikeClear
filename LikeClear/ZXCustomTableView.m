//
//  ZXCustomTableView.m
//  TestCustomView
//
//  Created by zhang andy on 13-3-10.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "ZXCustomTableView.h"
#import "ZXToDoItem.h"
#import "ZXTableViewCell.h"
//static const float cellHeight = 50.0f;
@implementation ZXCustomTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self refreshData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        //[self refreshData];
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectNull];
        _scrollView.delegate = self;
        _reuseCellSet = [[NSMutableSet alloc] init];
        [self addSubview:_scrollView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)layoutSubviews
{
    _scrollView.frame = self.frame;
    [self refreshData];
}
- (void)refreshData
{
    if (CGRectIsNull(_scrollView.frame)) {
        return;
    }
    int numberOfRows = [self.dataSource numberOfRows];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width, numberOfRows*cellHeight);
    
    NSArray *subViewArray = [self mySubViews];
    for (ZXTableViewCell *c in subViewArray) {
        if (c.frame.origin.y+cellHeight<_scrollView.contentOffset.y) {
            [self recycleCell:c];
        }
        if (c.frame.origin.y >_scrollView.contentOffset.y +self.frame.size.height) {
            [self recycleCell:c];
        }
    }
    CGPoint scrollPoint = _scrollView.contentOffset;
    //NSLog(@"contentOffset.y==%f",scrollPoint.y);
    int firstVisibleIndex = MAX(0,floor(scrollPoint.y/cellHeight));
    int lastVisibleIndex = MIN([_dataSource numberOfRows],ceil(scrollPoint.y/cellHeight+self.bounds.size.height/cellHeight+1));
    //int lastVisibleIndex = ceil(scrollPoint.y/cellHeight+self.bounds.size.height/cellHeight);
    for (int i = firstVisibleIndex; i<lastVisibleIndex; i++) {
        //不用移动cell
        UIView *cell = [self cellForRow:i];
        if (!cell) {
            ZXTableViewCell *cell = [self.dataSource cellForRowAtRow:i];
            cell.frame = CGRectMake(0, cellHeight*i, self.frame.size.width, cellHeight);
            
            //!!!!!!
            //[_scrollView addSubview:cell];
            [_scrollView insertSubview:cell atIndex:0];
        }
        
    }
    
//    if (numberOfRows!=0) {
//        for (int i=0; i<numberOfRows; i++) {
//            CGPoint scrollPoint = _scrollView.contentOffset;
//            double n1 = floor(scrollPoint.y/cellHeight);
//            double n2 = ceil(scrollPoint.y/cellHeight+self.bounds.size.height/cellHeight)-1;
//            NSLog(@"scrollPoint.y==%f",scrollPoint.y);
//            if (i<n1) {
//                [self recycleCell:[self.dataSource cellForRowAtRow:i]];
//            }else if (i>n2) {
//                [self recycleCell:[self.dataSource cellForRowAtRow:i]];
//            }else{                
//                ZXTableViewCell *cellView = [self.dataSource cellForRowAtRow:i];
//                cellView.frame = CGRectMake(0, cellHeight*i+scrollPoint.y, self.frame.size.width, cellHeight);
//                [_scrollView addSubview:cellView];
//            }
//        }
//    }
}

// !!!
-(UIView*) cellForRow:(NSInteger)row {
    float topEdgeForRow = row * cellHeight;
    for (UIView* cell in [self mySubViews]) {
        if (cell.frame.origin.y == topEdgeForRow) {
            return cell;
        }
    }
    return nil;

}
- (NSArray *)mySubViews
{
    NSMutableArray *subviewArray = [[NSMutableArray alloc] initWithCapacity:10];
    //NSArray *viewArray = [self subviews];
    NSArray *viewArray = [_scrollView subviews];
    for (UIView *v in viewArray) {
        if ([v isKindOfClass:[ZXTableViewCell class]]) {
            [subviewArray addObject:v];
        }
    }
    return subviewArray;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self refreshData];
}
- (void)recycleCell:(ZXTableViewCell *)acell
{
    [_reuseCellSet addObject:acell];
    //NSLog(@"_reuseCellSet.count==%d",_reuseCellSet.count);
    [acell removeFromSuperview];
}
- (ZXTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)aIdentifier
{
    ZXTableViewCell *cell = [_reuseCellSet anyObject];
    if (cell){
        //NSLog(@"Returning a cell from the pool");
        [_reuseCellSet removeObject:cell];
    }
    if (!cell) {
        cell = [[_cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aIdentifier];
        //NSLog(@"zxtableviewcell alloc");
    }
    return cell;
}

- (void)registerClassForCells:(Class)cellClass
{
    _cellClass = cellClass;
}

- (NSArray *)visibleCells
{
//    NSMutableArray *vCells = [[NSMutableArray alloc] initWithCapacity:12];
//    CGPoint scrollPoint = _scrollView.contentOffset;
//    int firstVisibleIndex = MAX(0,floor(scrollPoint.y/cellHeight));
//    int lastVisibleIndex = MIN([_dataSource numberOfRows],ceil(scrollPoint.y/cellHeight+self.bounds.size.height/cellHeight+1));
//    for (int i = firstVisibleIndex; i<lastVisibleIndex; i++) {
//        //UIView *cell = [self cellForRow:i];
//        NSArray *scrollSub = [_scrollView subviews];
//        for (UIView *c in scrollSub) {
//            if ([c isKindOfClass:[ZXTableViewCell class]]) {
//                if (c.frame.origin.y == i*cellHeight) {
//                    [vCells addObject:c];
//                }
//            }
//        }
//        
//    }
//    
//    return  vCells;
    NSMutableArray *subviews = [NSMutableArray arrayWithArray:[self mySubViews]];
//    for (UIView *v1 in subviews) {
//        NSLog(@"before..y=%f",v1.frame.origin.y);
//    }
    NSArray *sortedSubviews = [subviews sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2){
        UIView *v1 = obj1;
        UIView *v2 = obj2;
        float result = v2.frame.origin.y-v1.frame.origin.y;
        if (result>0.0) {
            return NSOrderedAscending;
        }else if(result<0.0){
            return NSOrderedDescending;
        }else{
            return NSOrderedSame;
        }
    }];
//    for (UIView *v2 in sortedSubviews) {
//        NSLog(@"after..y=%f",v2.frame.origin.y);
//    }
    return sortedSubviews;
}

- (void)reloadData
{
    [[self mySubViews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self refreshData];
}
@end
