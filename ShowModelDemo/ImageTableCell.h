//
//  ImageTableCell.h
//  ShowModelDemo
//
//  Created by SLZX on 17/1/19.
//  Copyright © 2017年 SLZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView* iconView;
@property(nonatomic,strong)IBOutlet UILabel* nameLable;
-(void)setData:(NSDictionary*)dict;
@end
