//
//  NewsModel.m
//  RAC+MVVM
//
//  Created by yellow on 2018/12/31.
//  Copyright © 2018 yellow. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"newsImageInfoList" : @"ImageInfo"};//前边，是属性数组的名字，后边就是类名
}

@end
