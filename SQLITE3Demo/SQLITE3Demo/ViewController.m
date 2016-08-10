//
//  ViewController.m
//  SQLITE3Demo
//
//  Created by 刘康 on 16/2/26.
//  Copyright © 2016年 刘康. All rights reserved.
//

#import "ViewController.h"
#import "DataHelper.h"

@interface ViewController ()
@property (strong, nonatomic)DataHelper* dataHelper;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataHelper = [DataHelper new];
}

- (IBAction)tap:(UIButton *)sender {
    if (sender.tag == 0) {
        [self.dataHelper openDatabase];
    } else if (sender.tag == 1) {
        [self.dataHelper insertData];
    } else {
        [self.dataHelper readData];
    }
}


@end
