//
//  HeadView.m
//  Scroll_TableView
//
//  Created by on 2017/6/19.
//  Copyright © 2017年. All rights reserved.
//

#import "HeadView.h"

@interface HeadView ()
{
    UIButton *temBtn;
}

@property (nonatomic,strong)UIView *Line;

@end


@implementation HeadView
-(UIView *)Line{
    if (!_Line) {
        
        _Line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width / 3, 1)];
        
        _Line.backgroundColor = [UIColor redColor];
        
    }
    return _Line;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height - 40)];
    
    imgView.image = [UIImage imageNamed:@"11.jpg"];
    
    [self addSubview:imgView];
    
    CGFloat y = CGRectGetMaxY(imgView.frame);
    
    [self addSubview:[self creatButton:CGRectMake(0, y, self.frame.size.width/3, 39) :@"想你的夜" :120]];
    
    [self addSubview:[self creatButton:CGRectMake(self.frame.size.width/3, y, self.frame.size.width/3, 39) :@"多希望你" :121]];
    
    [self addSubview:[self creatButton:CGRectMake(self.frame.size.width*2/3, y, self.frame.size.width/3, 39) :@"能在我身边" :122]];
    
    [self addSubview:self.Line];
    
}


-(UIButton *)creatButton:(CGRect)frame :(NSString *)title :(NSInteger)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = frame;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    if (tag == 120){
        temBtn = btn;
        btn.selected = YES;
    }
    
    btn.tag = tag;
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

-(void)btnClick:(UIButton *)btn{
    
    temBtn.selected = NO;
    btn.selected = YES;
    temBtn = btn;
    
    if (_delegate && [_delegate respondsToSelector:@selector(HeadViewSelectedBtutton:)]) {
        [_delegate HeadViewSelectedBtutton:btn.tag - 120];
    }
    
    switch (btn.tag) {
        case 120:
            [self setBottomLine:0];
            break;
        case 121:
            [self setBottomLine:self.frame.size.width / 3];
            break;
        case 122:
            [self setBottomLine:self.frame.size.width*2 / 3];
            break;
            
        default:
            break;
    }
}


-(void)setBottomLine:(CGFloat)x{
    
    CGRect rect = self.Line.frame;
    
    rect.origin.x = x;
    
    [UIView animateWithDuration:0.23 animations:^{
        
        self.Line.frame = rect;
        
    }];
}

-(void)headViewUpdateBottomLineState:(int)indexs{
    
    temBtn.selected = NO;
    UIButton *btn = (UIButton *)[self viewWithTag:120 + indexs];
    btn.selected = YES;
    temBtn = btn;
    
    [self setBottomLine:self.frame.size.width *indexs / 3];
    
}

@end
