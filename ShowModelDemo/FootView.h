//
//  FootView.h
//  ShowModelDemo
//
//  Created by SLZX on 17/1/18.
//  Copyright © 2017年 SLZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol itemClickActionDelegate <NSObject>

-(void)itemClickAction:(NSInteger)clickIndex;

@end

@interface FootView : UIView
@property(nonatomic,weak)id<itemClickActionDelegate>delegate;

-(id)initWithFrame:(CGRect)frame withData:(NSArray*)array;
-(id)initWithFrame:(CGRect)frame;
@end
