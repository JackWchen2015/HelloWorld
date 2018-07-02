//
//  ViewController.m
//  HitTest
//
//  Created by admin on 2018/7/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "ViewA.h"
#include "ViewB.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //ViewA 父view，屏幕上现在有一个viewA，viewA有一个subView叫做viewB，要求触摸viewB时,viewB会响应事件，而触摸viewA本身，不会响应该事件。
    
    ViewA*  viewAA=[[ViewA alloc] initWithFrame:CGRectMake(50, 80, 300, 200)];
    viewAA.backgroundColor=[UIColor redColor];
    [self.view addSubview:viewAA];
    
    
    ViewB*  viewBB=[[ViewB alloc] initWithFrame:CGRectMake(50, 10, 60, 150)];
    viewBB.backgroundColor=[UIColor blueColor];
    [viewAA addSubview:viewBB];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
