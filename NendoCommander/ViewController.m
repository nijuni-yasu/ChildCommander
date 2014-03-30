//
//  ViewController.m
//  NendoCommander
//
//  Created by 安川 尚宏 on 2014/03/29.
//  Copyright (c) 2014年 Naohiro Yasukawa. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "VincluLed.h"

@interface ViewController ()
{
    VincluLed* waveUtil;
}

@end

@implementation ViewController
@synthesize colorLabel;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //ウィンクルの初期化
    waveUtil = [[VincluLed alloc] initialize];
 
    //画像の読み込み
    self.commentImage.image = [UIImage imageNamed:@"codomocommander_app_comment_sunny.png"];
    self.commentImage.image = [UIImage imageNamed:@"codomocommander_app_comment_cloud.png"];
    self.commentImage.image = [UIImage imageNamed:@"codomocommander_app_comment_rain.png"];
    self.commentImage.image = [UIImage imageNamed:@"codomocommander_app_comment_home.png"];
    self.commentImage.image = [UIImage imageNamed:@"codomocommander_app_comment_wait.png"];

    //画像とラベルを隠す。
    self.commentImage.hidden = YES;
    self.colorLabel.hidden = YES;

    
    //カラーを読み込むタイマーの作成（10秒）
    //NSTimer *tm =[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(colorTime:) userInfo:nil repeats:YES];
    
	// Do any additional setup after loading the view, typically from a nib.
}

/*
// カラータイマーが一定時間ごとに読み込む。時間ごとに読み込むのはやめる。
-(void)colorTime:(NSTimer*)timer
{
    [self reloadColor];
    [self viewDidLoad];
}
*/
 


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload{
    //停止
    [waveUtil uninitialize];
}


