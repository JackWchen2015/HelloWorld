//
//  LPListViewController.h
//  LosslessPlayer
//
//  Created by Jack Chen on 2020/4/14.
//  Copyright © 2020 JackChen. All rights reserved.
//

#import "LPBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^selectListItem)(NSString*);

@interface LPListViewController : LPBasicViewController
@property(nonatomic,copy)selectListItem  selecBlock;
@end

NS_ASSUME_NONNULL_END
