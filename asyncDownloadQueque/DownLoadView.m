//
//  DownLoadViw.m
//  asyncDownloadQueque
//
//  Created by sbx_fc on 15-4-26.
//  Copyright (c) 2015年 RG. All rights reserved.
//

#import "DownLoadView.h"
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "Reachability.h"

@implementation DownLoadView
{
    ASINetworkQueue *downloadQueue;//下载队列
    NSTimer *checkConnectionTimer;
    
    NSMutableDictionary* downloadListDic;
    NSMutableString* LOG;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    downloadListDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    LOG = [[NSMutableString alloc]init];
}

 /**
 * 开始下载
 */
-(IBAction)start:(id)sender
{
    self.startButton.enabled = NO;
    self.cancelButton.enabled = YES;
    
    //获取下载列表
    [self getDownloadList:downloadListDic];
    
    //创建下载队列
    [self downloadFiles:downloadListDic];
}

 /**
 * 停止下载
 */
-(IBAction)cancel:(id)sender
{
    [self log:@"停止下载...\n"];
    
    self.cancelButton.enabled = NO;
    self.resumeButton.enabled = YES;
    
    [downloadQueue cancelAllOperations];
}

 /**
 * 恢复下载
 */
-(IBAction)resumes:(id)sender
{
    [self log:@"继续下载...\n"];
    self.cancelButton.enabled = YES;
    self.resumeButton.enabled = NO;
    
    if (downloadListDic != nil)
        [self downloadFiles:downloadListDic];
}

-(void)downloadFiles:(NSDictionary *)files
{
    [self log:@"开始下载...\n"];

    if ([downloadListDic count] == 0)
        return;
    
    if (downloadQueue == nil)
        downloadQueue = [[ASINetworkQueue alloc] init];
    
    [downloadQueue reset];
    [downloadQueue setDownloadProgressDelegate:self];
    [downloadQueue setRequestDidFinishSelector:@selector(downloadCompleted:)];
    [downloadQueue setRequestDidFailSelector:@selector(downloadFailed:)];
    [downloadQueue setShowAccurateProgress:YES];
    [downloadQueue setDelegate:self];
    
    // Add download requests to queue
    for (id key in files) {
        NSURL *url = [NSURL URLWithString:[files objectForKey:key]];
        NSString *file = key;
        NSString *downloadPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:file];
        NSString *tempPath = [downloadPath stringByAppendingString:@".download"];
        
        ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
        [request setDownloadDestinationPath:downloadPath];
        [request setTemporaryFileDownloadPath:tempPath];
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setAllowResumeForFileDownloads:YES];
        [request setDownloadProgressDelegate:self];
        [request setTimeOutSeconds:10];
        [request setUserInfo:[NSDictionary dictionaryWithObject:url forKey:key]];
        
        [downloadQueue addOperation:request];
    }
    [downloadQueue go];
}

 /**
 * 获取下载列表
 */
-(void)getDownloadList:(NSMutableDictionary*)dict
{
    [self log:@"获取下载列表...\n"];
    
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_0.png" forKey:@"m100001_0.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_1.png" forKey:@"m100001_1.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_2.png" forKey:@"m100001_2.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_3.png" forKey:@"m100001_3.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_4.png" forKey:@"m100001_4.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_5.png" forKey:@"m100001_5.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_6.png" forKey:@"m100001_6.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_7.png" forKey:@"m100001_7.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_8.png" forKey:@"m100001_8.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_9.png" forKey:@"m100001_9.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_10.png" forKey:@"m100001_10.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_11.png" forKey:@"m100001_11.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_12.png" forKey:@"m100001_12.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_13.png" forKey:@"m100001_13.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_14.png" forKey:@"m100001_14.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_15.png" forKey:@"m100001_15.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_16.png" forKey:@"m100001_16.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_17.png" forKey:@"m100001_17.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_18.png" forKey:@"m100001_18.png"];
    [dict setValue:@"http://war2res.wistone.com/image/maptile/m100001_19.png" forKey:@"m100001_19.png"];
}

-(void)log:(NSString*)msg
{
    [LOG appendString:msg];
    self.logText.text = LOG;
}

#pragma mark -- finish & fail

//- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
//{
//    NSString *downloadedFile = [[request.userInfo allKeys] objectAtIndex:0];
//    NSLog([NSString stringWithFormat:@"%@ - %lld KB/%lld KB \n",downloadedFile,request.totalBytesRead/1024,request.contentLength/1024]);
//}

#pragma mark -- finish & fail
- (void)downloadCompleted:(ASIHTTPRequest *)request
{
    NSString *downloadedFile = [[request.userInfo allKeys] objectAtIndex:0];
    [self log:[NSString stringWithFormat:@"%@ 下载完成\n",downloadedFile]];
    
    [downloadListDic removeObjectForKey:downloadedFile];
    if ([downloadListDic count] == 0)
        [self log:@"全部下载完毕!"];

}

- (void)downloadFailed:(ASIHTTPRequest *)request
{
    NSString *downloadedFile = [[request.userInfo allKeys] objectAtIndex:0];
    [self log:[NSString stringWithFormat:@"%@ 下载失败!\n",downloadedFile]];

    if (request.error.code == 1 || request.error.code == 2) {
        [self log:@"网络连接失败...\n"];
        
        if (checkConnectionTimer == nil)
            checkConnectionTimer = [NSTimer scheduledTimerWithTimeInterval: 2 target:self
                                                                  selector:@selector(resumeInterruptedDownload:)
                                                                  userInfo:nil repeats:YES];
    }
    else
        NSLog(@"%@", request.error.debugDescription);
}

-(void)resumeInterruptedDownload:(NSNotification *)notification
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStat = [reachability currentReachabilityStatus];
    if (netStat == ReachableViaWiFi) {
        [self log:@"网络连接成功...\n"];
        [checkConnectionTimer invalidate];
        checkConnectionTimer = nil;
        [self downloadFiles:downloadListDic];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