//ボタン押下でカラーセンサーのJSONデータを読み込む。
- (IBAction)clickReloadBtn:(id)sender {
    
    //吹き出し画像を表示する。
    self.commentImage.hidden = NO;
    self.colorLabel.hidden = NO;

    
    NSURL *url = [NSURL URLWithString:@"http://elpisapi.net/color/api/web"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *json_data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"JSON DATA:%@",jsonObject);
    
    //JSONの取得
    NSString *colorstr =[jsonObject objectForKey:@"colorstr"];
    NSLog(@"colorstr:%@",colorstr);

    //デリゲートの設定
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];

    
    //白の場合
    if ([colorstr isEqualToString:@"white"]){
        //self.colorLabel.backgroundColor = [UIColor yellowColor];
        self.colorLabel.textColor = [UIColor blackColor];
        self.commentImage.image = [UIImage imageNamed:@"codomocommander_app_comment_sunny.png"];
        
        if([delegate.whiteText length] == 0){
            self.colorLabel.text = @"晴れだよ！";
        }else{
            self.colorLabel.text = delegate.whiteText;
        }
        
        //ウィンクルの設定
        waveUtil.frequencyL = 1000;
        waveUtil.frequencyR = 100;
        [waveUtil start];
    
        
    //黒の場合
    }else if([colorstr isEqualToString:@"black"]){
        //self.colorLabel.backgroundColor = [UIColor grayColor];
        self.colorLabel.textColor = [UIColor whiteColor];
        self.commentImage.image = [UIImage imageNamed:@"codomocommander_app_comment_cloud.png"];
        
        if([delegate.blackText length] == 0){
            self.colorLabel.text = @"くもりだよ！";
        }else{
            self.colorLabel.text = delegate.blackText;
        }
        
        //ウィンクルの設定
        waveUtil.frequencyL = 900;
        waveUtil.frequencyR = 800;
        [waveUtil start];
        
    
    //青の場合
    }else if([colorstr isEqualToString:@"blue"]){
        //self.colorLabel.backgroundColor = [UIColor blueColor];
        self.colorLabel.textColor = [UIColor whiteColor];
        self.commentImage.image = [UIImage imageNamed:@"codomocommander_app_comment_rain.png"];
        
        if([delegate.blueText length] == 0){
            self.colorLabel.text = @"雨だよ！";
        }else{
            self.colorLabel.text = delegate.blueText;
        }
        
        //ウィンクルの設定
        waveUtil.frequencyL = 3;
        waveUtil.frequencyR = 1;
        [waveUtil start];
        
        
    //赤の場合
    }else if([colorstr isEqualToString:@"red"]){
        //self.colorLabel.backgroundColor = [UIColor redColor];
        self.colorLabel.textColor = [UIColor whiteColor];
        self.commentImage.image = [UIImage imageNamed:@"codomocommander_app_comment_home.png"];
        
        
        if([delegate.redText length] == 0){
            self.colorLabel.text = @"僕、かえってきたよ！";
        }else{
            self.colorLabel.text = delegate.redText;
        }
        
        //ウィンクルの設定
        waveUtil.frequencyL = 100;
        waveUtil.frequencyR = 99;
        [waveUtil start];
    
        
    //緑の場合
    }else if([colorstr isEqualToString:@"green"]){
        //self.colorLabel.backgroundColor = [UIColor greenColor];
        self.colorLabel.textColor = [UIColor whiteColor];
        self.commentImage.image = [UIImage imageNamed:@"codomocommander_app_comment_wait.png"];
        
        
        if([delegate.greenText length] == 0){
            self.colorLabel.text = @"パパ、かえってきて！";
        }else{
            self.colorLabel.text = delegate.greenText;
        }
        
        //ウィンクルの設定
        waveUtil.frequencyL = 1000;
        waveUtil.frequencyR = 100;
        [waveUtil start];
        
        
    }else if([colorstr isEqualToString:@"none"]){
        //self.colorLabel.backgroundColor = [UIColor blackColor];
        self.colorLabel.textColor = [UIColor blackColor];
        self.colorLabel.text = @"指令はありません...";
        self.commentImage.hidden = YES;
        [waveUtil stop];
    }
    
    
    /*旧API
    NSNumber *numR =[jsonObject objectForKey:@"red"];
    NSNumber *numG =[jsonObject objectForKey:@"green"];
    NSNumber *numB =[jsonObject objectForKey:@"blue"];
    
    float intR  = [numR floatValue];
    float intG  = [numG floatValue];
    float intB  = [numB floatValue];
    float sum = intR + intG +intB;
    
    NSLog(@"numR;%f",intR);
    NSLog(@"numG;%f",intG);
    NSLog(@"numB;%f",intB);
    NSLog(@"sum;%f",sum);
    
    
    if (intR + intG + intB >= 1600) {
        self.colorLabel.backgroundColor = [UIColor yellowColor];
        self.colorLabel.textColor = [UIColor blackColor];
        self.colorLabel.text = @"晴れだよ！";
        [waveUtil stop];
    
    }else if(intR + intG + intB <= 50){
        self.colorLabel.backgroundColor = [UIColor grayColor];
        self.colorLabel.text = @"くもりだよ！";
        [waveUtil stop];
    
    }else if(intB >= intG && intB >= intR){
        self.colorLabel.backgroundColor = [UIColor blueColor];
        self.colorLabel.text = @"雨だよ！";
        [waveUtil stop];
    
    }else if(intR /sum -intG / sum >= 0.6 && intR > intB){
        self.colorLabel.backgroundColor = [UIColor redColor];
        self.colorLabel.text = @"僕、かえってきたよ！";
        waveUtil.frequencyL = 100;
        waveUtil.frequencyR = 99;
        [waveUtil start];
    
        
    }else if(intG/sum -intR/sum >= 0.2){
        self.colorLabel.backgroundColor = [UIColor greenColor];
        self.colorLabel.text = @"パパ、かえってきて！";
        waveUtil.frequencyL = 1000;
        waveUtil.frequencyR = 100;
        [waveUtil start];
    }
    */
}


//設定画面から戻るから処理
-(IBAction)goback:(UIStoryboardSegue *)segue{}

@end
