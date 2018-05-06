#	iOS_DEMO

##		关联对象weak实现
关联对象里不支持weak关键字，但是有assign，weak实现的功能等于assign+nil，所以可以在关联对象A里再关联一个对象B，在B被dealloc的时候给A赋值nil。
##		Reference
[来点我呀！](https://blog.csdn.net/yan_1564335/article/details/53996538)