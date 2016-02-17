//
//  ViewController.m
//  LineDemo
//
//  Created by 徐继垚 on 16/2/17.
//  Copyright © 2016年 Sunny土. All rights reserved.
//

#import "ViewController.h"
#import "TouchView.h"

@interface ViewController ()
{
    TouchView *tv;
    UIImageView * mainImageView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    

    
 }

- (void)loadView {
    
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    
    mainImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    mainImageView.image = [UIImage imageNamed:@"1.jpg"];
    mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    mainImageView.clipsToBounds = YES;
    mainImageView.userInteractionEnabled = YES;
    [self.view addSubview:mainImageView];
    
    tv = [[TouchView alloc]initWithFrame:self.view.frame];
    tv.backgroundColor = [UIColor clearColor];
    [mainImageView addSubview:tv];
}




@end
