//
//  ZXLabel.m
//  LikeClear
//
//  Created by zhang andy on 13-3-9.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "ZXLabel.h"

@implementation ZXLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.font=[UIFont systemFontOfSize:16.0];
        _strikeThroughHidden = YES;
        
        _strikeThroughLayer = [CALayer layer];
        _strikeThroughLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _strikeThroughLayer.hidden = _strikeThroughHidden;
        //_strikeThroughLayer.bounds = CGRectMake(0, self.frame.size.height/2, 0, 1);
        [self.layer addSublayer:_strikeThroughLayer];
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
- (void)setText:(NSString *)text
{
    [super setText:text];
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:16.0]];
    _strikeThroughLayer.frame = CGRectMake(0, self.frame.size.height/2, size.width, 1);
}
- (void)setStrikeThroughHidden:(BOOL)strikeThroughHidden
{
    _strikeThroughHidden = strikeThroughHidden;
    [self setNeedsLayout];
}
- (void)layoutSubviews
{
    _strikeThroughLayer.hidden = _strikeThroughHidden;
}

//TODO
- (void)resizeStrikeThrough:(CGPoint)translationPoint withOrinPoint:(CGPoint)orinPoint
{
    _strikeThroughLayer.hidden= NO;
    
    CGSize size = [self.text sizeWithFont:[UIFont systemFontOfSize:16.0]];
    float strikeWidth = (float)translationPoint.x * (float)size.width/(float)orinPoint.x;
    //_strikeThroughLayer.frame = CGRectMake(0, self.frame.size.height/2, strikeWidth, 1);

    // Prepare the animation from the old size to the new size
    CGRect oldBounds = _strikeThroughLayer.bounds;
    CGRect newBounds = CGRectMake(0, self.frame.size.height/2, strikeWidth, 1);
    newBounds.size = size;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    
    // NSValue/+valueWithRect:(NSRect)rect is available on Mac OS X
    // NSValue/+valueWithCGRect:(CGRect)rect is available on iOS
    // comment/uncomment the corresponding lines depending on which platform you're targeting
    
    // Mac OS X
    //animation.fromValue = [NSValue valueWithRect:NSRectFromCGRect(oldBounds)];
    //animation.toValue = [NSValue valueWithRect:NSRectFromCGRect(newBounds)];
    // iOS
    animation.fromValue = [NSValue valueWithCGRect:oldBounds];
    animation.toValue = [NSValue valueWithCGRect:newBounds];
    
    // Update the layer's bounds so the layer doesn't snap back when the animation completes.
    _strikeThroughLayer.bounds = newBounds;
    
    // Add the animation, overriding the implicit animation.
    [_strikeThroughLayer addAnimation:animation forKey:@"bounds"];
    
    
    NSLog(@"strikeWidth==%f",strikeWidth);
    //[self setNeedsLayout];
}
@end
