//
//  NSObject+CBModel.m
//  CBTransformModelDemo
//
//  Created by 崔冰smile on 2019/2/20.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import "NSObject+CBModel.h"
#import <objc/runtime.h>

@implementation NSObject (CBModel)

+ (instancetype)c_modelWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    [obj transformDict:dict];
    return obj;
}

- (void)transformDict:(NSDictionary *)dict {
    Class cls = self.class;
    unsigned int count = 0;
    //获取成员变量数组
    Ivar *ivars = class_copyIvarList(cls, &count);
    for (int i = 0; i < count; i ++) {
        //遍历所有成员变量
        Ivar ivar = ivars[i];
        //获取成员变量的名字
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //成员变量名转为属性名（去掉下划线）
        key = [key substringFromIndex:1];
        //取出字典中对应的值
        id value = dict[key];
        if (value == nil) {
            continue;
        }
        //分布转换 字典包含字典或者数组（递归转换）
        //判断value的类型
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        NSRange range = [type rangeOfString:@"@"];
        if (range.location != NSNotFound) {
            //截取对象名（@"xxx"->xxx）
            type = [type substringWithRange:NSMakeRange(2, type.length-3)];
            //排除系统对象
            if (![type hasPrefix:@"NS"]) {
                //将对象名转换为对象类型，将新的对象字典转换模型（递归）
                Class class = NSClassFromString(type);
                value = [class c_modelWithDict:value];
            } else if ([type isEqualToString:@"NSArray"]) {
                //如果是数组
                NSArray *tempArray = (NSArray *)value;
                NSMutableArray *mutArray = [NSMutableArray array];
                id class;
                if ([self respondsToSelector:@selector(c_objectClassInArray)]) {
                    //获取数组中每个字典对应转换的类型，即重写c_objectClassInArray方法返回的类型
                    NSString *classStr = [self c_objectClassInArray];
                    NSAssert(classStr!=nil, @"model类必须重写c_objectClassInArray方法，指定array的类型");
                    class = NSClassFromString(classStr);
                }
                for (int i = 0; i < tempArray.count; i ++) {
                    id obj = [class c_modelWithDict:value[i]];
                    if (obj) {
                        [mutArray addObject:obj];
                    }
                }
                value = mutArray;
            }
        }
        [self setValue:value forKeyPath:key];
    }
    free(ivars);
}

- (NSString *)c_objectClassInArray {
    return nil;
}
@end
