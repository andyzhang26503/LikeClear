//
//  ZXMainViewController.m
//  LikeClear
//
//  Created by zhang andy on 13-3-8.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "ZXMainViewController.h"
#import "ZXToDoItem.h"
#import "ZXTableViewCell.h"

@interface ZXMainViewController ()

@end

@implementation ZXMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.todoArray = [NSMutableArray arrayWithObjects:[ZXToDoItem initWithTodoText:@"打扫房间"],
                      [ZXToDoItem initWithTodoText:@"听音乐"],
                      [ZXToDoItem initWithTodoText:@"看书"],
                      [ZXToDoItem initWithTodoText:@"去公园"],
                      [ZXToDoItem initWithTodoText:@"洗车"],
                      [ZXToDoItem initWithTodoText:@"java"],
                      [ZXToDoItem initWithTodoText:@"objective-c"],
                      [ZXToDoItem initWithTodoText:@"asp"],
                      [ZXToDoItem initWithTodoText:@"vb script"],
                      [ZXToDoItem initWithTodoText:@"delphi"],
                      [ZXToDoItem initWithTodoText:@"上班"],
                      [ZXToDoItem initWithTodoText:@"休息"],
                      [ZXToDoItem initWithTodoText:@"读兄弟"],
                      [ZXToDoItem initWithTodoText:@"世界因你不同"],
                      [ZXToDoItem initWithTodoText:@"与未来同行"],
                      [ZXToDoItem initWithTodoText:@"悲惨世界"],
                      [ZXToDoItem initWithTodoText:@"追梦赤子心"],nil];
    
    
    //self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    //self.tableView.backgroundColor = [UIColor redColor];
    [self.tableView registerClassForCells:[ZXTableViewCell class]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.todoArray.count;
//}
- (int)numberOfRows
{
    return self.todoArray.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellName = @"cellName";
//    ZXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//    if (!cell) {
//        cell = [[ZXTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//    }
//
//    //cell.textLabel.text = [(ZXToDoItem *)[self.todoArray objectAtIndex:indexPath.row] todoText];
//    cell.todoItem = [self.todoArray objectAtIndex:indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.backgroundColor = [UIColor clearColor];
//    cell.delegate = self;
//    return cell;
//}

- (ZXTableViewCell *)cellForRowAtRow:(int)rowIndex
{
    static NSString *cellName = @"cellName";
    ZXTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    //ZXTableViewCell *cell;
//    if (!cell) {
//        cell = [[ZXTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//    }  
    cell.todoItem = [self.todoArray objectAtIndex:rowIndex];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    [self setCellColor:cell atIndex:rowIndex];
    return cell;
    

}
- (void)setCellColor:(UIView *)cell atIndex:(int)rowIndex
{
    float greenFloat = (float)rowIndex/(float)self.todoArray.count;
    //cell.backgroundColor = [UIColor colorWithRed:1 green:greenFloat blue:0 alpha:0.4];
    cell.backgroundColor = [UIColor colorWithRed:1 green:greenFloat blue:0 alpha:1];
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    float greenFloat = (float)indexPath.row/(float)self.todoArray.count;
//    //cell.backgroundColor = [UIColor colorWithRed:1 green:greenFloat blue:0 alpha:0.4];
//    cell.backgroundColor = [UIColor colorWithRed:1 green:greenFloat blue:0 alpha:1];
//}
/*
- (void)deleteTheCell:(ZXToDoItem *)atodoItem
{
    //NSIndexPath *indexPath = [self.tableView indexPathForCell:delCell];
    int row = [self.todoArray indexOfObject:atodoItem];
    //[self.tableView beginUpdates];
    [self.todoArray removeObjectAtIndex:row];
    //[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    NSArray *visibleCells= self.tableView.visibleCells;
    UIView *lastView = [visibleCells lastObject];
    float delay = 0.3;
    BOOL startAnimation = false;
    for (ZXTableViewCell *zxCell in visibleCells) {
        if (startAnimation) {
            [UIView animateWithDuration:0.3 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
                zxCell.frame = CGRectOffset(zxCell.frame, 0, -zxCell.frame.size.height);
            } completion:^(BOOL finished){
                if (zxCell == lastView) {
                    [self.tableView reloadData];
                }
            }];
            delay+=0.03;
        }
        if (zxCell==delCell) {
            startAnimation = YES;
            delCell.hidden = YES;
        }
    }
    
    //[self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.2];
    //[self.tableView endUpdates];
}
*/
- (void)finishTheCell:(ZXToDoItem *)atodoItem
{
    //NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    int row = [self.todoArray indexOfObject:atodoItem];
    ZXToDoItem *todoItem =  [self.todoArray objectAtIndex:row];
    todoItem.finished = YES;
}

@end
