//
//  ViewController.m
//  Duck Jump
//
//  Created by Jake Magid on 3/5/14.
//  Copyright (c) 2014 Jake Carson. All rights reserved.
//

#import "ViewController.h"

#define kStateRunning 1
#define kStateGameOver 2
#define kStateMenu 3
#define kStateHighScores 4
#define kStateSettings 5

#define kGravity 2

#define kTrash 1
#define kCow 2
#define kTramp 3

#define kSoundOn 1
#define kSoundOff 2


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    gameState = kStateMenu;
    soundState = kSoundOn;
    
    NSURL *SoundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Quack" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)SoundURL, &QuackID);
    
    NSURL *Sound2URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Boing" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)Sound2URL, &BoingID);
    
    NSURL *Sound3URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Wooo" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)Sound3URL, &WoooID);
    
    PlayButton.hidden = NO;
    SettingsButton.hidden = NO;
    HighScoreButton.hidden = NO;
    DuckJumpLogo.hidden = NO;

    BackButton.hidden = YES;
    TrashCan.hidden = YES;
    Cow.hidden = YES;
    Trampoline.hidden = YES;
    LightningBolt.hidden = YES;
    NewHighScore.hidden = YES;
    soundIcon.hidden = YES;
    soundSwitch.hidden = YES;
    ScoreLabel.hidden = YES;
    
    
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
    DuckVelocity = CGPointMake(0, 0);
    gravity = CGPointMake(0, kGravity);
    
    
    HighScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}


