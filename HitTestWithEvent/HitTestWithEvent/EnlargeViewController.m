//
//  EnlargeViewController.m
//  HitTestWithEvent
//
//  Created by 刘康 on 16/7/21.
//  Copyright © 2016年 刘康. All rights reserved.
//

#import "EnlargeViewController.h"
#import "UIButton+Enlarge.h"

@interface EnlargeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation EnlargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_button setEnlargeEdge:30];
}

- (IBAction)tap:(id)sender {
    NSLog(@"tap...");
}

@end
