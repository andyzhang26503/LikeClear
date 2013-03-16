//
//  ZXTableViewPinchToAdd.m
//  LikeClear
//
//  Created by zhang andy on 13-3-15.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "ZXTableViewPinchToAdd.h"

struct ZXTouchPoints {
    CGPoint upper;
    CGPoint lower;
};
typedef struct ZXTouchPoints ZXTouchPoints;

@implementation ZXTableViewPinchToAdd
{
    ZXTouchPoints _initialTouchPoints;
    BOOL _pinchExceededRequiredDistance ;
}
- (id)initWithTableView:(ZXCustomTableView *)tableView
{
    self = [super init];
    if (self) {
        _tableView = tableView;
        _placeholderCell = [[ZXTableViewCell alloc] init];
        _placeholderCell.backgroundColor = [UIColor redColor];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        [_tableView addGestureRecognizer:pinch];
                    
    }
    return self;
}

-(void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    if(recognizer.state == UIGestureRecognizerStateBegan){
        //[self pinchStarted:recognizer];
        _initialTouchPoints = [self getNormalTouchPoints:recognizer];
        NSArray *vcells = _tableView.visibleCells;
        for (int i=0;i<vcells.count;i++) {
//            ZXTableViewCell *c=[vcells objectAtIndex:i];
//            if (c.frame.origin.y<_initialTouchPoints.upper.y&&_initialTouchPoints.upper.y<c.frame.origin.y+cellHeight) {
//                _pointACellIndex=i;
//                c.backgroundColor = [UIColor purpleColor];
//            }
//            if (c.frame.origin.y<_initialTouchPoints.lower.y&&_initialTouchPoints.lower.y<c.frame.origin.y+cellHeight) {
//                _pointBCellIndex=i;
//                c.backgroundColor = [UIColor purpleColor];
//            }
            for(int i=0; i<vcells.count; i++)
            {
                UIView* cell = (UIView*)vcells[i];
                if ([self viewContainsPoint:cell withPoint:_initialTouchPoints.upper])
                {
                    _pointACellIndex = i;
                }
                if ([self viewContainsPoint:cell withPoint:_initialTouchPoints.lower])
                {
                    _pointBCellIndex = i;
                }
            }
        }

        if (_pointBCellIndex-_pointACellIndex==1) {
            _pinchInProgress = YES;
            _pinchExceededRequiredDistance=NO;
            
            ZXTableViewCell *cellA = [vcells objectAtIndex:_pointACellIndex];
            _placeholderCell.frame = CGRectOffset(cellA.frame, 0, cellHeight/2);
            
            //!!! _tableView.scrollView
            [_tableView.scrollView insertSubview:_placeholderCell atIndex:0];
            
        }
    }
    if(recognizer.state == UIGestureRecognizerStateChanged&&_pinchInProgress&&recognizer.numberOfTouches==2){
        //[self pinchChanged:recognizer];
        ZXTouchPoints currentPoints = [self getNormalTouchPoints:recognizer];
        float upperDelta = _initialTouchPoints.upper.y-currentPoints.upper.y;
        float lowerDelta = currentPoints.lower.y - _initialTouchPoints.lower.y;
        float delta = MAX(0, MIN(upperDelta, lowerDelta)) ;

        NSArray *visibleCells = _tableView.visibleCells;
        for (int i=0; i<visibleCells.count; i++) {
            UIView *cell = [visibleCells objectAtIndex:i];
            if (i <= _pointACellIndex)
            {
                cell.transform = CGAffineTransformMakeTranslation(0,  -delta);
            }
            if (i >= _pointBCellIndex)
            {
                cell.transform = CGAffineTransformMakeTranslation(0, delta);
            }
        }
        float gapSize = delta*2;
        float cappedGapSize = MIN(gapSize, cellHeight);
        _placeholderCell.transform = CGAffineTransformMakeScale(1.0f, cappedGapSize/cellHeight);
        _placeholderCell.zxLabel.text = gapSize > cellHeight ?
        @"Release to Add Item" : @"Pull to Add Item";
        _placeholderCell.alpha = MIN(1.0f, gapSize/cellHeight);
        if (gapSize>cellHeight) {
            _pinchExceededRequiredDistance = YES;
        }else{
            _pinchExceededRequiredDistance = NO;
        }
        
    }
    if(recognizer.state == UIGestureRecognizerStateEnded){
        //[self pinchEnded:recognizer];
        _pinchInProgress = false;
        _placeholderCell.transform = CGAffineTransformIdentity;
        [_placeholderCell removeFromSuperview];
        if (_pinchExceededRequiredDistance) {
            int indexOffset = floor(_tableView.scrollView.contentOffset.y/cellHeight);
            [_tableView.dataSource inserItemAtIndex:indexOffset+_pointBCellIndex];
        }else{
            [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                NSArray *visibleCells = _tableView.visibleCells;
                for (UIView *c in visibleCells) {
                    c.transform = CGAffineTransformIdentity;
                }
            } completion:^(BOOL finished){
                [_tableView reloadData];
            }];
        }

    }
}


