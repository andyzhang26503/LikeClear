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
static const float cellHeight = 50.0f;
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
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
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
    [self refreshData];
}
- (void)refreshData
{
    int numberOfRows = [self.dataSource numberOfRows];
    _scrollView.frame = self.frame;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, numberOfRows*cellHeight);
    if (numberOfRows!=0) {
        for (int i=0; i<numberOfRows; i++) {
            ZXTableViewCell *cellView = [self.dataSource cellForRowAtRow:i];
            cellView.frame = CGRectMake(0, cellHeight*i, self.frame.size.width, cellHeight);

            //cellView = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight*i, self.frame.size.width, cellHeight)];
            //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, cellView.frame.size.width, cellView.frame.size.height)];
            
            [_scrollView addSubview:cellView];

        }
    }
}
@end
