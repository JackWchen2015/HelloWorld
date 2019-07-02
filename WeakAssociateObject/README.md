#	iOS_Demo

##	 关联对象weak实现


* 关联对象里不支持weak关键字，但是有assign，weak实现的功能等于assign+nil，所以可以在关联对象A里再关联一个对象B，在B被dealloc的时候给A赋值nil。
[参考](https://blog.csdn.net/yan_1564335/article/details/53996538)

* OBJC_ASSOCIATION_ASSIGN 不会在属性清空后将引用指针清空，这会造成野指针，所以是由风险去访问一个已经被清除的对象的。但是我们可以用另外的一种方法来关联一个weak属性，那就是强关联一个对象，然后让这个对象来弱引用这个属性.[参考](https://github.com/helloted/stackoverflow_top_ios/blob/master/content/using-objc-setassociatedobject-with-weak-references.md)

```objc
@interface WeakObjectContainer : NSObject
@property (nonatomic, readonly, weak) id object;
@end

@implementation WeakObjectContainer
- (instancetype) initWithObject:(id)object
{
    if (!(self = [super init]))
        return nil;

    _object = object;

    return self;
}
@end
```
把WeakObjectContainer对象用OBJC_ASSOCIATION_RETAIN_NONATOMIC强关联

```objc
objc_setAssociatedObject(self, &MyKey, [[WeakObjectContainer alloc] initWithObject:object], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
```
```objc
id object = [objc_getAssociatedObject(self, &MyKey) object];
```