//
//  NewsModel.h
//  RAC+MVVM
//
//  Created by yellow on 2018/12/31.
//  Copyright © 2018 yellow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageInfo : NSObject

@property (nonatomic,copy) NSString *url;

@property (nonatomic,assign) float width;

@property (nonatomic,assign) float height;

@end


@interface NewsModel : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) NSArray *newsImageInfoList;

@end
