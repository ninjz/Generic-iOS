//
//  Hero.m
//  Generic
//
//  Created by Calvin Cheng on 2012-12-31.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Hero.h"


@implementation Hero

-(id)init {
    if((self = [super initWithSpriteFrameName: @"xFistUp-Idle-01.png"])){
        //attributes
        self.centerToBottom = 54;
        self.centerToSides = 30;
        self.hitPoints = 100.0;
        self.damage = 25.0;
        self.walkSpeed = 80;
        
        self.hitBox = [self createBoundingBoxWithOrigin:ccp( -self.centerToSides, -self.centerToBottom ) size:CGSizeMake(self.centerToSides * 2 , self.centerToBottom * 2)];
        self.attackBox = [self createBoundingBoxWithOrigin:ccp(self.centerToSides, 10) size:CGSizeMake(20, 20)];
        
        
        
        //ACTIONS
        int i;
        
        //Idle Animation
        CCArray *idleFrames = [CCArray arrayWithCapacity:2];
        for (i = 1; i < 3; i++) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"xFistUp-Idle-%02d.png", i]];
            [idleFrames addObject:frame];
        }
        
        CCAnimation *idleAnimation = [CCAnimation animationWithSpriteFrames:[idleFrames getNSArray] delay:1.0/2.0]; //12 frames per second
        
        self.idleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAnimation]];
   
        //uppercut Animation
        CCArray *attackFrames = [CCArray arrayWithCapacity:5];
        for(i = 1; i < 6; i++ ){
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"xFistUp-Attack-%02d.png", i]];
            [attackFrames addObject:frame];
            
        }
        
        CCAnimation *attackAnimation = [CCAnimation animationWithSpriteFrames:[attackFrames getNSArray] delay:1.0/22.0];
        
        self.attackAction = [CCSequence actions:[CCAnimate actionWithAnimation:attackAnimation], [CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        
    
        //Continuous Walk animation
    
        CCArray *walkFrames = [CCArray arrayWithCapacity:4];
        for(i = 1; i < 5; i++ ){
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"xFistUp-Walk-%02d.png", i]];
            [walkFrames addObject:frame];
        }
        CCAnimation *walkAnimation = [CCAnimation animationWithSpriteFrames:[walkFrames getNSArray] delay:1.0/8.0];
    
        self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation: walkAnimation]];
    
    
        //hurt animation
        CCArray *hurtFrames = [CCArray arrayWithCapacity:2];
        for (i = 1; i < 3; i++) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"xHurt-%02d.png", i]];
            [hurtFrames addObject:frame];
        }
        CCAnimation *hurtAnimation = [CCAnimation animationWithSpriteFrames:[hurtFrames getNSArray] delay:1.0/12.0];
        self.hurtAction = [CCSequence actions:[CCAnimate actionWithAnimation:hurtAnimation], [CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        
        
        //knocked out animation
        CCArray *knockedOutFrames = [CCArray arrayWithCapacity:3];
        for (i = 1; i < 4; i++) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"xDeath-%02d.png", i]];
            [knockedOutFrames addObject:frame];
        }
        CCAnimation *knockedOutAnimation = [CCAnimation animationWithSpriteFrames:[knockedOutFrames getNSArray] delay:1.0/12.0];
        self.knockedOutAction = [CCSequence actions:[CCAnimate actionWithAnimation:knockedOutAnimation], [CCBlink actionWithDuration:2.0 blinks:10.0],[CCDelayTime actionWithDuration:.5] , [CCCallFunc actionWithTarget:self selector:@selector(dead)], nil];
        
        
    }
    return self;
}

-(void)dead{
    self.actionState = kActionStateDead;
}



@end
