//
//  LPListViewController.m
//  LosslessPlayer
//
//  Created by Jack Chen on 2020/4/14.
//  Copyright © 2020 JackChen. All rights reserved.
//

#import "LPListViewController.h"



@interface LPListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableList;
@property(nonatomic,strong)NSArray* arrList;
@end

@implementation LPListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self buildTableView];
    [self loadList];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)loadList
{
    self.arrList=  [[NSFileManager defaultManager] subpathsAtPath:AirDropPath];
    [self.tableList reloadData];
}


-(void)buildTableView
{
    UIButton* dissBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [dissBtn setTitle:@"退出" forState:UIControlStateNormal];
    [dissBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:dissBtn];
    [dissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
    }];
    
    [[dissBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    
    self.tableList=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableList.delegate=self;
    self.tableList.dataSource=self;
    [self.view addSubview:self.tableList];
    
    [self.tableList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(dissBtn.mas_bottom).offset(20);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.textLabel.text=self.arrList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.selecBlock(self.arrList[indexPath.row]);
    }];
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction* shareAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"共享" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        //分享歌曲
        NSString* path=self.arrList[indexPath.row];
        NSString* contentPath=[NSString stringWithFormat:@"file://%@/%@",AirDropPath,path];
        NSURL* contentUrl=[NSURL fileURLWithPath:contentPath];
        UIActivityViewController* shareVC=[[UIActivityViewController alloc] initWithActivityItems:@[contentUrl] applicationActivities:nil];
        [self presentViewController:shareVC animated:YES completion:nil];
        
    }];
    return @[shareAction];
}
@end
