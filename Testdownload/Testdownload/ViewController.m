//
//  ViewController.m
//  Testdownload
//
//  Created by zhangyong on 2019/1/14.
//  Copyright © 2019年 lehu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDelegate>
@property (weak, nonatomic) IBOutlet UIButton *beginDownLoad;
@property (weak, nonatomic) IBOutlet UIButton *btn_pause;
@property (weak, nonatomic) IBOutlet UIButton *btn_resume;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@property (weak, nonatomic) IBOutlet UILabel *label_downLoadProcess;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@""]
    
    
    
}

- (IBAction)btn_beginAction:(id)sender {
    
}
- (IBAction)btn_pauseAction:(id)sender {
    
}
- (IBAction)btn_resumeAction:(id)sender {
    
}
- (IBAction)btn_cancelAction:(id)sender {
    
}

@end
