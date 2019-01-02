//
//  ImagesTableViewCell.m
//  RAC+MVVM
//
//  Created by yellow on 2018/12/31.
//  Copyright © 2018 yellow. All rights reserved.
//

#import "ImagesTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface ImagesTableViewCell()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *mImageView0;

@property (nonatomic,strong) UIImageView *mImageView1;

@property (nonatomic,strong) UIImageView *mImageView2;

@end


@implementation ImagesTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *newsCellId = @"imagesCell";
    
    ImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellId];
    
    if (cell == nil) {
        
        cell = [[ImagesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsCellId];
        
        
        [cell addSubviews];
        
    }
    
    return cell;
    
}


- (void)addSubviews {
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textColor = [UIColor blackColor];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(@-15);
        
    }];
    
    
    CGFloat image0W = ([UIScreen mainScreen].bounds.size.width - 30 - 10) / 1176 * 376;
    CGFloat imageW = image0W * 400 / 376;
    
    self.mImageView0 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.mImageView0];
    [self.mImageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(image0W);
        make.height.equalTo(self.mImageView0.mas_width).multipliedBy(376.0 / 600.0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
    
    self.mImageView1 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.mImageView1];
    [self.mImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.mImageView0.mas_right).offset(5);
        make.top.equalTo(self.mImageView0.mas_top);
        make.width.mas_equalTo(imageW);
        make.height.equalTo(self.mImageView0.mas_height);
    }];

    self.mImageView2 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.mImageView2];
    [self.mImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.mImageView1.mas_right).offset(5);
        make.top.equalTo(self.mImageView0.mas_top);
        make.width.mas_equalTo(imageW);
        make.height.equalTo(self.mImageView0.mas_height);
    }];

}


- (void)setModel:(NewsModel *)model {
    
    _model = model;
    
    self.titleLabel.text = model.title;
    
    [self.mImageView0 sd_setImageWithURL:[model.newsImageInfoList[0] url]];
    [self.mImageView1 sd_setImageWithURL:[model.newsImageInfoList[1] url]];
    [self.mImageView2 sd_setImageWithURL:[model.newsImageInfoList[2] url]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