- (void)gameLoop {
    
    if (gameState == kStateRunning) {
        if (previousState != kStateRunning) {
            // Display what should be involved in kStateRunning
            
            PlayButton.hidden = YES;
            SettingsButton.hidden = YES;
            BackButton.hidden = YES;
            HighScoreButton.hidden = YES;
            NewHighScore.hidden = YES;
            TrashCan.hidden = NO;
            Cow.hidden = NO;
            Trampoline.hidden = NO;
            LightningBolt.hidden = NO;
            soundIcon.hidden = YES;
            soundSwitch.hidden = YES;
            DuckJumpLogo.hidden = YES;
            ScoreLabel.hidden = NO;
            
            scoreNumber = 0;
            ScoreLabel.textColor = [UIColor blackColor];
            ScoreLabel.text = [NSString stringWithFormat:@"%i", scoreNumber];
            
            // Initialize Moving Objects
            BrickWall1.center = CGPointMake(-70, BrickWall1.center.y);
            BrickWall2.center = CGPointMake(30, BrickWall2.center.y);
            BrickWall3.center = CGPointMake(130, BrickWall3.center.y);
            BrickWall4.center = CGPointMake(230, BrickWall4.center.y);
            BrickWall5.center = CGPointMake(330, BrickWall5.center.y);
            BrickWall6.center = CGPointMake(430, BrickWall6.center.y);
            BrickWall7.center = CGPointMake(530, BrickWall7.center.y);
            BrickWall8.center = CGPointMake(630, BrickWall8.center.y);
            
            
            
            OneOrZero = arc4random() %2;
            
            if (OneOrZero == 0) {
                RandomNumber = arc4random() %100;
                TrashCan.center = CGPointMake(650 + RandomNumber, TrashCan.center.y);
                RandomNumber = arc4random() %100;
                Cow.center = CGPointMake(950 + RandomNumber, Cow.center.y);
                
            } else {
                RandomNumber = arc4random() %100;
                TrashCan.center = CGPointMake(950 + RandomNumber, TrashCan.center.y);
                RandomNumber = arc4random() %100;
                Cow.center = CGPointMake(650 + RandomNumber, Cow.center.y);
                
            }
            
            Trampoline.center = CGPointMake(-600, Trampoline.center.y);
            LightningBolt.center = CGPointMake(-600, LightningBolt.center.y);
            
            
            
        }
        previousState = kStateRunning;
        
        [self skaterMove];
        [self Collision];
        [self Scoring];
        
    } else if (gameState == kStateGameOver) {
        if (previousState == kStateRunning) {
            
            PlayButton.hidden = NO;
            BackButton.hidden = NO;
            ScoreLabel.hidden = NO;
            
            SettingsButton.hidden = YES;
            HighScoreButton.hidden = YES;
            NewHighScore.hidden = YES;
            soundIcon.hidden = YES;
            soundSwitch.hidden = YES;
            DuckJumpLogo.hidden = YES;
          
            
        }
        
        previousState = kStateGameOver;
        
        if (scoreNumber > HighScore) {
            HighScore = scoreNumber;
            [[NSUserDefaults standardUserDefaults] setInteger:HighScore forKey:@"HighScoreSaved"];
            NewHighScore.hidden = NO;
            ScoreLabel.textColor = [UIColor redColor];
            
        }
        
        
        
    } else if (gameState == kStateMenu) {
        if (previousState != kStateMenu) {
            
            PlayButton.hidden = NO;
            SettingsButton.hidden = NO;
            HighScoreButton.hidden = NO;
            BackButton.hidden = YES;
            
            TrashCan.hidden = YES;
            Cow.hidden = YES;
            Trampoline.hidden = YES;
            LightningBolt.hidden = YES;
            NewHighScore.hidden = YES;
            soundIcon.hidden = YES;
            soundSwitch.hidden = YES;
            DuckJumpLogo.hidden = NO;
            ScoreLabel.hidden = YES;
            
            DuckSkater.image = [UIImage imageNamed:@"Duck.png"];
            DuckSkater.center = CGPointMake(DuckSkater.center.x, BrickWall1.center.y - 124);
            
            ScoreLabel.textColor = [UIColor blackColor];
            ScoreLabel.text = [NSString stringWithFormat:@"%i", scoreNumber];
            
        }
        previousState = kStateMenu;
        
    } else if (gameState == kStateSettings) {
        if (previousState != kStateSettings) {
            PlayButton.hidden = YES;
            SettingsButton.hidden = YES;
            BackButton.hidden = NO;
            HighScoreButton.hidden = YES;
            soundIcon.hidden = NO;
            soundSwitch.hidden = NO;
            
            TrashCan.hidden = YES;
            Cow.hidden = YES;
            Trampoline.hidden = YES;
            LightningBolt.hidden = YES;
            NewHighScore.hidden = YES;
            DuckJumpLogo.hidden = YES;
            ScoreLabel.hidden = YES;
            
            ScoreLabel.textColor = [UIColor blackColor];
            ScoreLabel.text = [NSString stringWithFormat:@"%i", scoreNumber];
            
        }
        previousState = kStateSettings;
        
    } else if (gameState == kStateHighScores) {
        if (previousState != kStateHighScores) {
            PlayButton.hidden = YES;
            SettingsButton.hidden = YES;
            BackButton.hidden = NO;
            HighScoreButton.hidden = YES;
            
            TrashCan.hidden = YES;
            Cow.hidden = YES;
            Trampoline.hidden = YES;
            LightningBolt.hidden = YES;
            NewHighScore.hidden = YES;
            soundIcon.hidden = YES;
            soundSwitch.hidden = YES;
            DuckJumpLogo.hidden = YES;
            ScoreLabel.hidden = NO;
            
            HighScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
            ScoreLabel.textColor = [UIColor redColor];
            ScoreLabel.text = [NSString stringWithFormat:@"%i", HighScore];
            
        }
        previousState = kStateHighScores;
        
    }
    
    
    
    
    
    
    
}




