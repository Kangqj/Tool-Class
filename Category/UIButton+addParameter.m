//
//  UIButton+addParameter.m
//  test
//
//  Created by 康起军 on 16/10/1.
//  Copyright © 2016年 康起军. All rights reserved.
//

#import "UIButton+addParameter.h"

static char addParameter;

@implementation UIButton (addParameter)

- (void)setParameter:(NSDictionary *)dic
{
    objc_setAssociatedObject(self, &addParameter, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)parameter
{
    return objc_getAssociatedObject(self, &addParameter);
}


@end
