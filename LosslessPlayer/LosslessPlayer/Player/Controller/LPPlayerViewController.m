//
//  LPPlayerViewController.m
//  LosslessPlayer
//
//  Created by Jack Chen on 2020/4/14.
//  Copyright © 2020 JackChen. All rights reserved.
//

#import "LPPlayerViewController.h"
#import "LPListViewController.h"
#import "LPAVPlayerManager.h"
#import "LPAudioManager.h"
@interface LPPlayerViewController ()

@end

@implementation LPPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
//    [self playMusic];
}

-(void)buildUI
{

    
    UIButton* btnFind=[UIButton buttonWithType:UIButtonTypeCustom];
    [[btnFind rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        LPListViewController* listVC=[LPListViewController new];
        listVC.selecBlock = ^(NSString * _Nonnull selectList) {
            NSString* path=[AirDropPath stringByAppendingPathComponent:selectList];
            [[LPAVPlayerManager sharedInstance] playMusicWithPath:[NSURL fileURLWithPath:path]];
            
        };
        [self presentViewController:listVC animated:YES completion:^{
            
        }];
    }];
    
    [btnFind setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnFind setTitle:@"本地查找" forState:UIControlStateNormal];
    [self.view addSubview:btnFind];
    [btnFind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    
    UIButton* btnPlay=[UIButton buttonWithType:UIButtonTypeCustom];
    [[btnPlay rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[LPAVPlayerManager sharedInstance] playMusicWithPath:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"chen" ofType:@"mp3"]]];
    }];
    [btnPlay setTitle:@"试听" forState:UIControlStateNormal];
    [btnPlay setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btnPlay];
    [btnPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(btnFind.mas_top).offset(-15);
    }];
    
    UIButton* btnRecord=[UIButton buttonWithType:UIButtonTypeCustom];
    [[btnRecord rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable btn) {
       //录音
        [btn setTitle:@"取消录音" forState:UIControlStateNormal];
        BOOL exist=[[NSFileManager defaultManager] fileExistsAtPath:AudioRecordPath];
        if (!exist) {
            [[NSFileManager defaultManager] createDirectoryAtPath:AudioRecordPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        NSString* path=[AudioRecordPath stringByAppendingPathComponent:@"test.wav"];
        NSURL* pathUrl=[NSURL fileURLWithPath:path];
        [[LPAudioManager sharedInstance] recordWithPath:pathUrl];
    }];
    [[btnRecord rac_signalForControlEvents:UIControlEventTouchUpOutside] subscribeNext:^(__kindof UIButton * _Nullable btn) {
        //结束
        [btn setTitle:@"开始录音" forState:UIControlStateNormal];
        [[LPAudioManager sharedInstance] stropRecord];
    }];
    [btnRecord setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnRecord setTitle:@"开始录音" forState:UIControlStateNormal];
    [self.view addSubview:btnRecord];
    [btnRecord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(btnFind.mas_bottom).offset(15);
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
