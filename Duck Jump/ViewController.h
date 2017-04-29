//
//  ViewController.h
//  Duck Jump
//
//  Created by Jake Magid on 3/5/14.
//  Copyright (c) 2014 Jake Carson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <iAd/iAd.h>


int gameState;
int previousState;
int soundState;
int screenRate;
int RandomNumber;
int OneOrZero;
int scoreNumber;
int RandomOrdering;
int HighScore;





@interface ViewController : UIViewController <ADBannerViewDelegate>
{
    
    SystemSoundID QuackID;
    SystemSoundID BoingID;
    SystemSoundID WoooID;
    
    NSTimer *gameTimer;
    
    CGPoint DuckVelocity;
    CGPoint gravity;
    
    IBOutlet UIImageView *BrickWall1;
    IBOutlet UIImageView *BrickWall2;
    IBOutlet UIImageView *BrickWall3;
    IBOutlet UIImageView *BrickWall4;
    IBOutlet UIImageView *BrickWall5;
    IBOutlet UIImageView *BrickWall6;
    IBOutlet UIImageView *BrickWall7;
    IBOutlet UIImageView *BrickWall8;
    
    IBOutlet UIImageView *SkateBG;
    IBOutlet UIImageView *DuckSkater;
    IBOutlet UIImageView *TrashCan;
    IBOutlet UIImageView *Cow;
    IBOutlet UIImageView *Trampoline;
    
    IBOutlet UIButton *PlayButton;
    IBOutlet UIButton *HighScoreButton;
    IBOutlet UIButton *SettingsButton;
    IBOutlet UIButton *BackButton;
    
    IBOutlet UISwitch *soundSwitch;
    
    
    IBOutlet UIImageView *soundIcon;
    
    IBOutlet UILabel *ScoreLabel;
    IBOutlet UIImageView *LightningBolt;
    
    IBOutlet UIImageView *NewHighScore;
    
    
    
    IBOutlet UIImageView *DuckJumpLogo;
    
    
    
}


-(void)gameLoop;
-(void)skaterMove;
-(void)Collision;
-(void)gameOver;
-(void)Scoring;

-(IBAction)pressPlay:(id)sender;
-(IBAction)pressHighScores:(id)sender;
-(IBAction)pressSettings:(id)sender;
-(IBAction)pressBack:(id)sender;

-(IBAction)pressSoundSwitch:(id)sender;







@end
