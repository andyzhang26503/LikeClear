//
//  ZXLabel.h
//  LikeClear
//
//  Created by zhang andy on 13-3-9.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface ZXLabel : UITextField
{
    CALayer *_strikeThroughLayer;
}
@property (nonatomic,assign)BOOL strikeThroughHidden;

- (void)resizeStrikeThrough:(CGPoint)translationPoint withOrinPoint:(CGPoint)orinPoint;
@end
