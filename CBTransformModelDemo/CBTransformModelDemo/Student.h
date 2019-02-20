//
//  Student.h
//  CBTransformModelDemo
//
//  Created by 崔冰smile on 2019/2/20.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+CBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StudentGrade : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *teacher;
@end

@interface StudentSchool : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) StudentGrade *grade;
@end

@interface Student : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, strong) StudentSchool *school;
@property (nonatomic, copy) NSArray *lessons;
@end

@interface StudentLessons : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger score;
@end

NS_ASSUME_NONNULL_END
