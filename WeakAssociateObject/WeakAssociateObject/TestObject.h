//
//  TestObject.h
//  WeakAssociateObject
//
//  Created by 陈武 on 2018/5/6.
//  Copyright © 2018 陈武. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestObject : NSObject
@property(nonatomic,strong)id  strongObj;
@property(nonatomic,weak)id  wekObj;
@property(nonatomic,assign)id  assignObj;
@end
