//
//  UIImageView+ProgressView.h
//
//  Created by Kevin Renskers on 07-06-13.
//  Copyright (c) 2013 Kevin Renskers. All rights reserved.
//OTHER_LDFLAGS = -framework "ImageIO" -framework "M13ProgressSuite"


#import "SDWebImage/UIImageView+WebCache.h"
#import "M13ProgressSuite/M13ProgressViewRing.h"

@interface UIImageView (ProgressView)

- (void)sd_setImageWithURL:(NSURL *)url usingProgressView:(M13ProgressViewRing *)progressView;
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingProgressView:(M13ProgressViewRing *)progressView;
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingProgressView:(M13ProgressViewRing *)progressView;
- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock usingProgressView:(M13ProgressViewRing *)progressView;
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock usingProgressView:(M13ProgressViewRing *)progressView;
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock usingProgressView:(M13ProgressViewRing *)progressView;
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock usingProgressView:(M13ProgressViewRing *)progressView;
- (void)removeProgressView;

@end
