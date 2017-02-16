//
//  HeaderView.m
//  ShowModelDemo
//
//  Created by SLZX on 17/1/18.
//  Copyright © 2017年 SLZX. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView()<UISearchBarDelegate>
{
    
}
@property(nonatomic,strong)UILabel* label;

@end

@implementation HeaderView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 60, 30)];
        self.label.text =@"搜索";
        self.label.textColor = [UIColor blueColor];
        self.label.font = [UIFont systemFontOfSize:15];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(80, 25, 200, 30)];
        self.searchBar.delegate =self;
        self.searchBar.backgroundColor= [UIColor clearColor];
        self.searchBar.keyboardType = UIReturnKeyDone;
        self.searchBar.layer.cornerRadius = 5;
        self.searchBar.layer.masksToBounds = YES;
        [self.searchBar.layer setBorderWidth:8];
        [self.searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
        
        self.searchBar.placeholder = @"|搜索你想要的东西";
        [self addSubview:self.searchBar];
    }
    return self;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}
@end
