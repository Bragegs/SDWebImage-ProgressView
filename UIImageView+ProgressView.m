//
//  UIImageView+ProgressView.m
//
//  Created by Kevin Renskers on 07-06-13.
//  Copyright (c) 2013 Kevin Renskers. All rights reserved.
//

#import "UIImageView+ProgressView.h"

#define TAG_PROGRESS_VIEW 149462

@implementation UIImageView (ProgressView)

- (void)addProgressView:(M13ProgressViewRing *)progressView {
    M13ProgressViewRing *existingProgressView = (M13ProgressViewRing *)[self viewWithTag:TAG_PROGRESS_VIEW];
    if (!existingProgressView) {
        if (!progressView) {
            progressView = [[M13ProgressViewRing alloc] init];
                            //[[M13ProgressViewRing alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        }

        progressView.tag = TAG_PROGRESS_VIEW;
        progressView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;

        /*float width = progressView.frame.size.width;
         float height = progressView.frame.size.height;
         float x = (self.frame.size.width / 2.0) - width/2;
         float y = (self.frame.size.height / 2.0) - height/2;
        progressView.frame = CGRectMake(self.center.x, self.center.y, width, width);*/
        float width = self.bounds.size.height*0.5;
        progressView.frame = CGRectMake(self.center.x, self.center.y, width, width);
        progressView.center = self.center;
        progressView.primaryColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:0.80];
        progressView.secondaryColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
        [self addSubview:progressView];
    }
}

- (void)updateProgress:(CGFloat)progress {
    M13ProgressViewRing *progressView = (M13ProgressViewRing *)[self viewWithTag:TAG_PROGRESS_VIEW];
    if (progressView) {
       // progressView.progress = progress;
        if(progress>0){
            [progressView setProgress:progress animated:YES];
        }
    }
}

- (void)removeProgressView {
    M13ProgressViewRing *progressView = (M13ProgressViewRing *)[self viewWithTag:TAG_PROGRESS_VIEW];
    if (progressView) {
        [progressView removeFromSuperview];
    }
}

- (void)sd_setImageWithURL:(NSURL *)url usingProgressView:(M13ProgressViewRing *)progressView {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingProgressView:(M13ProgressViewRing *)progressView {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingProgressView:(M13ProgressViewRing *)progressView{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock usingProgressView:(M13ProgressViewRing *)progressView {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock usingProgressView:(M13ProgressViewRing *)progressView {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock usingProgressView:(M13ProgressViewRing *)progressView {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock usingProgressView:(M13ProgressViewRing *)progressView {
    [self addProgressView:progressView];
    
    __weak typeof(self) weakSelf = self;

    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = ((CGFloat)receivedSize / (CGFloat)expectedSize);
        dispatch_async(dispatch_get_main_queue(), ^{
             [weakSelf updateProgress:progress];
        });

        if (progressBlock) {
            progressBlock(receivedSize, expectedSize);
        }
    }
    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakSelf removeProgressView];
        if (completedBlock) {
            completedBlock(image, error, cacheType, imageURL);
        }
    }];
}

@end
