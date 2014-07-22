//
//  SettingsViewController.m
//  Lighthouse
//
//  Created by Timothy Figura on 7/21/14.
//  Copyright (c) 2014 Timothy Figura. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsModel.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    // Do any additional setup after loading the view.
    
    // Load user defaults
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.myServerText.text = [userDefaults objectForKey:@"ServerURL"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self savesettings];
    return YES;
}


-(void)savesettings
{
    NSString *tempserver = [[NSString alloc] init];
    
    tempserver = self.myServerText.text;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:tempserver forKey:@"ServerURL"];
    [userDefaults synchronize];
    
    
}
- (IBAction)handleButtonClicked:(id)sender
{
    NSString *tempserver = [[NSString alloc] init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    tempserver = [userDefaults objectForKey:@"ServerURL"];
    
    
    
    
    SettingsModel *settingslogin = [[SettingsModel alloc] init];
    NSString *temppass = [[NSString alloc] init];
    temppass = [settingslogin sha1:@"Gknk6kwa"];
    
    
    if([settingslogin login:@"tfigura" password:temppass server:tempserver])
    {
        [self.loginButton setTitle:@"Logout" forState:UIControlStateNormal];
    }

}

@end
