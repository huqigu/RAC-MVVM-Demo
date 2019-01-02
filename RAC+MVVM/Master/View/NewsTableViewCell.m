//
//  NewsTableViewCell.m
//  RAC+MVVM
//
//  Created by yellow on 2018/12/31.
//  Copyright © 2018 yellow. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
@interface NewsTableViewCell()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *mImageView;

@end

@implementation NewsTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *newsCellId = @"newsCell";
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellId];
    
    if (cell == nil) {
        
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsCellId];
        
        [cell addSubviews];
        
    }
    
    return cell;
    
}

- (void)addSubviews {
    
    self.mImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.mImageView];
    [self.mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(@-15);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.width.equalTo(@120);
        make.height.equalTo(self.mImageView.mas_width).multipliedBy(142.0 / 218.0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textColor = [UIColor blackColor];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self->_mImageView.mas_left).offset(-15);
        
    }];
    
    
    
    
}

- (void)setModel:(NewsModel *)model {
    
    _model = model;
    
    self.titleLabel.text = model.title;
    
    ImageInfo *info = model.newsImageInfoList[0];
    [self.mImageView sd_setImageWithURL:[NSURL URLWithString:info.url]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
