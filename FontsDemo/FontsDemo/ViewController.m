//
//  ViewController.m
//  FontsDemo
//
//  Created by Origheart on 16/7/12.
//  Copyright © 2016年 Origheart. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self findFonts];
}

- (void)findFonts {
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
}

- (IBAction)tap:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            self.textView.font = [UIFont fontWithName:@"FZShaoEr-M11S" size:17.0];
            break;
        case 1:
            
            self.textView.font = [UIFont fontWithName:@"FZMiaoWuS-GB" size:17.0];
            break;
        case 2:
            self.textView.font = [UIFont fontWithName:@"HYTiaoTiaoTiJ" size:17.0];
            break;
        case 3:
            self.textView.font = [UIFont fontWithName:@"迷你简丫丫" size:17.0];
            break;
        case 4:
            self.textView.font = [UIFont systemFontOfSize:17.0];
            break;
            
        default:
            break;
    }
}




@end
