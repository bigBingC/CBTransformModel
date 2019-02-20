//
//  NSObject+CBModel.h
//  CBTransformModelDemo
//
//  Created by 崔冰smile on 2019/2/20.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CBModel)
+ (instancetype)c_modelWithDict:(NSDictionary *)dict;
//数组需要重写此方法
- (NSString *)c_objectClassInArray;
@end

NS_ASSUME_NONNULL_END
