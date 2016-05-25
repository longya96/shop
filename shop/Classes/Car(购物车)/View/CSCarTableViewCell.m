//
//  CSCarTableViewCell.m
//  shop
//
//  Created by newtouch on 16/5/5.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSCarTableViewCell.h"


@interface CSCarTableViewCell ()

@property (nonatomic,retain) UIImageView *goodImageView;
//商品名
@property (nonatomic,retain) UILabel *nameLabel;
//数量
@property (nonatomic,retain) UILabel *numberLabel;
//尺寸
@property (nonatomic,retain) UILabel *sizeLabel;
//时间
@property (nonatomic,retain) UILabel *dateLabel;
//价格
@property (nonatomic,retain) UILabel *priceLabel;

@end

@implementation CSCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(245, 246, 248);
        [self setupMainView];
    }
    return self;
}

-(void)reloadDataWith:(CSCarModel*)model
{
    
    self.goodImageView.image = model.image;
    self.nameLabel.text = model.nameStr;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    self.dateLabel.text = model.dateStr;
    self.numberLabel.text = [NSString stringWithFormat:@"x%ld",(long)model.number];
    self.sizeLabel.text = model.sizeStr;
    
}

-(void)setupMainView
{
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    //照片背景
    self.goodImageView = [[UIImageView alloc]init];
    [bgView addSubview:self.goodImageView];
    
    //商品名
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = [UIFont systemFontOfSize:17];
    [bgView addSubview:self.nameLabel];
    

    //尺寸
    self.sizeLabel = [[UILabel alloc]init];
    self.sizeLabel.textColor = RGB(132, 132, 132);
    self.sizeLabel.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:self.sizeLabel];
    
    //数量显示
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.text = [NSString stringWithFormat:@"x%d",1];
    self.numberLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:self.numberLabel];
    
    //价格
    self.priceLabel = [[UILabel alloc]init];
    //    self.priceLabel.text = @"￥100.11";
    self.priceLabel.font = [UIFont boldSystemFontOfSize:16];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:self.priceLabel];
    
    //时间
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.font = [UIFont systemFontOfSize:10];
    self.dateLabel.textColor = RGB(132, 132, 132);
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:self.dateLabel];
    
#pragma mark - 添加约束
    
    //白色背景
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(2);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        
    }];
    
    
    //图片背景
    [self.goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(5);
        make.left.equalTo(bgView).offset(5);
        make.bottom.equalTo(bgView).offset(-5);
        make.width.equalTo(self.goodImageView.mas_height);
    }];
    
    //商品名
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageView.mas_right).offset(10);
        make.top.equalTo(bgView).offset(10);
        make.height.equalTo(@30);
        make.right.equalTo(bgView).offset(-10);
    }];
    
    //商品尺寸
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageView.mas_right).offset(10);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.height.equalTo(@20);
        make.width.equalTo(self.nameLabel).multipliedBy(0.85);
    }];
    
    //数量显示
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sizeLabel.mas_right);
        make.right.equalTo(bgView).offset(-5);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.height.equalTo(self.sizeLabel);
    }];
    
    //商品价格
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageView.mas_right).offset(10);
        make.bottom.equalTo(bgView).offset(-10);
        make.width.equalTo(self.nameLabel).multipliedBy(0.7);
    }];
    
    //时间
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right);
        make.bottom.equalTo(bgView).offset(-10);
        make.right.equalTo(bgView).offset(-5);
    }];
    
    
}

@end