/*
- (void) pinchStarted:(UIPinchGestureRecognizer *)recognizer
{
    // find the touch-points
    _initialTouchPoints = [self getNormalTouchPoints:recognizer];
    
    // locate the cells that these points touch
    _pointACellIndex = -100;
    _pointBCellIndex = -100;
    NSArray* visibleCells = _tableView.visibleCells;
    for(int i=0; i<visibleCells.count; i++)
    {
        UIView* cell = (UIView*)visibleCells[i];
        if ([self viewContainsPoint:cell withPoint:_initialTouchPoints.upper])
        {
            _pointACellIndex = i;
        }
        if ([self viewContainsPoint:cell withPoint:_initialTouchPoints.lower])
        {
            _pointBCellIndex = i;
        }
    }
    
    // check whether they are neighbours
    if (abs(_pointACellIndex - _pointBCellIndex) == 1)
    {
        // if so - initiate the pinch
        _pinchInProgress = YES;
        _pinchExceededRequiredDistance = NO;
        
        // show our place-holder cell
        ZXTableViewCell* precedingCell = (ZXTableViewCell*)(_tableView.visibleCells)[_pointACellIndex];
        _placeholderCell.frame = CGRectOffset(precedingCell.frame, 0.0f, cellHeight / 2.0f);
        [_tableView.scrollView insertSubview:_placeholderCell atIndex:0];
    }
}

-(void) pinchChanged:(UIPinchGestureRecognizer *)recognizer
{
    // find the touch-points
    ZXTouchPoints currentTouchPoints = [self getNormalTouchPoints:recognizer];
    
    // determine by how much each touch point has changed, and take the minimum delta
    float upperDelta = currentTouchPoints.upper.y - _initialTouchPoints.upper.y;
    float lowerDelta = _initialTouchPoints.lower.y - currentTouchPoints.lower.y;
    float delta = -MIN(0, MIN(upperDelta, lowerDelta));
    float gapSize = delta * 2;
    
    // offset the cells, negative for th cells above, positive for those below
    NSArray* visibleCells = _tableView.visibleCells;
    for(int i=0; i<visibleCells.count; i++)
    {
        UIView* cell = (UIView*)visibleCells[i];
        if (i <= _pointACellIndex)
        {
            cell.transform = CGAffineTransformMakeTranslation(0,  -delta);
        }
        if (i >= _pointBCellIndex)
        {
            cell.transform = CGAffineTransformMakeTranslation(0, delta);
        }
    }
    
    // scale the placeholder cell
    float cappedGapSize = MIN(gapSize, cellHeight);
    _placeholderCell.transform = CGAffineTransformMakeScale(1.0f, cappedGapSize / cellHeight );
    
    _placeholderCell.zxLabel.text = gapSize > cellHeight ?
    @"Release to Add Item" : @"Pull to Add Item";
    
    _placeholderCell.alpha = MIN(1.0f, gapSize / cellHeight);
    
    // determine whether they have pinched far enough
    _pinchExceededRequiredDistance = gapSize > cellHeight;
}

-(void) pinchEnded:(UIPinchGestureRecognizer *)recognizer
{
    _pinchInProgress = false;
    
    // remove the placeholder cell
    _placeholderCell.transform = CGAffineTransformIdentity;
    [_placeholderCell removeFromSuperview];
    
    if (_pinchExceededRequiredDistance)
    {
        // add a new item
        int indexOffset = floor(_tableView.scrollView.contentOffset.y / cellHeight);
        [_tableView.dataSource inserItemAtIndex:_pointBCellIndex + indexOffset];
    }
    else
    {
        //otherwise animate back to position
        [UIView animateWithDuration:0.2f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             NSArray* visibleCells = _tableView.visibleCells;
                             for(ZXTableViewCell* cell in visibleCells)
                             {
                                 cell.transform = CGAffineTransformIdentity;
                             }
                         }
                         completion:^(BOOL finished){
                             [_tableView reloadData];
                         }];
        
        
        ;
    }
    
}
*/
- (BOOL) viewContainsPoint:(UIView*)view withPoint:(CGPoint)point
{
    CGRect frame = view.frame;
    return (frame.origin.y < point.y) && (frame.origin.y +frame.size.height) > point.y;
}
- (ZXTouchPoints) getNormalTouchPoints: (UIGestureRecognizer*) recognizer
{
    CGPoint pointOne = [recognizer locationOfTouch:0 inView:_tableView];
    CGPoint pointTwo = [recognizer locationOfTouch:1 inView:_tableView];
    
    // offset based on scroll
    pointOne.y += _tableView.scrollView.contentOffset.y;
    pointTwo.y += _tableView.scrollView.contentOffset.y;
    
    // ensure pointOne is the top-most
    if (pointOne.y > pointTwo.y)
    {
        CGPoint temp = pointOne;
        pointOne = pointTwo;
        pointTwo = temp;
    }
    
    ZXTouchPoints points = {pointOne, pointTwo};
    return points;
}

//- (ZXTouchPoints)getNormalTouchPoints:(UIPinchGestureRecognizer *)recognizer
//{
//    CGPoint a = [recognizer locationOfTouch:0 inView:_tableView];
//    CGPoint b = [recognizer locationOfTouch:1 inView:_tableView];
//    a.y = a.y+_tableView.scrollView.contentOffset.y;
//    b.y = b.y+_tableView.scrollView.contentOffset.y;
//    //int indexA = ceil(a.y/cellHeight);
//    //int indexB = ceil(b.y/cellHeight);
//    if (b.y<a.y) {
//        CGPoint tmp = a;
//        a = b;
//        b = tmp;
//    }
//    ZXTouchPoints points = {a,b};
//    return points;
//}
@end
