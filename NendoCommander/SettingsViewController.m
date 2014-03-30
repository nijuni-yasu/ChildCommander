//
//  SettingsViewController.m
//  NendoCommander
//
//  Created by 安川 尚宏 on 2014/03/30.
//  Copyright (c) 2014年 Naohiro Yasukawa. All rights reserved.
//

#import "AppDelegate.h"
#import "SettingsViewController.h"

@interface SettingsViewController ()
@end

@implementation SettingsViewController
@synthesize whiteField;
@synthesize blackField;
@synthesize blueField;
@synthesize redField;
@synthesize greenField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];

    if([delegate.whiteText length] == 0){
        whiteField.text = @"晴れだよ！";
    }else{
        whiteField.text = delegate.whiteText;
    }
    
    
    if([delegate.blackText length] == 0){
        blackField.text = @"くもりだよ！";
    }else{
        blackField.text = delegate.blackText;
    }

    
    if([delegate.blueText length] == 0){
        blueField.text = @"あめだよ！";
    }else{
        blueField.text = delegate.blueText;
    }
    
    
    if([delegate.redText length] == 0){
        redField.text = @"僕、かえってきたよ！";
    }else{
        redField.text = delegate.redText;
    }
    
    
    if([delegate.greenText length] == 0){
        greenField.text = @"パパ、かえってきて！";
    }else{
        greenField.text = delegate.greenText;
    }
    
    
    //テキストフィールドの初期化
    whiteField.delegate = self;
    whiteField.clearButtonMode = UITextFieldViewModeWhileEditing; //消去ボタン
    
    blackField.delegate = self;
    blackField.clearButtonMode = UITextFieldViewModeWhileEditing; //消去ボタン

    blueField.delegate = self;
    blueField.clearButtonMode = UITextFieldViewModeWhileEditing; //消去ボタン

    redField.delegate = self;
    redField.clearButtonMode = UITextFieldViewModeWhileEditing; //消去ボタン

    greenField.delegate = self;
    greenField.clearButtonMode = UITextFieldViewModeWhileEditing; //消去ボタン

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //[textField resignFirstResponder];
    [self.view endEditing:YES];
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    delegate.whiteText = whiteField.text;
    delegate.blackText = blackField.text;
    delegate.blueText = blueField.text;
    delegate.redText = redField.text;
    delegate.greenText = greenField.text;
    
    NSLog(@"%@",delegate.whiteText);
    NSLog(@"%@",delegate.blackText);
    NSLog(@"%@",delegate.blueText);
    NSLog(@"%@",delegate.redText);
    NSLog(@"%@",delegate.greenText);

    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
