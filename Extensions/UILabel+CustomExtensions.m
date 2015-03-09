//
//  UILabel+CustomExtensions.m
//  Sandglass
//
//  Created by kangqijun on 14-4-18.
//
//

#import "UILabel+CustomExtensions.h"

@implementation UILabel (CustomExtensions)

- (void)showMarqueeStyle
{
    [UIView animateWithDuration:10.0
                          delay:0
                        options:UIViewAnimationOptionRepeat //动画重复的主开关
     |UIViewAnimationOptionCurveLinear //动画的时间曲线，滚动字幕线性比较合理
                     animations:^{
                         
                         CGRect frame = self.frame;
                         frame.origin.x = -frame.size.width;
                         self.frame = frame;
                         
                     }
                     completion:^(BOOL finished) {
                         
                     }
     ];

}



- (void)widthFitLabText
{
    CGRect frame = self.frame;
    
    CGSize labelSize = [self.text sizeWithFont:self.font];
    
    frame.size.width = labelSize.width;
    
    self.frame = frame;
}

- (BOOL)textIsLongerThanWidth
{
    CGSize labelSize = [self.text sizeWithFont:self.font];
    
    if (self.frame.size.width < labelSize.width)
    {
        return YES;
    }
    
    return NO;
}


@end
