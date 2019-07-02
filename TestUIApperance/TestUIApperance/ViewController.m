//
//  ViewController.m
//  TestUIApperance
//
//  Created by JackChen on 2019/4/4.
//  Copyright © 2019 JackChen. All rights reserved.
//

#import "ViewController.h"
#import "CWCustom.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CWCustom*  customView=[[CWCustom alloc] initWithFrame:CGRectMake(100, 80, 200, 200)];
    customView.headerColor=[UIColor greenColor];
    [self.view addSubview: customView];
    
    
}


@end
