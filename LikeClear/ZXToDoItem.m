//
//  ZXToDoItem.m
//  LikeClear
//
//  Created by zhang andy on 13-3-8.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "ZXToDoItem.h"

@implementation ZXToDoItem

- (id)initWithText:(NSString *)text
{
    self = [super init];
    if (self) {
        self.todoText = text;
    }
    return self;
}

+ (id)initWithTodoText:(NSString *)text
{
    ZXToDoItem *todoItem = [[ZXToDoItem alloc] initWithText:text];
    return todoItem;
}
@end
