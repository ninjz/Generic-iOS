//
//  GameOverLayer.m
//  Generic
//
//  Created by Calvin Cheng on 2013-01-10.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameOverLayer.h"


@implementation GameOverLayer


-(id)init{
    if((self = [super init])){
        CCLabelTTF *gameOver = [CCLabelTTF labelWithString:@"GAME OVER" fontName:@"Marker Felt" fontSize:40];
        [self addChild:gameOver];
        [gameOver setAnchorPoint:ccp(0.5f,0.5f)];
        [gameOver setPosition:ccp(SCREEN.width/2,SCREEN.height/2)];
        gameOver.color = ccc3(255,215,0);
        

        
        
    }
    return self;
}


-(void)restartLevel{
    
}




@end
