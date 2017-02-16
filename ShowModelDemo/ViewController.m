//
//  ViewController.m
//  ShowModelDemo
//
//  Created by SLZX on 17/1/10.
//  Copyright © 2017年 SLZX. All rights reserved.
//

#import "ViewController.h"
#import "CCCycleScrollView.h"
#import "QuickKeyCell.h"
#import "HeaderView.h"
#import "FootView.h"
#import "showTableCell.h"
#import "ImageTableCell.h"
#import "HeaderView1.h"
#import "AdController.h"
#import "itemViewController.h"
#define KDeviceWidth  [[UIScreen mainScreen] bounds].size.width
#define KDeviceHeight  [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,CCCycleScrollViewClickActionDeleage,itemClickActionDelegate>
{
    UITableView* _tableView;
}
//广告模板
@property(nonatomic,strong)CCCycleScrollView* cyclePlayView;
//全部数据
@property (nonatomic,strong) NSDictionary *dataDict;
//页头数据
@property (nonatomic,strong) NSDictionary *headersDict;
//页尾数据
@property (nonatomic,strong) NSDictionary *footDict;
//模板列表数据
@property (nonatomic,strong) NSArray *moduleArr;
//广告数据
@property (nonatomic,strong) NSArray *AdDict;
@property (nonatomic,strong) NSArray *goodsArr;
@property (nonatomic,strong) NSArray *keyArr;
@property(nonatomic,strong)UISearchBar* searchBar;
@property (assign, nonatomic) int Num;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTableView];
    self.navigationController.navigationBarHidden = NO;
    self.Num =2;
    [self loadNetData];
    [self setheaderView];
    
    [self setFootView];
    
}
//创建页头视图
-(void)setheaderView
{
    if ([self.headersDict[@"module_id"] isEqualToString:@"1"]) {
        HeaderView* head = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, 60)];
        self.searchBar = head.searchBar;
        [self.view addSubview:head];
    }else
    {
        HeaderView1* head = [[HeaderView1 alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, 60)withDatas:self.headersDict];
        [self.view addSubview:head];
    }
    
}
//创建页尾视图
-(void)setFootView
{
    NSMutableArray *titleArr = [[NSMutableArray alloc]init];
    NSArray* array = self.footDict[@"itemList"];
    for (NSInteger i = 0; i < array.count; ++i ){
        NSDictionary* dict =array[i];
        [titleArr addObject:dict[@"item_name"]];
    }
    if ([self.footDict[@"isShow"] isEqualToString:@"1"]) {
        FootView* footView = [[FootView alloc]initWithFrame:CGRectMake(0, KDeviceHeight-60, KDeviceWidth, 60) withData:titleArr];
        footView.delegate = self;
        [self.view addSubview:footView];

    }else
    {
    FootView* footView = [[FootView alloc]initWithFrame:CGRectMake(0, KDeviceHeight, KDeviceWidth, 60) withData:titleArr];
    footView.delegate = self;
    [self.view addSubview:footView];
    
    }
}
//创建模板列表
-(void)setUpTableView
{
   
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, KDeviceWidth, KDeviceHeight-100)];
      
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIView* view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, 0)];
    _tableView.tableFooterView = view;
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.moduleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section==(self.moduleArr.count-1)) {
        if (self.Num<self.goodsArr.count) {
            return self.Num;
        }
        return self.goodsArr.count;
    }
        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==(self.moduleArr.count-1)) {
        return 80;
    }
    return 200;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == (self.moduleArr.count-1)) {
         cell = [self tableView:tableView tagCellForRowAtIndexPath:indexPath];
    }else if(indexPath.section == 0)
    {
        NSMutableArray *images = [[NSMutableArray alloc]init];
        //接收广告标题
        NSMutableArray *titleArr = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < self.AdDict.count; ++i ){
            NSDictionary* dict =self.AdDict[i];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dict[@"ad_pic"]]];
            [images addObject:image];
        }
        self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images withFrame:CGRectMake(0, 0, KDeviceWidth, 200)];
        for (NSInteger i = 0; i < self.AdDict.count; ++i ){
            NSDictionary* dict =self.AdDict[i];
            [titleArr addObject:dict[@"ad_title"]];
        }
        self.cyclePlayView.pageDescrips = titleArr;
        self.cyclePlayView.delegate = self;
        if ([self.dataDict[@"moduleList"][0][@"module_id"] isEqualToString:@"1"]) {
            self.cyclePlayView.pageLocation = CCCycleScrollPageViewPositionBottomLeft;
        }else
        {
            self.cyclePlayView.pageLocation = CCCycleScrollPageViewPositionBottomRight;
        }
        self.cyclePlayView.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:self.cyclePlayView];

    }else if(indexPath.section == 1)
    {
        cell = [self tableView:tableView quickKeyCellForRowAtIndexPath:indexPath];
    }else
    {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, 200)];
        view.backgroundColor = [UIColor yellowColor];
        [cell.contentView addSubview:view];
    }
    /*
    switch (indexPath.section) {
        case 0:
         {
             //接收广告图片
             NSMutableArray *images = [[NSMutableArray alloc]init];
             //接收广告标题
             NSMutableArray *titleArr = [[NSMutableArray alloc]init];
             for (NSInteger i = 0; i < self.AdDict.count; ++i ){
                 NSDictionary* dict =self.AdDict[i];
                 UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dict[@"ad_pic"]]];
                    [images addObject:image];
             }
             self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images withFrame:CGRectMake(0, 0, KDeviceWidth, 200)];
             for (NSInteger i = 0; i < self.AdDict.count; ++i ){
                 NSDictionary* dict =self.AdDict[i];
                 [titleArr addObject:dict[@"ad_title"]];
             }
             self.cyclePlayView.pageDescrips = titleArr;
             self.cyclePlayView.delegate = self;
             if ([self.dataDict[@"moduleList"][0][@"module_id"] isEqualToString:@"1"]) {
                 self.cyclePlayView.pageLocation = CCCycleScrollPageViewPositionBottomLeft;
             }else
             {
                 self.cyclePlayView.pageLocation = CCCycleScrollPageViewPositionBottomRight;
             }
             self.cyclePlayView.backgroundColor = [UIColor grayColor];
             [cell.contentView addSubview:self.cyclePlayView];

         }
            break;
        case 1:
         {
              cell = [self tableView:tableView quickKeyCellForRowAtIndexPath:indexPath];
         }
            break;
        case 2:
        {
            cell = [self tableView:tableView tagCellForRowAtIndexPath:indexPath];
        }
            break;
                default:
            break;
    }
     **/
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView tagCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    showTableCell* cell1 = nil;
    ImageTableCell* cell2 = nil;
    if (cell == nil) {
        if ([self.moduleArr[2][@"module_id"] isEqualToString:@"1"]) {
            cell1 = [[[NSBundle mainBundle]loadNibNamed:@"showTableCell" owner:self options:nil]lastObject];
            [cell1 setData:self.goodsArr[indexPath.row]];
            cell=cell1;
        }else
        {
            cell2 = [[[NSBundle mainBundle]loadNibNamed:@"ImageTableCell" owner:self options:nil]lastObject];
            [cell2 setData:self.goodsArr[indexPath.row]];
            cell = cell2;
        }
    
    }

    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView quickKeyCellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    QuickKeyCell* cell = [tableView dequeueReusableCellWithIdentifier:@"QuickKeyCell"];
    if (cell == nil) {
        cell = [[QuickKeyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuickKeyCell"];
    }
    cell.quickKeys = self.keyArr;
    return cell;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    self.Num++;
    if (self.Num == self.goodsArr.count) {
        NSLog(@"已经没有更多商品了");
    }
    [self.searchBar resignFirstResponder];
    [_tableView reloadData];
}
-(void)loadNetData
{
    NSString* pathString = [[NSBundle mainBundle]pathForResource:@"localData" ofType:@"json"];
    NSData* data = [[NSData alloc]initWithContentsOfFile:pathString];
    self.dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.headersDict=self.dataDict[@"headers"];
    self.footDict = self.dataDict[@"foot"];
    self.moduleArr = self.dataDict[@"moduleList"];
    NSLog(@"头部视图数据==%@",self.headersDict);
    NSLog(@"底部视图数据==%@",self.footDict);
    
    NSString* AdString=[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",self.moduleArr[0][@"module_url"]] ofType:@"json"];
    NSData* adData = [[NSData alloc]initWithContentsOfFile:AdString];
    self.AdDict = [NSJSONSerialization JSONObjectWithData:adData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"广告数据==%@",self.AdDict);
    
    NSString* goodsString=[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",self.moduleArr[2][@"module_url"]] ofType:@"json"];
    NSData* goodsData = [[NSData alloc]initWithContentsOfFile:goodsString];
    self.goodsArr = [NSJSONSerialization JSONObjectWithData:goodsData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"商品列表==%@",self.goodsArr);
    
    NSString* keyString=[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",self.moduleArr[1][@"module_url"]] ofType:@"json"];
    NSData* keyData = [[NSData alloc]initWithContentsOfFile:keyString];
    self.keyArr = [NSJSONSerialization JSONObjectWithData:keyData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"快捷键列表==%@",self.keyArr);

}
#pragma mark ----轮播delegate
-(void)cyclePageClickAction:(NSInteger)clickIndex
{
    NSLog(@"点击了%ld",clickIndex);
    AdController* advc = [[AdController alloc]init];
    [self presentViewController:advc animated:YES completion:^{
        
    }];
}
#pragma mark -----底部视图delegate
-(void)itemClickAction:(NSInteger)clickIndex
{
    itemViewController* item = [[itemViewController alloc]init];
    item.itemDict = self.footDict[@"itemList"][clickIndex];
    [self presentViewController:item animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
