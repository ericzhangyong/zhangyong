//
//  FFBaseViewController.m
//  Funmily
//
//  Created by Kuroky on 16/8/16.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "FFBaseViewController.h"
#import "UIImage+FFCreate.h"

@implementation FFBaseViewController


- (void)pushNewViewController:(UIViewController *)newViewController {
    if (self.navigationController) {
        [self.navigationController pushViewController:newViewController animated:YES];
    }else{
        UINavigationController *nav = [self parentNavController:self.view];
        if (nav) {
            [nav pushViewController:newViewController animated:YES];
        }
    }
    
}
- (void)pushNewViewControllerWithNoAnimat:(UIViewController *)newViewController
{
    if (self.navigationController) {
        [self.navigationController pushViewController:newViewController animated:NO];
    }else{
        UINavigationController *nav = [self parentNavController:self.view];
        if (nav) {
            [nav pushViewController:newViewController animated:NO];
        }
    }
}

- (UINavigationController *)parentNavController:(UIView*)view
{
    for (UIView* next = [view superview]; next; next =
         next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController
                                          class]]) {
            return (UINavigationController*)nextResponder;
        }
    }
    return nil;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


@end
