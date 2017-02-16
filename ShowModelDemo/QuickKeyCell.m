//
//  QuickKeyCell.m
//  ShowModelDemo
//
//  Created by SLZX on 17/1/18.
//  Copyright © 2017年 SLZX. All rights reserved.
//
#define KDeviceWidth  [[UIScreen mainScreen] bounds].size.width
#define KDeviceHeight  [[UIScreen mainScreen] bounds].size.height
#import "QuickKeyCell.h"
#import "ItemCollectionViewCell.h"
@interface QuickKeyCell()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView* _collectionView;
    UICollectionViewFlowLayout* _layout;
}

@end

@implementation QuickKeyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        [self addCollectionView];
    }
    
    return self;
}
-(void)addCollectionView
{

    _layout = [[UICollectionViewFlowLayout alloc]init];
    float width=(KDeviceWidth-5)/4;
    float height=100;
    _layout.itemSize = CGSizeMake(width, height);
    _layout.minimumLineSpacing = 1;
    _layout.minimumInteritemSpacing = 1;
//    _layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    _layout.headerReferenceSize = CGSizeMake(10, 10);
//    _layout.footerReferenceSize = CGSizeMake(10, 10);
    _layout.scrollDirection =0;
   
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,KDeviceWidth , 250) collectionViewLayout:_layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate =self;
    _collectionView.dataSource = self;
    [self.contentView addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"ItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"itemCell"];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.quickKeys.count<8)
    {
       return self.quickKeys.count;
    }
       return 8;
}
-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell* cocell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
    if (cocell == nil) {
        cocell = [[[NSBundle mainBundle]loadNibNamed:@"ItemCollectionViewCell" owner:self options:nil]lastObject];
    }
    if (self.quickKeys.count<8) {
        cocell.label.text = [NSString stringWithFormat:@"%@",self.quickKeys[indexPath.row][@"key_name"]];
        cocell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.quickKeys[indexPath.row][@"key_pic"]]];
    }else
    {
        if (indexPath.row<7) {
            cocell.label.text = [NSString stringWithFormat:@"%@",self.quickKeys[indexPath.row][@"key_name"]];
            cocell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.quickKeys[indexPath.row][@"key_pic"]]];
        }else if(indexPath.row == 7)
        {
            cocell.label.text = @"更多";
        }
    }
    return cocell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell* cell =(ItemCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectedBackgroundView.backgroundColor=[UIColor  lightGrayColor];
    [collectionView deselectItemAtIndexPath:indexPath animated:true];
    if (self.quickKeys.count<8) {
        NSLog(@"点击了%@",self.quickKeys[indexPath.row][@"key_name"]);
    }else
    {
        if(indexPath.row == 7)
        {
            NSLog(@"点击了更多");
        }else
        {
            NSLog(@"点击了%@",self.quickKeys[indexPath.row][@"key_name"]);
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KDeviceWidth-5)/4, 100);
}
@end
