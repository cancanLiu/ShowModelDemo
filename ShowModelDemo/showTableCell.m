//
//  showTableCell.m
//  ShowModelDemo
//
//  Created by SLZX on 17/1/19.
//  Copyright © 2017年 SLZX. All rights reserved.
//

#import "showTableCell.h"

@implementation showTableCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setData:(NSDictionary *)dict
{
    self.nameLabel.text = [NSString stringWithFormat:@"%@",dict[@"product_name"]];
    self.descriptsLabel.text = [NSString stringWithFormat:@"%@",dict[@"product_info"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