-(void)skaterMove {
    
    
    // Skater Dude Movement
    DuckVelocity.y += gravity.y;
    
    DuckSkater.center = CGPointMake(DuckSkater.center.x, DuckSkater.center.y + DuckVelocity.y);
    
    if (DuckSkater.center.y >= (BrickWall1.center.y - 123)) {
        // Normal
        DuckSkater.center = CGPointMake(DuckSkater.center.x, BrickWall1.center.y - 124);
        DuckVelocity = CGPointMake(0, 0);
        DuckSkater.image = [UIImage imageNamed:@"Duck.png"];
    }
    
    
    // BrickWall Movement
    if (scoreNumber < 10) {
        screenRate = 10;
    } else if (scoreNumber >= 10 && scoreNumber < 30) {
        screenRate = 11;
    } else if (scoreNumber >= 30 && scoreNumber < 60) {
        screenRate = 12;
    } else if (scoreNumber >= 60) {
        screenRate = 13;
    }
    
    BrickWall1.center = CGPointMake(BrickWall1.center.x - screenRate, BrickWall1.center.y);
    BrickWall2.center = CGPointMake(BrickWall2.center.x - screenRate, BrickWall2.center.y);
    BrickWall3.center = CGPointMake(BrickWall3.center.x - screenRate, BrickWall3.center.y);
    BrickWall4.center = CGPointMake(BrickWall4.center.x - screenRate, BrickWall4.center.y);
    BrickWall5.center = CGPointMake(BrickWall5.center.x - screenRate, BrickWall5.center.y);
    BrickWall6.center = CGPointMake(BrickWall6.center.x - screenRate, BrickWall5.center.y);
    BrickWall7.center = CGPointMake(BrickWall7.center.x - screenRate, BrickWall5.center.y);
    BrickWall8.center = CGPointMake(BrickWall8.center.x - screenRate, BrickWall5.center.y);
    
    if (BrickWall1.center.x <= -170) {
        BrickWall1.center = CGPointMake(630, BrickWall1.center.y);
    }
    if (BrickWall2.center.x <= -170) {
        BrickWall2.center = CGPointMake(630, BrickWall2.center.y);
    }
    if (BrickWall3.center.x <= -170) {
        BrickWall3.center = CGPointMake(630, BrickWall3.center.y);
    }
    if (BrickWall4.center.x <= -170) {
        BrickWall4.center = CGPointMake(630, BrickWall4.center.y);
    }
    if (BrickWall5.center.x <= -170) {
        BrickWall5.center = CGPointMake(630, BrickWall5.center.y);
    }
    if (BrickWall6.center.x <= -170) {
        BrickWall6.center = CGPointMake(630, BrickWall6.center.y);
    }
    if (BrickWall7.center.x <= -170) {
        BrickWall7.center = CGPointMake(630, BrickWall7.center.y);
    }
    if (BrickWall8.center.x <= -170) {
        BrickWall8.center = CGPointMake(630, BrickWall8.center.y);
    }
    
    
    
    //TrashCan Movement
    
    TrashCan.center = CGPointMake(TrashCan.center.x - screenRate, TrashCan.center.y);
    
    if (TrashCan.center.x <= -250) {
        RandomNumber = arc4random() %100;
        TrashCan.center = CGPointMake(650 + RandomNumber, TrashCan.center.y);
        OneOrZero = arc4random() %2;
        if (OneOrZero == 1) {
            TrashCan.image = [UIImage imageNamed:@"TrashCan"];
        } else {
            TrashCan.image = [UIImage imageNamed:@"TrashCanNuc"];
        }
    }
    
    //Cow Movement
    
    Cow.center = CGPointMake(Cow.center.x - screenRate, Cow.center.y);
    
    if ( (Cow.center.x <= -250 && Cow.center.x >= -500 )|| (Trampoline.center.x <=-250 && Trampoline.center.x >= -500)) {
        RandomNumber = arc4random() %150;
        RandomOrdering = arc4random() %3;
        if (RandomOrdering != 1) {
            Trampoline.center = CGPointMake(TrashCan.center.x + 300 + RandomNumber, Trampoline.center.y);
            OneOrZero = arc4random() %2;
            if (OneOrZero == 0) {
                LightningBolt.center = CGPointMake(Trampoline.center.x + 200, LightningBolt.center.y);
            }
            Cow.center = CGPointMake(-600, Cow.center.y);
        } else {
            Trampoline.center = CGPointMake(-600, Trampoline.center.y);
            LightningBolt.center = CGPointMake(-600, LightningBolt.center.y);
            Cow.center = CGPointMake(TrashCan.center.x + 300 + RandomNumber, Cow.center.y);
        }
        OneOrZero = arc4random() %2;
        if (OneOrZero == 1) {
            Cow.image = [UIImage imageNamed:@"CowRotated"];
        } else {
            Cow.image = [UIImage imageNamed:@"Cow"];
        }
        
    }
    
    //Trampoline Movement
    
    Trampoline.center = CGPointMake(Trampoline.center.x - screenRate, Trampoline.center.y);
    LightningBolt.center = CGPointMake(LightningBolt.center.x - screenRate, LightningBolt.center.y);
    
    
}




