//
//  ImagesTableViewCell.h
//  RAC+MVVM
//
//  Created by yellow on 2018/12/31.
//  Copyright © 2018 yellow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface ImagesTableViewCell : UITableViewCell

@property (nonatomic,strong) NewsModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
