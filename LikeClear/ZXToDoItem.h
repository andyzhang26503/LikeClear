//
//  ZXToDoItem.h
//  LikeClear
//
//  Created by zhang andy on 13-3-8.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXToDoItem : NSObject

@property (nonatomic,strong)NSString *todoText;
@property (nonatomic,assign)BOOL finished;

- (id)initWithText:(NSString *)text;
+ (id)initWithTodoText:(NSString *)text;
@end
