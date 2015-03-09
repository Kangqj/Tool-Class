//
//  DownLoadImage.m
//  HaidilaoPadV2
//
//  Created by GuGuiJun on 14/12/8.
//  Copyright (c) 2014年 Hoperun. All rights reserved.
//

#import "DownLoadImage.h"

@implementation DownLoadImage

@synthesize delegate;
@synthesize defaultImage;
@synthesize radius;
@synthesize directoryName;

//static DownLoadImage *downloadimage = nil;
//
//+ (instancetype)shareInstance {
//    
//    if (!downloadimage)
//    {
//        downloadimage = [self new];
//    }
//    return downloadimage;
//    
//}

- (void)dealloc
{
    delegate = nil;

}

-(id)initWithDelegate: (id)mydelegate
{
    self = [super init];
    if (self)
    {
        delegate = mydelegate;
    }
    return self;
}

- (void)getImageWithUrl:(NSString *)url fileName:(NSString *)fileName withimageview:(UIImageView *)imageview
{
    
    
    NSArray *fileArr = [url componentsSeparatedByString:@"/"];
    NSMutableString *urlPath = [[NSMutableString alloc] initWithCapacity:6];
    for (NSString *str in  fileArr)
    {
        [urlPath appendString:str];
    }

    
    //ios沙盒下创建目录：
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (directoryName.length > 0)
    {
        
        NSString *fileDirectory = [IOSDocumentPath stringByAppendingPathComponent:directoryName];
        // 创建目录
        [fileManager createDirectoryAtPath:fileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSString *filePath = [fileDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",urlPath]];
        
        if (filePath)
        {
            NSData *headData = [[NSData alloc] initWithContentsOfFile:filePath];
            if (headData)
            {
                imageview.image = [UIImage imageWithData:headData];
                radius = 0.0;
                directoryName = @"";
                return;
            }
            else
            {
                [self downLoadImage:url withPath:filePath withImageView:imageview];
            }
            
            
        }
        else
        {
            [self downLoadImage:url withPath:filePath withImageView:imageview];
        }
    }
    else
    {
        [self downLoadImage:url withPath:@"" withImageView:imageview];
       
    }
    
}



-(void)downLoadImage:(NSString *)url withPath:(NSString *)filePath withImageView:(UIImageView *)imageview
{
    
    //下载
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    __block UIImage *image = nil;

    dispatch_async(concurrentQueue, ^{
        
//        __block UIImage *image = nil;
        
        dispatch_sync(concurrentQueue, ^{
            
            NSString *imageURL = url;
            
            NSURLRequest *reuqest = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
            
            NSError *__autoreleasing error = nil;
            
            NSData *imageData = [NSURLConnection sendSynchronousRequest:reuqest
                                                      returningResponse:nil
                                                                  error:&error];
            
            if (!error && imageData)
            {
                image = [UIImage imageWithData:imageData];
                if (image)
                {
                    [imageData writeToFile:filePath atomically:YES];
                }
            }
            else
            {
                NSLog(@"haha图片下载失败");
            }
        });
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (image)
            {
                if (radius > 0.000001)
                {
                    //UIImage *temp = [self makeRoundedImage:image radius:radius];
                    imageview.image = image;
                    radius = 0.0;
                }
                else
                {
                    imageview.image = image;
                }
                
                directoryName = @"";
            }
            else
            {
                imageview.image = [UIImage imageNamed:defaultImage];
            }
        });
    });
    
}



-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) myRadius;
{
    CALayer *imageLayer = [CALayer layer];
   
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    

    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = myRadius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}


@end
