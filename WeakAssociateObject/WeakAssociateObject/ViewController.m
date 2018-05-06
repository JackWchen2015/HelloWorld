//
//  ViewController.m
//  WeakAssociateObject
//
//  Created by 陈武 on 2018/5/6.
//  Copyright © 2018 陈武. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Assciotate.h"
#import "TestObject.h"

@interface ViewController ()




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TestObject* testObj=[TestObject new];
    testObj.strongObj=[NSDate date];
//    testObj.wekObj=testObj.strongObj;
//    testObj.assignObj=testObj.strongObj;
//    testObj.strongObj=nil;
//    NSLog(@"strong obj %p",testObj.strongObj);
//    NSLog(@"weak obj %p",testObj.wekObj);

//    NSLog(@"assign obj %p",testObj.assignObj);
    
    
    testObj.wekObj=testObj.strongObj;
    testObj.weakObj=testObj.strongObj;
    testObj.strongObj=nil;
    NSLog(@"obj %p",testObj.wekObj);
    NSLog(@"weak obj %p",testObj.weakObj);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
