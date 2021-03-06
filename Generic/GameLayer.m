//
//  GameLayer.m
//  Generic
//
//  Created by Calvin Cheng on 2012-12-30.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "Fugu.h"
#import "Puss.h"
#import "Dummy.h"
#import "HudLayer.h"
#import "Camera.h"

@implementation GameLayer


-(id)init {
    if((self = [super init])) {
        self.isTouchEnabled = YES;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"generic.plist" textureFilename:@"generic.png"];
        _actors = [CCSpriteBatchNode batchNodeWithFile:@"generic.png"];
        [_actors.texture setAliasTexParameters];
        [self addChild:_actors z:-5];
        [self initHero];
        _cameraGuy = [Camera node];
        
        
        [self initTileMap];
        _meta = [_tileMap layerNamed:@"META"];
        //_meta.visible = NO;
        
        
        [self scheduleUpdate];
        
        
        
    }
    return self;
}


/** Return the CGPoint tiled map coordinate for the position given. */

- (CGPoint)tileCoordForPosition:(CGPoint)position {
    int x = position.x / _tileMap.tileSize.width;
    int y = ((_tileMap.mapSize.height * _tileMap.tileSize.height) - position.y) / _tileMap.tileSize.height;
    return ccp(x, y);
}



/** Sets the tiled map onto the GameLayer */

-(void)initTileMap{
    _tileMap = [CCTMXTiledMap tiledMapWithTMXFile: @"level2.tmx"];
    for (CCTMXLayer *child in [_tileMap children]){
        [[child texture] setAliasTexParameters];
        
    }
        
    _tileMap.scale = 2.0;
    [self addChild: _tileMap z:-6];
}




/** Initializing all the actors in the scene
 */
-(void)initHero {
    _hero = [Hero node];
    
    [_actors addChild:_hero];
    _hero.position = ccp(_hero.centerToSides, _hero.centerToBottom);
    _hero.desiredPosition = _hero.position;
    [_hero idle];
}





-(void)initEnemies {
    int pussCount = 1;
    _pusses = [[CCArray alloc] initWithCapacity: pussCount];
    int randomChoice = 0;
    
    
    for (int i = 0; i < pussCount; i++) {
        randomChoice = random_range(0,1);
        
        Dummy *puss = [Dummy node];
        [_actors addChild:puss];
        [_pusses addObject:puss];
        int leftSide = (_hero.position.x - (SCREEN.width/2 +30 ));
        int rightSide = (_hero.position.x + (SCREEN.width/2 + 30 ));
        int minY = puss.centerToBottom;
        int maxY = 5 * _tileMap.tileSize.height + puss.centerToBottom;
        if (randomChoice == 0){
             puss.position = ccp(leftSide,random_range(minY,maxY));
        } else {
             puss.position = ccp(rightSide,random_range(minY,maxY));
        }
        puss.desiredPosition = puss.position;
        [puss idle];
        
    }
}





/** Positions all the actors z-positions based on their y-position on the map. */

-(void)reorderActors {
    ActionSprite *sprite;
    CCARRAY_FOREACH(_actors.children, sprite) {
        [_actors reorderChild:sprite z:(_tileMap.mapSize.height * _tileMap.tileSize.height) - sprite.position.y];
    }
}





/* Touch controls */

-(void)simpleDPad:(SimpleDPad *)simpleDPad didChangeDirectionTo:(CGPoint)direction {
    [_hero walkWithDirection:direction];
}

-(void)simpleDPadTouchEnded:(SimpleDPad *)simpleDPad {
    if (_hero.actionState == kActionStateWalk) {
        [_hero idle];
    }
}

-(void)simpleDPad:(SimpleDPad *)simpleDPad isHoldingDirection:(CGPoint)direction {
    [_hero walkWithDirection:direction];
}





//ATTACK BUTTON
-(void)attack:(Button *)button {
    [_hero attack];
}

-(void)holdAttack:(Button *)button {
    
}

-(void)buttonTouchEnded:(Button *)button {
    if (_hero.actionState == kActionStateAttack) {
        [_hero idle];
    }
}




//TEMP Attack button
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_hero attack];
    if (_hero.actionState == kActionStateAttack) {
        Puss *puss;
        CCARRAY_FOREACH(_pusses, puss) {
            if (puss.actionState != kActionStateKnockedOut) {
                if (fabsf(_hero.position.y - puss.position.y) < 10) {
                    if (CGRectIntersectsRect(_hero.attackBox.actual, puss.hitBox.actual)) {
                        [puss hurtWithDamage: _hero.damage];
                    }
                } 
            } 
        }
   
    }
}





/** Basic Enemy AI
 */
