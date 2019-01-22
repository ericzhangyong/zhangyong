//
//  UIView+FFVoluation.m
//  Funmily
//
//  Created by zhangyong on 16/8/17.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "UIView+FFVoluation.h"

@implementation UIView (FFVoluation)

#pragma mark - view frame
- (void)setFf_x:(CGFloat)ff_x {
    CGRect frame = self.frame;
    frame.origin.x = ff_x;
    self.frame = frame;
}

- (CGFloat)ff_x {
    return self.frame.origin.x;
}

- (void)setFf_right:(CGFloat)ff_right {
    CGRect frame = self.frame;
    frame.origin.x = ff_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)ff_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFf_y:(CGFloat)ff_y {
    CGRect frame = self.frame;
    frame.origin.y = ff_y;
    self.frame = frame;
}

- (CGFloat)ff_y {
    return self.frame.origin.y;
}

- (void)setFf_bottom:(CGFloat)ff_bottom {
    CGRect frame = self.frame;
    frame.origin.y = ff_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)ff_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFf_centerX:(CGFloat)ff_centerX {
    CGPoint center = self.center;
    center.x = ff_centerX;
    self.center = center;
}

- (CGFloat)ff_centerX {
    return self.center.x;
}

- (void)setFf_centerY:(CGFloat)ff_centerY {
    CGPoint center = self.center;
    center.y = ff_centerY;
    self.center = center;
}

- (CGFloat)ff_centerY {
    return self.center.y;
}

- (void)setFf_width:(CGFloat)ff_width {
    CGRect frame = self.frame;
    frame.size.width = ff_width;
    self.frame = frame;
}

- (CGFloat)ff_width {
    return self.frame.size.width;
}

- (void)setFf_height:(CGFloat)ff_height {
    CGRect frame = self.frame;
    frame.size.height = ff_height;
    self.frame = frame;
}

- (CGFloat)ff_height {
    return self.frame.size.height;
}

- (void)setFf_size:(CGSize)ff_size {
    CGRect frame = self.frame;
    frame.size = ff_size;
    self.frame = frame;
}

- (CGSize)ff_size {
    return self.frame.size;
}

- (void)setFf_orgin:(CGPoint)ff_orgin {
    CGRect frame = self.frame;
    frame.origin = ff_orgin;
    self.frame = frame;
}

- (CGPoint)ff_orgin {
    return self.frame.origin;
}

- (void)setFf_frame:(CGRect)ff_frame {
    CGRect frame = self.frame;
    frame = ff_frame;
    self.frame = frame;
}

- (CGRect)ff_frame {
    return self.frame;
}

#pragma mark - 取当前view的父控制器
- (UIViewController *)ff_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 取当前view的导航栏控制器
- (UINavigationController *)ff_navViewController{
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)nextResponder;
        }
    }
    return nil;
}

@end
