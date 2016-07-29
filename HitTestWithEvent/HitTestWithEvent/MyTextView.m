//
//  MyTextView.m
//  HitTestWithEvent
//
//  Created by 刘康 on 16/7/22.
//  Copyright © 2016年 刘康. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* tmpView = [super hitTest:point withEvent:event];
    if (tmpView == self) {
        return nil;
    }
    return tmpView;
}

@end
