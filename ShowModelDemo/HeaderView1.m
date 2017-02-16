//
//  HeaderView1.m
//  ShowModelDemo
//
//  Created by SLZX on 17/1/19.
//  Copyright © 2017年 SLZX. All rights reserved.
//
#define KDeviceWidth  [[UIScreen mainScreen] bounds].size.width
#define KDeviceHeight  [[UIScreen mainScreen] bounds].size.height
#import "HeaderView1.h"
@interface HeaderView1()
{
    
}
@property(nonatomic,strong)UILabel* label;
@end
@implementation HeaderView1

-(instancetype)initWithFrame:(CGRect)frame withDatas:(NSDictionary*)dict
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor yellowColor];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(KDeviceWidth/2-30, 25, 60, 30)];
        self.label.text =[NSString stringWithFormat:@"%@",dict[@"module_name"]];
        self.label.textColor = [UIColor blueColor];
        self.label.font = [UIFont systemFontOfSize:17];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];

    }
    return self;
}
@end
