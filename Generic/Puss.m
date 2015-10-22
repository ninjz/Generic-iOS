//
//  Puss.m
//  Generic
//
//  Created by Calvin Cheng on 2013-01-06.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Puss.h"


@implementation Puss : ActionSprite

-(id) init {
    if((self = [super initWithSpriteFrameName: @"OCTOPUS-IDLE-01.png"])){
        //attributes
        _nextDecisionTime = 0;
        
        self.centerToBottom = 64.0;
        self.centerToSides = 64.0;
        self.hitPoints = 50.0;
        self.damage = 10.0;
        self.walkSpeed = 80;
        
        self.hitBox = [self createBoundingBoxWithOrigin:ccp(-(self.centerToSides/2), -(self.centerToBottom/2)) size:CGSizeMake(self.centerToSides, self.centerToBottom)];
        self.attackBox = [self createBoundingBoxWithOrigin:ccp(self.centerToSides, -(self.centerToBottom/2)) size:CGSizeMake(self.centerToSides, self.centerToBottom)];
        
        //ACTIONS
        int i;
        
        //IDLE Animation
        CCArray *idleFrames = [CCArray arrayWithCapacity:2];
        for(i = 1; i < 3; i++ ){
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"OCTOPUS-IDLE-%02d.png", i]];
            [idleFrames addObject:frame];
        }
        CCAnimation *idleAnimation = [CCAnimation animationWithSpriteFrames:[idleFrames getNSArray] delay:1.0/5.0];
        
        self.idleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation: idleAnimation]];
        
        //HURT Animation
        CCArray *hurtFrames = [CCArray arrayWithCapacity:2];
        for(i = 1; i < 3; i++ ){
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"OCTOPUS-RAGE-%02d.png", i]];
            [hurtFrames addObject:frame];
        }
        CCAnimation *hurtAnimation = [CCAnimation animationWithSpriteFrames:[hurtFrames getNSArray] delay:1.0/5.0];
        
        self.hurtAction = [CCSequence actions:[CCAnimate actionWithAnimation:hurtAnimation],[CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        //Walk Animation
       
        self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation: idleAnimation]];
        
        //Attack Animation

        self.attackAction = [CCSequence actions:[CCAnimate actionWithAnimation:hurtAnimation], [CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
    }
    return self;
}

@end
