//
//  NewsViewModel.m
//  RAC+MVVM
//
//  Created by yellow on 2018/12/31.
//  Copyright © 2018 yellow. All rights reserved.
//

#import "NewsViewModel.h"
#import "AFNetworking.h"
#import "NewsModel.h"
#import "MJExtension.h"
@interface NewsViewModel()

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation NewsViewModel

- (NSMutableArray *)dataSource {
    
    if (_dataSource == nil) {
        _dataSource  = [NSMutableArray array];
    }
    
    return _dataSource;
}


- (instancetype)init {
    
    //    https://api.5wuli.com/v2/message/list?&channelId=30&cursor=1546232752819&slipType=DOWN
    //    https://api.5wuli.com/v2/message/list?&channelId=30&cursor=1546254024769&slipType=UP
    
    if (self = [super init]) {
        
        [self initCommand];
        
    }
    
    return self;
}

- (void)initCommand {
    
    @weakify(self)
    self.command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
       @strongify(self)
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           @strongify(self)
            
            [self getDataWithSlipType:self.type successBlock:^{
                
                @strongify(self)
                [subscriber sendNext:self.dataSource];
                [subscriber sendCompleted];
                
            }];

            return nil;
        }];
    }];
    
}


- (void)getDataWithSlipType:(SlipType)type successBlock:(void(^)(void))success {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *slipType = type ? @"UP" : @"DOWN";
    
    if (type == Down) {
        [self.dataSource removeAllObjects];
    }
    
    NSString *url = [NSString stringWithFormat:@"https://api.5wuli.com/v2/message/list?&channelId=30&cursor=%@&slipType=%@",[self getCurrentTimes],slipType];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [responseObject objectForKey:@"data"];
        
        for (NSDictionary *dict in array) {
            NewsModel *model = [NewsModel mj_objectWithKeyValues:dict];
            [self.dataSource addObject:model];
        }
        
        success();
        
    } failure:nil];
    
}

- (NSString*)getCurrentTimes {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;

}



@end
