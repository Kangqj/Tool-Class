//
//  UIButton+addParameter.h
//  test
//
//  Created by 康起军 on 16/10/1.
//  Copyright © 2016年 康起军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (addParameter)

- (void)setParameter:(NSDictionary *)dic;
- (NSDictionary *)parameter;

@end
