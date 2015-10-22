//
//  GameScene.h
//  Generic
//
//  Created by Calvin Cheng on 2012-12-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "GameLayer.h"
#import "HudLayer.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameScene : CCScene {
    
}

    @property(nonatomic,weak)GameLayer *gameLayer;
    @property(nonatomic,weak)HudLayer *hudLayer;

@end
