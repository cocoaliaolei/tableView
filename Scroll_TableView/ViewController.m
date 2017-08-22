//
//  ViewController.m
//  Scroll_TableView
//
//  Created by on 2017/6/19.
//  Copyright © 2017年. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "HeadView.h"

#define WD [UIScreen mainScreen].bounds.size.width
#define HG [UIScreen mainScreen].bounds.size.height
#define count 3



@interface ViewController ()<TableViewControllerDelegate,HeadViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrolView;
@property (nonatomic,strong)NSMutableArray *aray;
@property (nonatomic,strong)HeadView *hView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
-(UIScrollView *)scrolView{
    
    if (!_scrolView) {
        
        _scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WD, HG)];
        _scrolView.pagingEnabled = YES;
        _scrolView.bounces = NO;
        _scrolView.delegate = self;
        _scrolView.contentSize = CGSizeMake(count * WD, HG);
        
    }
    return _scrolView;
}
-(HeadView *)hView{
    if (!_hView) {
        _hView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, WD, 240)];
        _hView.delegate = self;
    }
    return _hView;
}

-(NSMutableArray *)aray{
    
    if (!_aray) {
        _aray = [[NSMutableArray alloc]init];
    }
    return _aray;
}

-(void)initView{
    
    
    [self creatScrollView];
    
    [self creatTableView];
    
    [self creatHeadView];
    
    
}

-(void)creatScrollView{
    
    [self.view addSubview:self.scrolView];
    
}

-(void)creatHeadView{
    
    
    
    [self.view addSubview:self.hView];
    
    
}
#pragma mark - HeadViewDelegate
-(void)HeadViewSelectedBtutton:(NSInteger)indexs{
    
    [_scrolView scrollRectToVisible:CGRectMake(indexs *_scrolView.frame.size.width, 0,_scrolView.frame.size.width, _scrolView.frame.size.height) animated:YES];
    
}
#pragma mark - ScrollDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int pageNo = scrollView.contentOffset.x/WD;
    
    [_hView headViewUpdateBottomLineState:pageNo];
}


-(void)creatTableView{
    
    for (int i = 0; i < count; i ++) {
        
        TableViewController *tbCtl = [[TableViewController alloc]init];
        
        tbCtl.delegate = self;
        
        [self.aray addObject:tbCtl];
        
        tbCtl.view.frame = CGRectMake(i * WD, 0, WD, HG);
        
        tbCtl.view.tag = 10 + i;
        
        [self.scrolView addSubview:tbCtl.view];
        
    }
    
}
#pragma mark - TableViewContrllerDelegate
-(void)TableViewControllerScrollto:(CGFloat)locattionY {
    
    NSLog(@":%f",locattionY);
    
    CGRect rect = _hView.frame;
    rect.origin.y = - locattionY;
    if (locattionY >= 200) rect.origin.y = - 200;
    _hView.frame = rect;
    
    if (locattionY <= 200 && locattionY >=0) {
        
        for (TableViewController *tbCtl in _aray) {
            tbCtl.tbView.contentOffset = CGPointMake(0, locattionY);
        }

    }
    
}

@end
