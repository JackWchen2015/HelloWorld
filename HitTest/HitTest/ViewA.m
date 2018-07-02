//
//  ViewA.m
//  HitTest
//
//  Created by admin on 2018/7/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewA.h"

@implementation ViewA

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* view=[super hitTest:point withEvent:event];
    if (view==self) {
        return nil;
    }
    return view;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"AAa");
}
@end
