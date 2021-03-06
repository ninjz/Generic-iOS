//
//  HudLayer.m
//  Generic
//
//  Created by Calvin Cheng on 2012-12-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HudLayer.h"
#import "GameOverLayer.h"


@implementation HudLayer

-(id)init{
    if((self = [super init])){
       
    //Cache of sprites needed for the HUD
       [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"HUD.plist" textureFilename:@"HUD.png"];

    //DPad
        _dPad = [SimpleDPad dPadWithFile:@"Direction Button (not filled).png" radius:64];
        _dPad.position = ccp(64.0, 64.0);
        _dPad.opacity = 85;
        _dPad.scale = 3.0;
        [self addChild:_dPad];
        
    //HEALTH BAR
        CGPoint healthBarPosition = ccp(110,280);
        currHealth = 100;
        
        
        _healthGreen = [CCSprite spriteWithSpriteFrameName:@"health_green.png"];
        healthBar = [CCProgressTimer progressWithSprite:_healthGreen];
        [healthBar setPosition:ccp(healthBarPosition.x + 1,healthBarPosition.y)];
        healthBar.scale = 0.8;
        healthBar.scaleX = 0.84;
        healthBar.type = kCCProgressTimerTypeBar;
        healthBar.barChangeRate = ccp(1,0);
        
        healthBar.midpoint = ccp(0.0,0.0f);
        [healthBar setPercentage:100];
        [self addChild:healthBar z:0];

        CCSprite *frame = [CCSprite spriteWithSpriteFrameName:@"Healthbar-Frame.png"];
        [frame setPosition:healthBarPosition];
        frame.scale = 0.85;
        frame.opacity = 2000;
        [self addChild:frame z:1];
        
    //MOOLAH COUNTER
        
    }
    return self;
}

/** Enables the Go Arrow */

-(void)moveNow {

    id blinkAction = [CCBlink actionWithDuration:2.0 blinks:10.0];
    _goSign = [CCSprite spriteWithSpriteFrameName:@"Arrow_03.png"];
    _goSign.position = ccp(SCREEN.width - 60, SCREEN.height/2);
    _goSign.scale = 4.0;
    [_goSign.texture setAliasTexParameters];
    [self addChild:_goSign];
    
    [_goSign runAction:[CCSequence actions: blinkAction, [CCCallFuncND actionWithTarget:_goSign
                                                                               selector:@selector(removeFromParentAndCleanup:)
                                                                                   data:(void*)NO], nil]];
    
}

-(void)initButton {
    
}


/** Decreases the image of the health shown to represent the player health
 *
 */

-(void)decreaseHealth:(float) damage {
    currHealth -= damage;
    if(currHealth <= 60 && currHealth >= 40){
        [healthBar setSprite:[CCSprite spriteWithSpriteFrameName:@"health_yellow.png"]];
            
    } if (currHealth < 39){
        [healthBar setSprite:[CCSprite spriteWithSpriteFrameName:@"health_red.png"]];
    }
    
    [healthBar setPercentage:currHealth];

}





-(void)gameOver{
    [[CCDirector sharedDirector] pause];
    CCLayer *gameOver = [GameOverLayer node];
    [self addChild:gameOver];
}




@end
