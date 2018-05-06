
//
//  NSObject+Assciotate.m
//  WeakAssociateObject
//
//  Created by 陈武 on 2018/5/6.
//  Copyright © 2018 陈武. All rights reserved.
//






#import "NSObject+Assciotate.h"
#import <objc/runtime.h>


typedef void(^DelBlock)(void);

@interface AssciotaNil:NSObject

@property(nonatomic,copy)DelBlock  delBlock;

-(instancetype)initWithBlock:(DelBlock)block;

@end

@implementation AssciotaNil


-(instancetype)initWithBlock:(DelBlock)block
{
    self=[super init];
    if (self) {
        self.delBlock=block;
    }
    return self;
}

-(void)dealloc
{
    _delBlock?_delBlock():nil;
    NSLog(@"called");
}
@end

@implementation NSObject (Assciotate)

-(void)setWeakObj:(id)idObj
{
    AssciotaNil* ObjNil=[[AssciotaNil alloc] initWithBlock:^{
        objc_setAssociatedObject(self,@selector(weakObj), nil,OBJC_ASSOCIATION_ASSIGN);
    }];
    objc_setAssociatedObject(idObj,(__bridge const void*) ObjNil.delBlock, ObjNil,OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, @selector(weakObj), idObj, OBJC_ASSOCIATION_ASSIGN);
}

-(id)weakObj
{
   return objc_getAssociatedObject(self, @selector(weakObj));
}
@end
