//
//  Fugu.m
//  Generic
//
//  Created by Calvin Cheng on 2013-01-02.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Fugu.h"


@implementation Fugu

-(id)init {
    if((self = [super initWithSpriteFrameName: @"xFugu-Idle-01.png"])){
        //attributes
        self.centerToBottom = 64.0;
        self.centerToSides = 64.0;
        self.hitPoints = 50.0;
        self.damage = 10.0;
        self.walkSpeed = 80;
        
        self.hitBox = [self createBoundingBoxWithOrigin:ccp(-(self.centerToSides/2), -(self.centerToBottom/2)) size:CGSizeMake(self.centerToSides, self.centerToBottom)];
        self.attackBox = [self createBoundingBoxWithOrigin:ccp(-(self.centerToSides/2), -(self.centerToBottom/2)) size:CGSizeMake(self.centerToSides, self.centerToBottom)];
        
        //ACTIONS
        int i;
        
        
        //attack Animation
//        CCArray *attackFrames = [CCArray arrayWithCapacity:2];
//        for(i = 1; i < 3; i++ ){
//            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"ENEMY-FUGU-ATTACK-%02d.png", i]];
//            [attackFrames addObject:frame];
//            
//        }
//        
//        CCAnimation *attackAnimation = [CCAnimation animationWithSpriteFrames:[attackFrames getNSArray] delay:1.0/22.0];
//        
//        self.attackAction = [CCSequence actions:[CCAnimate actionWithAnimation:attackAnimation], [CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        //walking Animation
        CCArray *walkFrames = [CCArray arrayWithCapacity:2];
        for(i = 1; i < 3; i++ ){
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"xFugu-Idle-%02d.png", i]];
            [walkFrames addObject:frame];
        }
        CCAnimation *walkAnimation = [CCAnimation animationWithSpriteFrames:[walkFrames getNSArray] delay:1.0/5.0];
        
        self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation: walkAnimation]];
        
        
        
        //hurt animation
        CCArray *hurtFrames = [CCArray arrayWithCapacity:2];
        for( i = 1; i < 3 ; i++ ) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"xFugu-Attack-%02d.png", i]];
            [hurtFrames addObject:frame];
        }
        CCAnimation *hurtAnimation = [CCAnimation animationWithSpriteFrames:[hurtFrames getNSArray] delay:1.0/12.0];
        self.hurtAction = [CCSequence actions:[CCAnimate actionWithAnimation:hurtAnimation], [CCCallFunc actionWithTarget:self selector:@selector(walk)], nil];
        
        
        
//        //knocked out animation
//        CCArray *knockedOutFrames = [CCArray arrayWithCapacity:2];
//        for (i = 0; i < 3; i++) {
//            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"ENEMY-FUGU-ATTACK%02d.png", i]];
//            [knockedOutFrames addObject:frame];
//        }
//        CCAnimation *knockedOutAnimation = [CCAnimation animationWithSpriteFrames:[knockedOutFrames getNSArray] delay:1.0/12.0];
//        self.knockedOutAction = [CCSequence actions:[CCAnimate actionWithAnimation:knockedOutAnimation], [CCBlink actionWithDuration:2.0 blinks:10.0], nil];
        
        
    }
    return self;
}


@end
