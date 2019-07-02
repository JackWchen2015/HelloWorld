//
//  CWCustom.h
//  TestUIApperance
//
//  Created by JackChen on 2019/4/4.
//  Copyright © 2019 JackChen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CWCustom : UIView
@property (nonatomic, strong) UIColor *headerColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *bodyColor UI_APPEARANCE_SELECTOR;
@end

NS_ASSUME_NONNULL_END