-(void)updateEnemies:(ccTime)dt {
    int alive = 0;
    Dummy *puss;
    float distanceSQ;
    int randomChoice = 0;
    CCARRAY_FOREACH(_pusses, puss) {
        [puss update:dt];
        if (puss.actionState != kActionStateKnockedOut) {
            //1
            alive++;
            
            //2
            if (CURTIME > puss.nextDecisionTime) {
                distanceSQ = ccpDistanceSQ(puss.position, _hero.position);
                
                //3
                if (distanceSQ <= 80 * 80 && (fabsf(_hero.position.y - puss.position.y) < 10)) {
                    puss.nextDecisionTime = CURTIME + frandom_range(0.1, 0.5);
                    randomChoice = random_range(0, 2);
                    
                    if (randomChoice < 2) {
                        if (_hero.position.x > puss.position.x) {
                            puss.scaleX = 1.0;
                        } else {
                            puss.scaleX = -1.0;
                        }
                        
                        //4
                        [puss attack];
                        if (puss.actionState == kActionStateAttack) {
                            if (fabsf(_hero.position.y - puss.position.y) < 10) {
                                if (CGRectIntersectsRect(_hero.hitBox.actual, puss.attackBox.actual)) {
                                    [_hero hurtWithDamage:puss.damage];
                                    
                                    //decrease health of player in Health bar
                                    [_hud decreaseHealth:puss.damage];
                                    
                                    
                                }
                            }
                        }
                    } else {
                        [puss idle];
                    }
                } else if (distanceSQ <= SCREEN.width * SCREEN.width) {
                    //5
                    puss.nextDecisionTime = CURTIME + frandom_range(0.5, 1.0);
                    randomChoice = random_range(0, 2);
                    if (randomChoice < 2) {
                        CGPoint moveDirection = ccpNormalize(ccpSub(_hero.position, puss.position));
                        [puss walkWithDirectionEnemy:moveDirection];
                    }
                }
            }
        }
    }
    if(alive == 0 && attackState == YES){
        [_hud moveNow];
        attackState = NO;
    }
}









/** Update Position of the Main Character while also
 updating the position of the cameraGuy object 
 
 1 - MC position update : updates the MC's position with its desired position which was recieved from the SimpleDPad.
 
 2 - Enemy Position update which was updated from the enemy AI.
 
 3 - META check for ActionMarker: 
     @META: the TMXLayer in the tiled map that describes when the camera should stop. 
 
 4 - CameraGuy Controls
 
 */
-(void)updatePositions {
    
    float enemyPosX, enemyPosY;
   
    // 1
    posX = MIN(_tileMap.mapSize.width * _tileMap.tileSize.width - _hero.centerToSides , MAX(_hero.centerToSides, _hero.desiredPosition.x));
    posY = MIN(5 * _tileMap.tileSize.height + _hero.centerToBottom, MAX(_hero.centerToBottom, _hero.desiredPosition.y));
    _hero.position = ccp(posX, posY);
    
    currX = _cameraGuy.position.x;
    currY = 160;
    float startPos = 300;
    
    // 2
    
    
    Puss *puss;
    CCARRAY_FOREACH(_pusses, puss) {
        enemyPosX = MIN(_tileMap.mapSize.width * _tileMap.tileSize.width - puss.centerToSides, MAX(puss.centerToSides, puss.desiredPosition.x));
        enemyPosY = MIN(3 * _tileMap.tileSize.height + puss.centerToBottom, MAX(puss.centerToBottom, puss.desiredPosition.y));
        puss.position = ccp(enemyPosX, enemyPosY);
    }
    
    
    // 3
    CGPoint tileCoord = [self tileCoordForPosition:_hero.position];
    int tileGid = [_meta tileGIDAt:tileCoord];
    if (tileGid) {
        [self toggleAttackEvent:tileGid];
    }
    
    
    // 4
    if ( _hero.position.x <= (startPos)){
         _cameraGuy.position = ccp(startPos, currY);
    } else if (attackState == YES){
        _cameraGuy.position = ccp(currX , currY);
    } else if (attackState == NO) {
        
        _cameraGuy.position = ccp(posX, currY);
    }
}




/** toggles the attack state and starts/stops a screen lock */

-(void)toggleAttackEvent:(int)tileGid {
    NSDictionary *properties = [_tileMap propertiesForGID:tileGid];
    if(properties) {
        NSString *actionState = [properties valueForKey:@"ActionMarker"];
        NSString *stopActionState = [properties valueForKey:@"StopActionMarker"];
        if(actionState && [actionState compare:@"True"] == NSOrderedSame) {
            attackState = YES;
            
        }  else if (stopActionState && [stopActionState compare:@"True"] == NSOrderedSame){
            attackState = NO;
        }
    }
}






-(void)update:(ccTime)dt{
    
    [_hero update:dt];
    if([_hero actionState] == kActionStateDead){    
       [_hud gameOver];
    }
    if(attackState && !sect1Init){
        [self initEnemies];
        sect1Init = YES;
    }
    if(attackState){
        [self updateEnemies:dt];
    }
    
    [self updatePositions];
    [self runAction:[CCFollow actionWithTarget:(_cameraGuy)]];
    [self reorderActors];
}




@end
