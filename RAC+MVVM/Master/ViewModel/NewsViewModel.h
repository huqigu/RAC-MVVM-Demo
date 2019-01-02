//
//  NewsViewModel.h
//  RAC+MVVM
//
//  Created by yellow on 2018/12/31.
//  Copyright © 2018 yellow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM (NSInteger, SlipType) {
    Down,
    Up
};

@interface NewsViewModel : NSObject

@property (nonatomic,strong) RACCommand *command;

@property (nonatomic,assign) SlipType type;

@end
