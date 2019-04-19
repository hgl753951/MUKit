//
//  UIButton+MUImageCache.h
//  MUKit_Example
//
//  Created by Jekity on 2018/10/24.
//  Copyright © 2018 Jeykit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (MUImageCache)


/**
 *  set it value YES when you want to show a image with progress. Defalut is NO
 */
@property (nonatomic,assign) BOOL updateWithProgress;

/**
 *  This property will not cancle the downloading until complected.Defalut is NO.
 */
@property (nonatomic,assign) BOOL waitingDownloadingComplected;
/**
 *  Convenient method of setPlaceHolderImageName:iconURL. sizetoFit(0~100)
 */
- (void)setIconURL:(NSString*)iconURL;
/**
 *  Download an icon, and save it using [FlyImageIconCache shareInstance].
 */
- (void)setIconURL:(NSString*)iconURL placeHolderImageName:(NSString*)imageName;

/**
 *  Download an icon, and save it using [FlyImageIconCache shareInstance].
 */
- (void)setIconURL:(NSString*)iconURL placeHolderImageName:(NSString*)imageName cornerRadius:(CGFloat)cornerRadius;

/**
 *  Convenient method of setPlaceHolderImageName:thumbnailURL:originalURL
 *
 *  @param url originalURL
 */
- (void)setImageURL:(NSString*)url;

/**
 *  Download images and render them with the below order:
 *  1. PlaceHolder
 *  2. Thumbnail Image
 *  3. Original Image
 *
 *  These images will be saved into [FlyImageCache shareInstance]
 */
- (void)setImageURL:(NSString*)imageURL placeHolderImageName:(NSString*)imageName;

- (void)setImageURL:(NSString*)imageURL placeHolderImageName:(NSString*)imageName cornerRadius:(CGFloat)cornerRadius;


@end

NS_ASSUME_NONNULL_END
