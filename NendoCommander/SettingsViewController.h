//
//  SettingsViewController.h
//  NendoCommander
//
//  Created by 安川 尚宏 on 2014/03/30.
//  Copyright (c) 2014年 Naohiro Yasukawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *whiteField;
@property (weak, nonatomic) IBOutlet UITextField *blackField;
@property (weak, nonatomic) IBOutlet UITextField *blueField;
@property (weak, nonatomic) IBOutlet UITextField *redField;
@property (weak, nonatomic) IBOutlet UITextField *greenField;


@end
