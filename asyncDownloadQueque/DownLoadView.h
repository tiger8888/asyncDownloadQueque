//
//  DownLoadViw.h
//  asyncDownloadQueque
//
//  Created by sbx_fc on 15-4-26.
//  Copyright (c) 2015年 RG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIProgressDelegate.h"

@interface DownLoadView : UIView<ASIProgressDelegate>

@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *resumeButton;
@property (strong, nonatomic) IBOutlet UILabel *logText;

 /**
 * 开始下载
 */
-(IBAction)start:(id)sender;

/**
 * 停止下载
 */
-(IBAction)cancel:(id)sender;

/**
 * 恢复下载
 */
-(IBAction)resumes:(id)sender;
@end
