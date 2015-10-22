//
//  HudLayer.h
//  Generic
//
//  Created by Calvin Cheng on 2012-12-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleDPad.h"
#import "Button.h"


@interface HudLayer : CCLayer {
    float currHealth;
    CCSpriteBatchNode *_HUD;
    CCProgressTimer *healthBar;
}

@property(nonatomic,weak)SimpleDPad *dPad;
@property(nonatomic,weak)Button *button;
@property(nonatomic,weak)CCSprite *attackButton;

@property(nonatomic, weak)CCSprite *healthGreen;
@property(nonatomic, weak)CCSprite *healthYellow;
@property(nonatomic, weak)CCSprite *healthRed;

@property(nonatomic, weak)CCSprite *goSign;

-(void)moveNow;
-(void)decreaseHealth:(float) damage;
-(void)gameOver;

@end
