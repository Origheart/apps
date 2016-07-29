//
//  TopView.m
//  HitTestWithEvent
//
//  Created by 刘康 on 16/7/21.
//  Copyright © 2016年 刘康. All rights reserved.
//

#import "TopView.h"

@interface TopView ()
@property (weak, nonatomic) IBOutlet UIButton *checkedButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation TopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [_checkedButton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)buttonTap:(id)sender
{
    NSLog(@"Tapped...");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* result = [super hitTest:point withEvent:event];
    CGPoint buttonPoint = [_checkedButton convertPoint:point fromView:self];
    if ([_checkedButton pointInside:buttonPoint withEvent:event]) {
        return _checkedButton;
    }
    return result;
}

@end
