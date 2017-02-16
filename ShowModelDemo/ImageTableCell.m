//
//  ImageTableCell.m
//  ShowModelDemo
//
//  Created by SLZX on 17/1/19.
//  Copyright © 2017年 SLZX. All rights reserved.
//

#import "ImageTableCell.h"

@implementation ImageTableCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setData:(NSDictionary *)dict
{
    self.nameLable.text = [NSString stringWithFormat:@"%@",dict[@"product_name"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
