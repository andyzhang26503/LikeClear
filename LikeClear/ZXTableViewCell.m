//
//  ZXTableViewCell.m
//  LikeClear
//
//  Created by zhang andy on 13-3-9.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "ZXTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ZXTableViewCell
{
    CAGradientLayer *_gradientLayer;
}

const float UI_CUES_MARGIN = 10.0f;
const float UI_CUES_WIDTH = 50.0f;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.frame;
        _gradientLayer.colors= [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0.1 alpha:0.4].CGColor,(id)[UIColor colorWithWhite:0.2 alpha:0.3].CGColor,(id)[UIColor clearColor].CGColor,(id)[UIColor colorWithWhite:0.3 alpha:0.3f].CGColor, nil];
        _gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.01],[NSNumber numberWithFloat:0.95],[NSNumber numberWithFloat:1.0], nil];
        [self.layer insertSublayer:_gradientLayer atIndex:0];
        
//        _gradientLayer = [CAGradientLayer layer];
//        _gradientLayer.frame = self.bounds;
//        _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
//                                  (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
//                                  (id)[[UIColor clearColor] CGColor],
//                                  (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
//        _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
//        [self.layer insertSublayer:_gradientLayer atIndex:0];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
        
        _zxLabel = [[ZXLabel alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width, self.bounds.size.height)];
        _zxLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_zxLabel];
        
        _finishGreenLayer = [CALayer layer];
        _finishGreenLayer.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, 50.0);
        _finishGreenLayer.backgroundColor = [[[UIColor alloc] initWithRed:0.0 green:0.6 blue:0.0 alpha:1.0] CGColor];
        _finishGreenLayer.hidden = YES;
        [self.layer insertSublayer:_finishGreenLayer atIndex:0];

        
        _tickLabel = [self createCueLabel];
        _tickLabel.text = @"\u2713";
        _tickLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_tickLabel];
        _crossLabel = [self createCueLabel];
        _crossLabel.text = @"\u2717";
        _crossLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_crossLabel];
    }
    return self;
}

- (UILabel *)createCueLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectNull];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:32.0];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _gradientLayer.frame = self.bounds;
    _tickLabel.frame = CGRectMake(-UI_CUES_WIDTH - UI_CUES_MARGIN, 0,
                                  UI_CUES_WIDTH, self.bounds.size.height);
    _crossLabel.frame = CGRectMake(self.bounds.size.width + UI_CUES_MARGIN, 0,
                                   UI_CUES_WIDTH, self.bounds.size.height);
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer translationInView:self];
    if (p.x != 0&&p.y==0) {
        
        return YES;
    }
    return NO;
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    //NSLog(@"into handlePan");
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _oriCenter = self.center;
        
        //_oriFrame =  self.frame;
        //NSLog(@"_oriCenter==%f,%f",_oriCenter.x,_oriCenter.y);
        //NSLog(@"into UIGestureRecognizerStateBegan");
    }else if(gestureRecognizer.state==UIGestureRecognizerStateChanged){
        _transPoint = [gestureRecognizer translationInView:self];
        self.center = CGPointMake(_oriCenter.x+_transPoint.x,_oriCenter.y );
        
        //ok
        //self.frame = CGRectMake(_oriFrame.origin.x+_transPoint.x, _oriFrame.origin.y, _oriFrame.size.width, _oriFrame.size.height);
        //NSLog(@"into UIGestureRecognizerStateChanged");
        float cueAlpha = fabsf(_transPoint.x)/fabsf(_oriCenter.x);
        _tickLabel.alpha = cueAlpha;
        _crossLabel.alpha = cueAlpha;
        if(fabsf(_transPoint.x)>=fabsf(_oriCenter.x)){
            _tickLabel.textColor = [UIColor greenColor];
            _crossLabel.textColor = [UIColor greenColor];
        }else{
            _tickLabel.textColor = [UIColor whiteColor];
            _crossLabel.textColor = [UIColor whiteColor];
        }
//        if(_transPoint.x>0){
//            
//            [_zxLabel resizeStrikeThrough:_transPoint withOrinPoint:_oriCenter];
//        }
        
    }else if(gestureRecognizer.state ==UIGestureRecognizerStateEnded){
        
        if (_transPoint.x<0) {
            _shouldDelFlag = fabsf(_transPoint.x)>=fabsf(_oriCenter.x);
            if (_shouldDelFlag) {
                NSLog(@"should del");
                [self deleteMe:_todoItem];
            }else{
                [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.center = _oriCenter;
                } completion:nil];
            }
        }else if(_transPoint.x>0){
            _shouldFinishFlag = fabsf(_transPoint.x)>=fabsf(_oriCenter.x);
            if (_shouldFinishFlag) {
                NSLog(@"should finish");
                [self finishMe:_todoItem];
                [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.center = _oriCenter;
                } completion:nil];
            }else{
                [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.center = _oriCenter;
                } completion:nil];
            }
        }
        
        
        //NSLog(@"into UIGestureRecognizerStateEnded");
    }
    //NSLog(@"out handlePan");
}

- (void)deleteMe:(ZXToDoItem *)item
{
    [self.delegate deleteTheCell:item withCell:self];
}

- (void)finishMe:(ZXToDoItem *)item
{
    _zxLabel.strikeThroughHidden = NO;
    _finishGreenLayer.hidden = NO;
    [self.delegate finishTheCell:item];
}

- (void)setTodoItem:(ZXToDoItem *)todoItem
{
    _todoItem = todoItem;
    _zxLabel.text = todoItem.todoText;
    _zxLabel.strikeThroughHidden = !todoItem.finished;
    _finishGreenLayer.hidden = !todoItem.finished;
}

@end
