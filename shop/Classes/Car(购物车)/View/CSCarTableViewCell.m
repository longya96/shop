//
//  CSCarTableViewCell.m
//  shop
//
//  Created by newtouch on 16/5/5.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSCarTableViewCell.h"


@interface CSCarTableViewCell ()

//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;
@property (nonatomic,retain) UIImageView *imageView;
//商品名
@property (nonatomic,retain) UILabel *nameLabel;
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
        self.backgroundColor = RGBCOLOR(245, 246, 248);
        [self setupMainView];
    }
    return self;
}
//选中按钮点击事件
-(void)selectBtnClick:(UIButton*)button
{
    button.selected = !button.selected;
    if (self.cartBlock) {
        self.cartBlock(button.selected);
    }
}

// 数量加按钮
-(void)addBtnClick
{
    if (self.numAddBlock) {
        self.numAddBlock();
    }
}

//数量减按钮
-(void)cutBtnClick
{
    if (self.numCutBlock) {
        self.numCutBlock();
    }
}

-(void)reloadDataWith:(CSCarModel*)model
{
    
    self.imageView.image = model.image;
    self.nameLabel.text = model.nameStr;
    self.priceLabel.text = model.price;
    self.dateLabel.text = model.dateStr;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)model.number];
    self.sizeLabel.text = model.sizeStr;
    self.selectBtn.selected = self.isSelected;
    
}
-(void)setupMainView
{
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = kUIColorFromRGB(0xEEEEEE).CGColor;
    bgView.layer.borderWidth = 1;
    [self addSubview:bgView];
    
    //照片背景
    self.imageView = [[UIImageView alloc]init];
    self.imageView.backgroundColor = kUIColorFromRGB(0xF3F3F3);
//    [bgView addSubview:self.imageView];
    
    
    //商品名
    self.nameLabel = [[UILabel alloc]init];
    //    self.nameLabel.text = @"海报";
    self.nameLabel.font = [UIFont systemFontOfSize:15];
//    [bgView addSubview:self.nameLabel];
    
    //尺寸
    self.sizeLabel = [[UILabel alloc]init];
    //    self.sizeLabel.text = @"尺寸:58*86cm";
    self.sizeLabel.textColor = RGBCOLOR(132, 132, 132);
    self.sizeLabel.font = [UIFont systemFontOfSize:12];
//    [bgView addSubview:self.sizeLabel];
    
    //时间
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.font = [UIFont systemFontOfSize:10];
    self.dateLabel.textColor = RGBCOLOR(132, 132, 132);
    //    self.dateLabel.text = @"2015-12-03 17:49";
//    [bgView addSubview:self.dateLabel];
    
    //价格
    self.priceLabel = [[UILabel alloc]init];
    //    self.priceLabel.text = @"￥100.11";
    self.priceLabel.font = [UIFont boldSystemFontOfSize:16];
    self.priceLabel.textColor = BASECOLOR_RED;
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
//    [bgView addSubview:self.priceLabel];
    
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_nomal"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_highlight"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:addBtn];
    
    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_nomal"] forState:UIControlStateNormal];
    [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_highlight"] forState:UIControlStateHighlighted];
    [cutBtn addTarget:self action:@selector(cutBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:cutBtn];
    
    //数量显示
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.text = @"1";
    self.numberLabel.font = [UIFont systemFontOfSize:15];
//    [bgView addSubview:self.numberLabel];
    
#pragma mark - 添加约束
    
    //白色背景
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self);
        make.right.equalTo(self).offset(-10);
        
    }];
    
        
    //图片背景
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(5);
        make.left.equalTo(self.selectBtn.mas_right).offset(5);
        make.bottom.equalTo(bgView).offset(-5);
        make.width.equalTo(self.imageView.mas_height);
    }];
    
    /*
    //商品名
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(10);
        make.top.equalTo(bgView).offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(self.priceLabel);
    }];
    
    //商品尺寸
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(5);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.height.equalTo(@20);
        make.width.equalTo(self.nameLabel);
    }];
    
    //时间
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(5);
        make.bottom.equalTo(bgView).offset(-5);
        make.height.equalTo(@20);
        make.right.equalTo(cutBtn.mas_left);
    }];
    
    //商品价格
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(5);
        make.right.equalTo(bgView);
        make.top.equalTo(bgView).offset(10);
        make.width.equalTo(self.nameLabel);
    }];
    
    //数量加按钮
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-5);
        make.bottom.equalTo(bgView).offset(-10);
        make.height.equalTo(@25);
        make.width.equalTo(@25);
    }];
    
    //数量显示
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addBtn.mas_left);
        make.bottom.equalTo(addBtn);
        make.width.equalTo(addBtn);
        make.height.equalTo(addBtn);
    }];
    
    //数量减按钮
    [cutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numberLabel.mas_left);
        make.height.equalTo(addBtn);
        make.width.equalTo(addBtn);
        make.bottom.equalTo(addBtn);
    }];
     */
}

@end
