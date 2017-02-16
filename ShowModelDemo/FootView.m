//
//  FootView.m
//  ShowModelDemo
//
//  Created by SLZX on 17/1/18.
//  Copyright © 2017年 SLZX. All rights reserved.
//

#define itemWidth 50
#define itemHeight 30

#define KDeviceWidth  [[UIScreen mainScreen] bounds].size.width
#define KDeviceHeight  [[UIScreen mainScreen] bounds].size.height

#import "FootView.h"


@interface FootView()
{
    
}
@property(nonatomic,strong)NSMutableArray* datasArray;
@property(nonatomic,strong)UILabel* label;
@end

@implementation FootView
-(id)initWithFrame:(CGRect)frame withData:(NSMutableArray*)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.datasArray = array;
        [self addUI];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)addUI
{
    
    for (int i = 1; i<=self.datasArray.count; i++) {
        CGFloat space = (KDeviceWidth-itemWidth*self.datasArray.count)/(self.datasArray.count+1);
        UIButton* button = [[UIButton alloc]init];
        button.frame = CGRectMake(space*i+itemWidth*(i-1), 20, itemWidth, itemHeight);
        button.tag =i;
        [button setTitle:[NSString stringWithFormat:@"%@",self.datasArray[i-1]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
-(void)clickAction:(UIButton*)button
{
    if ([self.delegate respondsToSelector:@selector(itemClickAction:)]) {
        [self.delegate itemClickAction:button.tag-1];
    }else
    {
        NSLog(@"没有设置代理");
    }
}
@end
