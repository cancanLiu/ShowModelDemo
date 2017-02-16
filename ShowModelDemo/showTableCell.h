//
//  showTableCell.h
//  ShowModelDemo
//
//  Created by SLZX on 17/1/19.
//  Copyright © 2017年 SLZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface showTableCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView* iconView;
@property(nonatomic,strong)IBOutlet UILabel* nameLabel;
@property(nonatomic,strong)IBOutlet UILabel* descriptsLabel;
-(void)setData:(NSDictionary*)dict;
@end
