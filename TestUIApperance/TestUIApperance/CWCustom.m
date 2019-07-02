//
//  CWCustom.m
//  TestUIApperance
//
//  Created by JackChen on 2019/4/4.
//  Copyright © 2019 JackChen. All rights reserved.
//

#import "CWCustom.h"



@interface CWCustom()

@property(nonatomic,strong)UIView* headerView;
@property(nonatomic,strong)UIView* bodyView;

@end

@implementation CWCustom

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self buildSubViews];
    }
    return self;
}

-(void)buildSubViews
{
    self.headerView=[UIView new];
    self.headerView.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2);
    [self  addSubview:self.headerView];
    
    self.bodyView=[UIView new];
    self.bodyView.frame=CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height/2);
    [self  addSubview:self.bodyView];
}




- (void)setHeaderColor:(UIColor *)headerColor
{
    _headerColor = headerColor;
    self.headerView.backgroundColor = _headerColor;
}

- (void)setBodyColor:(UIColor *)bodyColor
{
    _bodyColor = bodyColor;
    self.bodyView.backgroundColor = _bodyColor;
}

@end
