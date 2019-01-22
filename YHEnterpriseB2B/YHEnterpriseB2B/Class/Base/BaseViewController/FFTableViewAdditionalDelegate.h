//
//  FFTableViewAdditionalDelegate.h
//  Funmily
//
//  Created by kevin on 16/8/30.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FFTableViewAdditionalDelegate <NSObject>


@optional
/**
 *  是否需要下拉
 */
-(BOOL)needPullHeader;
/**
 *  是否需要上啦
 */
-(BOOL)needPullFooter;
/**
 *  是否需要 空提示
 */
-(BOOL)needEmptyTip;

-(UIImage*)imageForEmptyNoList;


-(UIView*)viewForEmptyNoList;

-(NSString*)stringForEmptyNoList;

/**
 是否显示自定义的空数据View
 */
-(BOOL)isShouldShowFFCustomEmptyView;


@end
