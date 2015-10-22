//
//  GameLayer.h
//  Generic
//
//  Created by Calvin Cheng on 2012-12-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HudLayer.h"
#import "Button.h"
#import "Hero.h"
#import "Fugu.h"
#import "Puss.h"
#import "Dummy.h"

@interface GameLayer : CCLayer <SimpleDPadDelegate, ButtonDelegate> {
    CCTMXTiledMap *_tileMap;
    CCTMXLayer *_meta;
    Fugu  *_cameraGuy;
    BOOL attackState;
    BOOL sect1Init;
    
    CCSpriteBatchNode *_actors;
    Hero *_hero;
    CGPoint mainCharOrigin;
    
    float posX, posY, currY, currX;

}

@property(nonatomic,weak)HudLayer *hud;
@property(nonatomic,strong)CCArray *fugus;
@property(nonatomic,strong)CCArray *pusses;


@end
