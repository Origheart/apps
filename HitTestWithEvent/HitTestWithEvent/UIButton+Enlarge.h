//
//  UIButton+Enlarge.h
//  HitTestWithEvent
//
//  Created by 刘康 on 16/7/22.
//  Copyright © 2016年 刘康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Enlarge)
- (void)setEnlargeEdge:(CGFloat)size;
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;
@end
