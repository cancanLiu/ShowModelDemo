//
//  HeaderView1.h
//  ShowModelDemo
//
//  Created by SLZX on 17/1/19.
//  Copyright © 2017年 SLZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView1 : UIView
@property(nonatomic,strong)NSDictionary* dataDict;
-(instancetype)initWithFrame:(CGRect)frame withDatas:(NSDictionary*)dict;
@end
