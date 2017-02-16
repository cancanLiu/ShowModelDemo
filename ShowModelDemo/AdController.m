//
//  AdController.m
//  ShowModelDemo
//
//  Created by SLZX on 17/1/20.
//  Copyright © 2017年 SLZX. All rights reserved.
//
#define KDeviceWidth  [[UIScreen mainScreen] bounds].size.width
#define KDeviceHeight  [[UIScreen mainScreen] bounds].size.height

#import "AdController.h"
#import "HeaderView1.h"
@interface AdController ()

@end

@implementation AdController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel* tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, KDeviceWidth-60, 60)];
    tipLabel.numberOfLines = 0;
    tipLabel.text = @"这个页面将显示从广告跳转来的数据，可以是webView，也可以是自定义页面";
    tipLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:tipLabel];
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@"1" forKey:@"module_id"];
    [dict setValue:@"广告" forKey:@"module_name"];
    HeaderView1* head = [[HeaderView1 alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, 60)withDatas:dict];
    [self.view addSubview:head];
    
    UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, KDeviceWidth-200, 50)];
    button.backgroundColor = [UIColor orangeColor];
    button.layer.masksToBounds = YES;
    button.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);
    button.layer.borderWidth = 2;
    button.layer.cornerRadius = 5;
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(goBackView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)goBackView
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