-(void)Collision {
    
    if (CGRectIntersectsRect(DuckSkater.frame, TrashCan.frame)) {
        
        DuckVelocity.y += 10;
        
        DuckSkater.center = CGPointMake(DuckSkater.center.x, DuckSkater.center.y + DuckVelocity.y);
        if (DuckSkater.center.y >= (BrickWall1.center.y - 123)) {
            // Normal
            DuckSkater.center = CGPointMake(DuckSkater.center.x, BrickWall1.center.y - 124);
            DuckVelocity = CGPointMake(0, 0);
            DuckSkater.image = [UIImage imageNamed:@"DuckDie.png"];
            [self gameOver];
        }
        
        
    }
    
    if (CGRectIntersectsRect(DuckSkater.frame, Cow.frame)) {
        
        DuckVelocity.y += 10;
        
        DuckSkater.center = CGPointMake(DuckSkater.center.x, DuckSkater.center.y + DuckVelocity.y);
        if (DuckSkater.center.y >= (BrickWall1.center.y - 123)) {
            // Normal
            DuckSkater.center = CGPointMake(DuckSkater.center.x, BrickWall1.center.y - 124);
            DuckVelocity = CGPointMake(0, 0);
            DuckSkater.image = [UIImage imageNamed:@"DuckDie.png"];
            [self gameOver];
        }
        
        
    }
    
    if (CGRectIntersectsRect(DuckSkater.frame, Trampoline.frame) && (DuckSkater.center.y + 29) < Trampoline.center.y && DuckVelocity.y > 0) {
        
        DuckVelocity.y = -1 * DuckVelocity.y - 10;
        if (soundState == kSoundOn) {
            AudioServicesPlaySystemSound(BoingID);
        }
        
    }
    
    if (CGRectIntersectsRect(DuckSkater.frame, LightningBolt.frame)) {
        
        scoreNumber += 2;
        LightningBolt.center = CGPointMake(-600, LightningBolt.center.y);
        if (soundState == kSoundOn) {
            AudioServicesPlaySystemSound(WoooID);
        }
        
    }
    
    
    
}



-(void)Scoring {
    
    if (TrashCan.center.x < DuckSkater.center.x && TrashCan.center.x >= (DuckSkater.center.x - screenRate)) {
        scoreNumber += 1;
    }
    if (Cow.center.x < DuckSkater.center.x && Cow.center.x >= (DuckSkater.center.x - screenRate)) {
        scoreNumber += 1;
    }
    ScoreLabel.text = [NSString stringWithFormat:@"%i", scoreNumber];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (gameState == kStateRunning) {
        if (DuckSkater.center.y >= (BrickWall1.center.y - 124)) {
            DuckVelocity.y = -25;
            DuckSkater.image = [UIImage imageNamed:@"DuckUp.png"];
            
        }
    }
}



-(void)gameOver {
    
    if (soundState == kSoundOn) {
        AudioServicesPlaySystemSound(QuackID);
    }
    gameState = kStateGameOver;
    

    
    [self gameLoop];
    
    
}






-(IBAction)pressPlay:(id)sender {
    gameState = kStateRunning;
}

-(IBAction)pressHighScores:(id)sender {
    gameState = kStateHighScores;
    
}

-(IBAction)pressSettings:(id)sender {
    gameState = kStateSettings;
    
}

-(IBAction)pressBack:(id)sender {
    gameState = kStateMenu;
    
}

-(IBAction)pressSoundSwitch:(id)sender {
    if (soundSwitch.on) {
        soundState = kSoundOn;
    } else {
        soundState = kSoundOff;
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark iAd Delegate Methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
    
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}



-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    gameState = kStateMenu;
    return YES;
}





@end
