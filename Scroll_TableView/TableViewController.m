//
//  TableViewController.m
//  Scroll_TableView
//
//  Created by 廖磊 on 2017/6/19.
//  Copyright © 2017年 廖磊. All rights reserved.
//

#import "TableViewController.h"

#define WD [UIScreen mainScreen].bounds.size.width
#define HG [UIScreen mainScreen].bounds.size.height

@interface TableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TableViewController

-(UITableView *)tbView{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WD, HG)];
        _tbView.delegate   = self;
        _tbView.dataSource = self;
        _tbView.showsVerticalScrollIndicator = NO;
        [_tbView registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"cell"];
    }
    return _tbView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initView];
    
}

-(void)initView{
    
    [self.view addSubview:self.tbView];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 240;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"春暖花开-%d-%d",(int)self.view.tag - 10,(int)indexPath.row];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat f = scrollView.contentOffset.y;
    if (_delegate && [_delegate respondsToSelector:@selector(TableViewControllerScrollto:)]) {
        [_delegate TableViewControllerScrollto:f];
    }
}

@end
