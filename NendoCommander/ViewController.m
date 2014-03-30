//
//  ViewController.m
//  NendoCommander
//
//  Created by 安川 尚宏 on 2014/03/29.
//  Copyright (c) 2014年 Naohiro Yasukawa. All rights reserved.
//

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
 
    //ラベルの初期化
    self.colorLabel.backgroundColor = [UIColor blackColor];
    self.colorLabel.textColor = [UIColor whiteColor];
    self.colorLabel.text = @"コマンダーの指令は？！";
    
    //カラーセンサーの読み込み
    //[self reloadColor];
    
    //カラーを読み込むタイマーの作成（10秒）
    //NSTimer *tm =[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(colorTime:) userInfo:nil repeats:YES];
    
    //waveUtil.frequencyL = 1;
    //waveUtil.frequencyR = 2;
    //[waveUtil start];
    
	// Do any additional setup after loading the view, typically from a nib.
}


/*

// カラータイマーが一定時間ごとに読み込む
-(void)colorTime:(NSTimer*)timer
{
    //[self reloadColor];
    //[self viewDidLoad];
}
*/
 
/*
//カラーセンサーのJSONデータの読み込み
-(void)reloadColor{

    NSURL *url = [NSURL URLWithString:@"http://elpisapi.net/color/api/web"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *json_data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"JSON DATA:%@",jsonObject);
    
    NSNumber *numR =[jsonObject objectForKey:@"red"];
    NSNumber *numG =[jsonObject objectForKey:@"green"];
    NSNumber *numB =[jsonObject objectForKey:@"blue"];
    
    int intR  = [numR intValue];
    int intG  = [numG intValue];
    int intB  = [numB intValue];
    int sum = intR + intG +intB;
    
    NSLog(@"numR;%d",intR);
    NSLog(@"numG;%d",intG);
    NSLog(@"numB;%d",intB);
    
    
    if (intR + intG + intB >= 1600) {
        self.colorLabel.backgroundColor = [UIColor whiteColor];
        self.colorLabel.text = @"晴れだよ！";
    }else if(intR + intG + intB <= 50){
        self.colorLabel.backgroundColor = [UIColor grayColor];
        self.colorLabel.text = @"くもりだよ！";
    }else if(intB >= intG || intB >= intR){
        self.colorLabel.backgroundColor = [UIColor blueColor];
        self.colorLabel.text = @"雨だよ！";
    }else if(intR/sum -intG/sum >= 0.6){
        self.colorLabel.backgroundColor = [UIColor redColor];
        self.colorLabel.text = @"僕、かえってきたよ！";
    }else if(intG/sum -intR/sum >= 0.2){
        self.colorLabel.backgroundColor = [UIColor greenColor];
        self.colorLabel.text = @"パパ、かえってきて！";
    }

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


- (IBAction)clickReloadBtn:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://elpisapi.net/color/api/web"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *json_data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"JSON DATA:%@",jsonObject);
    
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
    
}
@end
