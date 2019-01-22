//
//  FFBaseViewController.h
//  Funmily
//
//  Created by Kuroky on 16/8/16.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FFBaseViewController : UIViewController



- (void)pushNewViewController:(UIViewController *)newViewController;
- (void)pushNewViewControllerWithNoAnimat:(UIViewController *)newViewController;

@end
