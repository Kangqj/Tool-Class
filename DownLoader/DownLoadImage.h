//
//  DownLoadImage.h
//  HaidilaoPadV2
//
//  Created by GuGuiJun on 14/12/8.
//  Copyright (c) 2014年 Hoperun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DownLoadImage;

@protocol DownLoadImageDelegate <NSObject>

@optional
- (void)filePath :(NSString *)filePath url :(NSString *)url down:(DownLoadImage *)down;


@end


@interface DownLoadImage : NSObject
{
   __weak id<DownLoadImageDelegate>delegate;
}

@property(nonatomic,weak)id<DownLoadImageDelegate>delegate;

@property(nonatomic,retain)NSString *defaultImage;

@property(nonatomic,assign)float radius;

@property(nonatomic,assign)NSString *directoryName;

-(id)initWithDelegate: (id)mydelegate;

- (void)getImageWithUrl:(NSString *)url fileName:(NSString *)fileName withimageview:(UIImageView *)imageview;




@end
