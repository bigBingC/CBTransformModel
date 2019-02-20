//
//  ViewController.m
//  CBTransformModelDemo
//
//  Created by 崔冰smile on 2019/2/20.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self transformDict];
}

- (void)transformDict {
    NSDictionary *dict = @{
                           @"name":@"小明",
                           @"age":@20,
                           @"sex":@"男",
                           @"school":@{
                                   @"name":@"合肥一中",
                                   @"address":@"合肥",
                                   @"grade":@{
                                           @"name":@"高一",
                                           @"teacher":@"MR Li",
                                           }
                                   },
                           @"lessons":@[
                                   @{
                                       @"name":@"语文",
                                       @"score":@80,
                                       },
                                   @{
                                       @"name":@"数学",
                                       @"score":@60,
                                       },
                                   @{
                                       @"name":@"英语",
                                       @"score":@90
                                       }
                                   ],
                           };
    Student *model = [Student c_modelWithDict:dict];
    NSLog(@"%@",model.lessons);
    StudentLessons *less = model.lessons[0];
    NSLog(@"%@",less.name);
}

@end
